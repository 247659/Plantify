package project.plantify.ai;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;
import com.github.tomakehurst.wiremock.junit5.WireMockExtension;
import jakarta.servlet.ServletException;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.util.NestedServletException;
import project.plantify.AI.payloads.response.GroqResponse;
import project.plantify.AI.services.GroqService;
import project.plantify.TestSecurityConfig;
import reactor.core.publisher.Mono;

import java.util.List;

import static com.github.tomakehurst.wiremock.client.WireMock.aResponse;
import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.wireMockConfig;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        properties = {
                "spring.profiles.active=test",
                "spring.datasource.url=jdbc:h2:mem:testdb",
                "spring.datasource.driver-class-name=org.h2.Driver",
                "spring.jpa.hibernate.ddl-auto=create-drop",
                "supabase.jwt.secret=test_jwt_secret",
                "plant.api.token=test_api_token",
                "plant.net.api.key=test_net_api_key",
                "groq.api.key=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",
                "deepl.api.key=test_deepl_api_key",
                "deepl.api.url=test_deepl_api_url"
        }
)
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
public class GroqControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @RegisterExtension
    static WireMockExtension wireMockServer = WireMockExtension.newInstance()
            .options(wireMockConfig().port(8080))
            .build();

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        // jeśli Twój serwis używa jakiegoś baseUrl do Groq API itp, ustaw tutaj:
        registry.add("groq.api.url", wireMockServer::baseUrl);
    }

    private GroqService groqService;
    private GroqService groqServiceSpy;

    @BeforeEach
    void setup() {
        groqService = new GroqService();
        //groqService.objectMapper = new ObjectMapper();

        // Spy na serwis, aby podmienić askGroq()
        groqServiceSpy = spy(groqService);
    }

    @Test
    void shouldReturnFailedToParseResponseWhenJsonMalformed() throws Exception {
        String species = "rose";
        String language = "en";

        // Zamockuj askGroq, aby zwróciło zły JSON, który wywoła wyjątek przy parsowaniu
        doReturn(Mono.just("{malformed json")).when(groqServiceSpy).askGroq(anyString());

        // Zamockuj parseShoppingList, żeby zwracało np. listę z jednym elementem, żeby testować dalej
        doAnswer(invocation -> {
            String input = invocation.getArgument(0);
            // Sprawdź, że wejście to "Failed to parse response"
            assertEquals("Failed to parse response", input);
            return List.of(new GroqResponse("Failed to parse response"));
        }).when(groqServiceSpy).parseShoppingList(anyString());

        List<GroqResponse> result = groqServiceSpy.generateShoppingList(species, language);

        assertNotNull(result);
        assertFalse(result.isEmpty());
        assertEquals("Failed to parse response", result.get(0).getResponse());
    }

    @Test
    void shouldGenerateShoppingListEn() throws Exception {
        String species = "apple";
        String lang = "en";

        wireMockServer.stubFor(WireMock.get(WireMock.urlPathEqualTo("/api/plantify/ai/generateShoppingList"))
                .withQueryParam("species", WireMock.equalTo(species))
                .withHeader("Lang", WireMock.equalTo(lang))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                                [
                                    {"response": "apple"},
                                    {"response": "banana"}
                                ]
                                """)
                ));

        mockMvc.perform(get("/api/plantify/ai/generateShoppingList")
                        .param("species", species)
                        .header("Lang", lang))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].response").exists())
                .andExpect(jsonPath("$[0].response").isNotEmpty())
                .andExpect(jsonPath("$[1].response").exists())
                .andExpect(jsonPath("$[1].response").isNotEmpty());
    }

    @Test
    void shouldGenerateShoppingListPl() throws Exception {
        String species = "banan";
        String lang = "pl";

        wireMockServer.stubFor(WireMock.get(WireMock.urlPathEqualTo("/api/plantify/ai/generateShoppingList"))
                .withQueryParam("species", WireMock.equalTo(species))
                .withHeader("Lang", WireMock.equalTo(lang))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                                [
                                    {"response": "apple"},
                                    {"response": "banana"}
                                ]
                                """)
                ));

        mockMvc.perform(get("/api/plantify/ai/generateShoppingList")
                        .param("species", species)
                        .header("Lang", lang))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].response").exists())
                .andExpect(jsonPath("$[0].response").isNotEmpty())
                .andExpect(jsonPath("$[1].response").exists())
                .andExpect(jsonPath("$[1].response").isNotEmpty());
    }

    @Test
    void shouldGenerateShoppingListNoLang() throws Exception {
        String species = "banan";
        String lang = "aa";

        wireMockServer.stubFor(WireMock.get(WireMock.urlPathEqualTo("/api/plantify/ai/generateShoppingList"))
                .withQueryParam("species", WireMock.equalTo(species))
                .withHeader("Lang", WireMock.equalTo(lang))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                                [
                                    {"response": "apple"},
                                    {"response": "banana"}
                                ]
                                """)
                ));


        ServletException thrown = assertThrows(ServletException.class, () -> {
            mockMvc.perform(get("/api/plantify/ai/generateShoppingList")
                            .param("species", species)
                            .header("Lang", lang))
                    .andReturn();
        });

        Throwable rootCause = thrown.getCause();
        // Upewnij się, że wyjątek przyczyny jest tym, czego oczekujesz
        assertNotNull(rootCause);
        assertTrue(rootCause.getMessage().contains("No language"));
    }


}
