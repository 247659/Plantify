package project.plantify.ai;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import project.plantify.AI.exceptions.AIResponseException;
import project.plantify.AI.payloads.response.PlantCareAdviceResponse;
import project.plantify.AI.services.GroqService;
import project.plantify.TestSecurityConfig;
import reactor.core.publisher.Mono;

import java.util.Locale;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        properties = {
                "spring.profiles.active=test",
                "spring.datasource.url=jdbc:h2:mem:testdb",
                "spring.datasource.driver-class-name=org.h2.Driver",
                "spring.jpa.hibernate.ddl-auto=create-drop",
                "supabase.jwt.secret=test_jwt_secret",
                "plant.api.token=test_api_token",
                "plant.net.api.key=test_net_api_key",
                "groq.api.key=test_groq_api_key",
                "deepl.api.key=test_deepl_api_key",
                "deepl.api.url=test_deepl_api_url",
                "spring.ai.openai.base-url=http://localhost:8080",
                "spring.ai.openai.api-key=test-key",
                "groq.api.baseUrl=http://localhost:8080/openai/v1",

        })
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
class PlantTipsControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private GroqService groqService;

    private static WireMockServer wireMockServer;

    private static final String TEST_SPECIES = "rose";


    @Test
    void getTips_shouldReturnPlantAdvice() throws Exception {
        // given
        PlantCareAdviceResponse mockResponse = new PlantCareAdviceResponse(
                "Water twice a week",
                "Full sun",
                "Spring",
                "Spring, organic fertilizer",
                "Podlewaj 2 razy w tygodniu",
                "Pełne słońce",
                "Wiosna",
                "Wiosna, nawóz organiczny"
        );

        when(groqService.getPlantAdvice(eq(TEST_SPECIES), anyString()))
                .thenReturn(Mono.just(mockResponse));

        // when & then
        mockMvc.perform(get("/api/plantify/ai/tips")
                        .param("species", TEST_SPECIES)
                        .header("Accept-Language", "en")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.watering_eng").value("Water twice a week"))
                .andExpect(jsonPath("$.sunlight_pl").value("Pełne słońce"));
    }


    @Test
    void getTips_shouldHandleEmptyResponse() throws Exception {
        // given
        PlantCareAdviceResponse emptyResponse = new PlantCareAdviceResponse(
                null, null, null, null,
                null, null, null, null
        );

        when(groqService.getPlantAdvice(eq(TEST_SPECIES), eq("en")))
                .thenReturn(Mono.just(emptyResponse));

        // when & then
        mockMvc.perform(get("/api/plantify/ai/tips")
                        .param("species", TEST_SPECIES)
                        .header("Accept-Language", "en")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }


    @Test
    void getTips_shouldReturnBadRequestWhenSpeciesMissing() throws Exception {
        mockMvc.perform(get("/api/plantify/ai/tips")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isBadRequest());
    }


    @Test
    void getTips_shouldHandlePolishLocale() throws Exception {
        // given
        PlantCareAdviceResponse mockResponse = new PlantCareAdviceResponse(
                "Water twice a week",
                "Full sun",
                "Spring",
                "Spring, organic fertilizer",
                "Podlewaj 2 razy w tygodniu",
                "Pełne słońce",
                "Wiosna",
                "Wiosna, nawóz organiczny"
        );

        when(groqService.getPlantAdvice(eq(TEST_SPECIES), eq("pl")))
                .thenReturn(Mono.just(mockResponse));

        // when & then
        mockMvc.perform(get("/api/plantify/ai/tips")
                        .param("species", TEST_SPECIES)
                        .header("Accept-Language", "pl")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.watering_pl").value("Podlewaj 2 razy w tygodniu"))
                .andExpect(jsonPath("$.sunlight_pl").value("Pełne słońce"));
    }

}