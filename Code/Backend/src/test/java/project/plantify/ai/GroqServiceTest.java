package project.plantify.ai;

import com.github.tomakehurst.wiremock.junit5.WireMockExtension;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
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

    @RegisterExtension
    static WireMockExtension wireMock = WireMockExtension.newInstance()
            .options(wireMockConfig().port(8080))
            .build();

    @MockitoBean
    private GroqService groqService;

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("groq.api.baseUrl", wireMock::baseUrl);
        registry.add("groq.api.key", () -> "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");
    }

    @BeforeEach
    void setUp() {
        groqService.init();
    }

    @Test
    void getPlantAdvice_shouldReturnValidResponse_English() {
        // given
        String species = "rose";
        String language = "en";

        wireMock.stubFor(post(urlEqualTo("/chat/completions"))
                .withHeader("Authorization", equalTo("Bearer test-api-key"))
                .willReturn(aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                            "choices": [{
                                "message": {
                                    "content": {
                                        "watering_eng": "Water twice a week",
                                        "sunlight_eng": "Full sun",
                                        "pruning_eng": "Spring",
                                        "fertilization_eng": "Spring, organic fertilizer",
                                        "watering_pl": "Podlewaj 2 razy w tygodniu",
                                        "sunlight_pl": "Pełne słońce",
                                        "pruning_pl": "Wiosna",
                                        "fertilization_pl": "Wiosna, nawóz organiczny"
                                    }
                                }
                            }]
                        }
                        """)));

        // when
        Mono<PlantCareAdviceResponse> result = groqService.getPlantAdvice(species, language);

        // then
        StepVerifier.create(result)
                .assertNext(response -> {
                    assertEquals("Water twice a week", response.getWatering_eng());
                    assertEquals("Full sun", response.getSunlight_eng());
                    assertEquals("Podlewaj 2 razy w tygodniu", response.getWatering_pl());
                    assertEquals("Pełne słońce", response.getSunlight_pl());
                })
                .verifyComplete();
    }

    @Test
    void getPlantAdvice_shouldReturnValidResponse_Polish() {
        // given
        String species = "róża";
        String language = "pl";

        wireMock.stubFor(post(urlEqualTo("/chat/completions"))
                .withHeader("Authorization", equalTo("Bearer test-api-key"))
                .willReturn(aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                            "choices": [{
                                "message": {
                                    "content": {
                                        "watering_eng": "Water twice a week",
                                        "sunlight_eng": "Full sun",
                                        "pruning_eng": "Spring",
                                        "fertilization_eng": "Spring, organic fertilizer",
                                        "watering_pl": "Podlewaj 2 razy w tygodniu",
                                        "sunlight_pl": "Pełne słońce",
                                        "pruning_pl": "Wiosna",
                                        "fertilization_pl": "Wiosna, nawóz organiczny"
                                    }
                                }
                            }]
                        }
                        """)));

        // when
        Mono<PlantCareAdviceResponse> result = groqService.getPlantAdvice(species, language);

        // then
        StepVerifier.create(result)
                .assertNext(response -> {
                    assertEquals("Podlewaj 2 razy w tygodniu", response.getWatering_pl());
                    assertEquals("Pełne słońce", response.getSunlight_pl());
                })
                .verifyComplete();
    }


    @Test
    void getPlantAdvice_shouldHandleError() {
        // given
        String species = "invalid";
        String language = "en";

        wireMock.stubFor(post(urlEqualTo("/chat/completions"))
                .withHeader("Authorization", equalTo("Bearer test-api-key"))
                .willReturn(aResponse()
                        .withStatus(500)
                        .withBody("Internal Server Error")));

        // when
        Mono<PlantCareAdviceResponse> result = groqService.getPlantAdvice(species, language);

        // then
        StepVerifier.create(result)
                .assertNext(response -> {
                    assertNull(response.getWatering_eng());
                    assertNull(response.getSunlight_eng());
                    assertNull(response.getWatering_pl());
                    assertNull(response.getSunlight_pl());
                })
                .verifyComplete();
    }


}