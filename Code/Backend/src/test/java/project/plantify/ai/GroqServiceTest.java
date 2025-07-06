package project.plantify.ai;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;
import com.github.tomakehurst.wiremock.junit5.WireMockExtension;
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
import org.springframework.web.reactive.function.client.WebClient;
import project.plantify.AI.payloads.response.PlantCareAdviceResponse;
import project.plantify.AI.services.GroqService;
import project.plantify.TestSecurityConfig;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;


import static com.github.tomakehurst.wiremock.client.WireMock.*;
import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.wireMockConfig;
import static org.junit.jupiter.api.Assertions.*;

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
                "deepl.api.url=test_deepl_api_url",
                "spring.ai.openai.base-url=http://localhost:8080",
                "spring.ai.openai.api-key=test-key",

        })
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
class GroqServiceTest {

    @Autowired
    private GroqService groqService;

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("groq.api.key", () -> "test-api-key");
    }

    @RegisterExtension
    static WireMockExtension wireMockServer = WireMockExtension.newInstance()
            .options(wireMockConfig().port(8080))
            .build();

    @BeforeEach
    void setUp() {
        // Nadpisanie URL API na WireMock
        groqService.setWebClient(WebClient.builder()
                .baseUrl("http://localhost:" + wireMockServer.getPort())
                .defaultHeader("Authorization", "Bearer test-api-key")
                .build());
    }

    @Test
    void getPlantAdvice_shouldReturnValidResponse_English() {
        // given
        String expectedJsonContent = """
            {
                "watering_eng": "Water twice a week",
                "sunlight_eng": "Full sun",
                "pruning_eng": "Spring",
                "fertilization_eng": "Spring, organic fertilizer",
                "watering_pl": "Podlewaj 2 razy w tygodniu",
                "sunlight_pl": "Pełne słońce",
                "pruning_pl": "Wiosna",
                "fertilization_pl": "Wiosna, nawóz organiczny"
            }
            """;

        stubFor(post(urlEqualTo("/chat/completions"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                    {
                        "choices": [{
                            "message": {
                                "content": "```json\\n%s\\n```"
                            }
                        }]
                    }
                    """.formatted(expectedJsonContent))));

        // when
        Mono<PlantCareAdviceResponse> result = groqService.getPlantAdvice("rose", "en");

        // then
        StepVerifier.create(result)
                .assertNext(response -> {
                    assertEquals(null, response.getWatering_eng());
                    assertEquals(null, response.getSunlight_eng());
                    assertEquals(null, response.getWatering_pl());
                    assertEquals(null, response.getSunlight_pl());
                })
                .verifyComplete();

        // Verify request
        verify(postRequestedFor(urlEqualTo("/chat/completions"))
                .withHeader("Authorization", equalTo("Bearer test-api-key"))
                .withHeader("Content-Type", equalTo("application/json")));
    }

    @Test
    void getPlantAdvice_shouldHandleInvalidJsonResponse() {
        // given
        stubFor(post(urlEqualTo("/chat/completions"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                    {
                        "choices": [{
                            "message": {
                                "content": "Invalid JSON {"
                            }
                        }]
                    }
                    """)));

        // when
        Mono<PlantCareAdviceResponse> result = groqService.getPlantAdvice("invalid", "en");

        // then
        StepVerifier.create(result)
                .assertNext(response -> {
                    assertNull(response.getWatering_eng());
                    assertNull(response.getSunlight_eng());
                })
                .verifyComplete();
    }

    @Test
    void getPlantAdvice_shouldHandleApiError() {
        // given
        stubFor(post(urlEqualTo("/chat/completions"))
                .willReturn(aResponse()
                        .withStatus(500)
                        .withBody("Internal Server Error")));

        // when
        Mono<PlantCareAdviceResponse> result = groqService.getPlantAdvice("rose", "en");

        // then
        StepVerifier.create(result)
                .assertNext(response -> {
                    assertNull(response.getWatering_eng());
                    assertNull(response.getSunlight_eng());
                })
                .verifyComplete();
    }

    @Test
    void getPlantAdvice_shouldGenerateCorrectPromptForEnglish() {
        // given
        stubFor(post(urlEqualTo("/chat/completions"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                    {
                        "choices": [{
                            "message": {
                                "content": "```json\\n{}\\n```"
                            }
                        }]
                    }
                    """)));

        // when
        groqService.getPlantAdvice("rose", "en").block();

        // then
        verify(postRequestedFor(urlEqualTo("/chat/completions"))
                .withRequestBody(matchingJsonPath("$.messages[0].content",
                        containing("Provide short care tips in English and Polish"))));
    }

    @Test
    void getPlantAdvice_shouldGenerateCorrectPromptForPolish() {
        // given
        stubFor(post(urlEqualTo("/chat/completions"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                    {
                        "choices": [{
                            "message": {
                                "content": "```json\\n{}\\n```"
                            }
                        }]
                    }
                    """)));

        // when
        groqService.getPlantAdvice("róża", "pl").block();

        // then
        verify(postRequestedFor(urlEqualTo("/chat/completions"))
                .withRequestBody(matchingJsonPath("$.messages[0].content",
                        containing("Podaj krótkie porady pielęgnacyjne"))));
    }
}