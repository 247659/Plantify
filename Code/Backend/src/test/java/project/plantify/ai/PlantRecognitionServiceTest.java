package project.plantify.ai;

import com.github.tomakehurst.wiremock.client.WireMock;
import com.github.tomakehurst.wiremock.junit5.WireMockExtension;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import project.plantify.AI.exceptions.*;
import project.plantify.AI.payloads.request.PhotoUrlRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import project.plantify.AI.services.AIService;
import project.plantify.TestSecurityConfig;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

import static com.github.tomakehurst.wiremock.client.WireMock.*;
import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.wireMockConfig;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        properties = {
                "spring.profiles.active=test",
                "spring.datasource.url=jdbc:h2:mem:testdb",
                "spring.datasource.driver-class-name=org.h2.Driver",
                "spring.jpa.hibernate.ddl-auto=create-drop",
                "supabase.jwt.secret=test_jwt_secret",
                "plant.api.token=test_api_token",
                "groq.api.key=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",
                "deepl.api.key=test_deepl_api_key",
                "deepl.api.url=test_deepl_api_url"
        }
)
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
public class PlantRecognitionServiceTest {

    @Autowired
    protected AIService aiService;

    @RegisterExtension
    static WireMockExtension wireMockExtension = WireMockExtension.newInstance()
            .options(wireMockConfig().port(8080))
            .build();

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("plant.net.api.key", () -> "test-api-key");
    }

    @BeforeEach
    void setUp() {
        aiService.setWebClient(WebClient.builder()
                .baseUrl("http://localhost:" + wireMockExtension.getPort())
                .defaultHeader("Authorization", "Bearer test-api-key")
                .build());
    }


    @Test
    void getPlantByUrlTest() throws IOException {
        wireMockExtension.stubFor(post(urlPathEqualTo("/all"))
                .withQueryParam("nb-results", equalTo("1"))
                .withQueryParam("lang", equalTo("en"))
                .withQueryParam("api-key", equalTo("test-api-key"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                          "bestMatch": "Polypodium vulgare",
                          "confidence": 0.95
                        }
                    """)));

        URL imageUrl = new URL("https://przyrodniczo.pl/wp-content/uploads/2020/06/paprotka_02.jpg");
        PhotoUrlRequest request = new PhotoUrlRequest(imageUrl, "auto", "en");

        Mono<PhotoAnalysisResponse> response = aiService.analyzePhotoUrl(request);

        StepVerifier.create(response)
                .assertNext(res -> {
                    assertEquals("Polypodium vulgare", res.getBestMatch());
                })
                .verifyComplete();
    }

    @Test
    void getPlantUnsupportedTest() throws IOException {
        wireMockExtension.stubFor(post(urlPathEqualTo("/all"))
                .withQueryParam("nb-results", equalTo("1"))
                .withQueryParam("lang", equalTo("en"))
                .withQueryParam("api-key", equalTo("test-api-key"))
                .willReturn(aResponse()
                        .withStatus(415)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                          "error": "Unsupported Media Type"
                        }
                    """)));

        URL imageUrl = new URL("https://cke.gov.pl/images/plik.pdf");
        PhotoUrlRequest request = new PhotoUrlRequest(imageUrl, "auto", "en");

        assertThrows(UnsupportedMediaTypeException.class, () -> aiService.analyzePhotoUrl(request));
    }

    @Test
    void getPlantUnrecognizedExceptionTest() throws IOException {
        wireMockExtension.stubFor(post(urlPathEqualTo("/all"))
                .withQueryParam("nb-results", equalTo("1"))
                .withQueryParam("lang", equalTo("en"))
                .withQueryParam("api-key", equalTo("test-api-key"))
                .willReturn(aResponse()
                        .withStatus(404)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                          "error": "Unrecognized Plant"
                        }
                    """)));

        URL imageUrl = new URL("https://przyrodniczo.pl/wp-content/uploads/2020/06/paprotka_02.jpg");
        PhotoUrlRequest request = new PhotoUrlRequest(imageUrl, "auto", "en");

        Mono<PhotoAnalysisResponse> response = aiService.analyzePhotoUrl(request);
        StepVerifier.create(response)
                .expectErrorMatches(error ->
                        error instanceof UnrecognizedPlantException)
                .verify();
    }

    @Test
    void getPlantMaxSizeExceptionTest() throws IOException {
        wireMockExtension.stubFor(post(urlPathEqualTo("/all"))
                .withQueryParam("nb-results", equalTo("1"))
                .withQueryParam("lang", equalTo("en"))
                .withQueryParam("api-key", equalTo("test-api-key"))
                .willReturn(aResponse()
                        .withStatus(413)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                          "error": "MaxSizeExceeded"
                        }
                    """)));

        URL imageUrl = new URL("https://przyrodniczo.pl/wp-content/uploads/2020/06/paprotka_02.jpg");
        PhotoUrlRequest request = new PhotoUrlRequest(imageUrl, "auto", "en");

        Mono<PhotoAnalysisResponse> response = aiService.analyzePhotoUrl(request);
        StepVerifier.create(response)
                .expectErrorMatches(error ->
                        error instanceof MaxSizeException)
                .verify();
    }

    @Test
    void getPlantEmptyExceptionTest() throws IOException {
        wireMockExtension.stubFor(post(urlPathEqualTo("/all"))
                .withQueryParam("nb-results", equalTo("1"))
                .withQueryParam("lang", equalTo("en"))
                .withQueryParam("api-key", equalTo("test-api-key"))
                .willReturn(aResponse()
                        .withStatus(500)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                        {
                          "error": "MaxSizeExceeded"
                        }
                    """)));

        URL imageUrl = new URL("https://przyrodniczo.pl/wp-content/uploads/2020/06/paprotka_02.jpg");
        PhotoUrlRequest request = new PhotoUrlRequest(imageUrl, "auto", "en");

        Mono<PhotoAnalysisResponse> response = aiService.analyzePhotoUrl(request);
        StepVerifier.create(response)
                .expectErrorMatches(error ->
                        error instanceof PhotoAnalysisException)
                .verify();
    }


}
