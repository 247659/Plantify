package project.plantify.ai;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.WebFluxTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.reactive.server.WebTestClient;
import project.plantify.AI.controllers.AIController;
import project.plantify.AI.payloads.request.PhotoUrlRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import project.plantify.AI.payloads.response.PlantCareAdviceResponse;
import project.plantify.AI.services.AIService;
import project.plantify.AI.services.GroqService;
import project.plantify.TestSecurityConfig;
import reactor.core.publisher.Mono;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

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
class AIControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @MockitoBean
    private AIService aiService;

    @MockitoBean
    private GroqService groqService;

    @Test
    void testGetSpeciesByUrl_shouldReturnExpectedResponse() throws MalformedURLException {
        // --- Arrange ---
        URL photoUrl = new URL("https://example.com/plant.jpg");
        PhotoUrlRequest request = new PhotoUrlRequest(photoUrl, "leaf", "pl");

        // Mock response from aiService.analyzePhotoUrl
        PhotoAnalysisResponse.Species species = new PhotoAnalysisResponse.Species();
        species.setScientificNameWithoutAuthor("Ficus lyrata");
        species.setCommonNames(List.of("Fiddle Leaf Fig"));

        PhotoAnalysisResponse.Result result = new PhotoAnalysisResponse.Result();
        result.setSpecies(species);

        PhotoAnalysisResponse photoAnalysisResponse = new PhotoAnalysisResponse();
        photoAnalysisResponse.setResults(result);

        Mockito.when(aiService.analyzePhotoUrl(Mockito.any()))
                .thenReturn(Mono.just(photoAnalysisResponse));

        // Mock response from groqService.getPlantAdvice
        PlantCareAdviceResponse advice = new PlantCareAdviceResponse();
        advice.setWatering_eng("Water weekly");
        advice.setSunlight_eng("Bright indirect light");
        advice.setPruning_eng("Prune in spring");
        advice.setFertilization_eng("Fertilize monthly");
        advice.setWatering_pl("Podlewaj co tydzień");
        advice.setSunlight_pl("Jasne, rozproszone światło");
        advice.setPruning_pl("Przycinaj na wiosnę");
        advice.setFertilization_pl("Nawóz raz w miesiącu");

        Mockito.when(groqService.getPlantAdvice(Mockito.anyString(), Mockito.anyString()))
                .thenReturn(Mono.just(advice));

        // --- Act & Assert ---
        webTestClient.post()
                .uri("/api/plantify/ai/getSpeciesByUrl")
                .header("Accept-Language", "pl")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue("""
                        {
                          "url": "https://example.com/plant.jpg"
                        }
                        """)
                .exchange()
                .expectStatus().isOk()
                .expectBody()
                .jsonPath("$.watering_eng").isEqualTo("Water weekly")
                .jsonPath("$.sunlight_pl").isEqualTo("Jasne, rozproszone światło");
    }
}
