package project.plantify.AI.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import project.plantify.AI.payloads.response.GroqResponse;
import reactor.core.publisher.Mono;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Setter
@Getter
public class GroqService {

    private WebClient webClient;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${groq.api.key}")
    private String apiKey;

    @PostConstruct
    public void init() {
        System.out.println("Initializing Groq API");
        System.out.println(apiKey);
        this.webClient = WebClient.builder()
                .baseUrl("https://api.groq.com/openai/v1")
                .defaultHeader("Authorization", "Bearer " + apiKey)
                .build();
    }

    public Mono<String> askGroq(String prompt) {
        return webClient.post()
                .uri("/chat/completions")
                .header("Authorization", "Bearer " + apiKey)
                .bodyValue(Map.of(
                        "model", "llama-3.3-70b-versatile",
                        "messages", List.of(
                                Map.of("role", "system", "content", "You are a helpful real estate assistant."),
                                Map.of("role", "user", "content", prompt)
                        )
                ))
                .retrieve()
                .bodyToMono(String.class);
    }

    public List<GroqResponse> parseShoppingList(String responseText) {
        return Arrays.stream(responseText.split("\n"))
                .map(line -> line.replaceFirst("^\\*\\s*", ""))
                .map(GroqResponse::new)
                .collect(Collectors.toList());
    }

    public List<GroqResponse> generateShoppingList(String species, String language) throws Exception {
        String prompt;
        if (language.equals("en")) {
            prompt = String.format(
                    "You are a professional botanist. A person has a plant of the species '%s'. " +
                            "Generate a short shopping list of essential items needed to properly care for this plant. " +
                            "Include only the product names (e.g., soil type, pots, fertilizers, watering tools, pest protection, special care accessories). " +
                            "Format the response strictly as a concise bullet point list without extra explanations.",
                    species
            );
        } else if (language.equals("pl")) {
            prompt = String.format(
                    "Jesteś profesjonalnym botanikiem. Osoba posiada roślinę gatunku '%s'. " +
                            "Wygeneruj krótką listę zakupów niezbędnych do jej prawidłowej pielęgnacji. " +
                            "Uwzględnij tylko nazwy produktów (np. typ ziemi, doniczki, nawozy, narzędzia do podlewania, środki ochrony przed szkodnikami, akcesoria specjalne). " +
                            "Sformatuj odpowiedź jako listę punktowaną, bez dodatkowych wyjaśnień. Odpowiedz po polsku.",
                    species
            );
        } else {
            throw new Exception("No language");
        }


        String responseText = askGroq(prompt)
                .map(responseJson -> {
                    try {
                        JsonNode root = objectMapper.readTree(responseJson);
                        return root.get("choices")
                                .get(0)
                                .get("message")
                                .get("content")
                                .asText()
                                .trim();
                    } catch (Exception e) {
                        e.printStackTrace();
                        return "Failed to parse response";
                    }
                })
                .block();
        return parseShoppingList(responseText);
    }
}
