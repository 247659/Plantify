package project.plantify.ai;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mockito.Answers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import project.plantify.AI.payloads.response.ChatResponse;
import project.plantify.AI.services.ChatService;
import project.plantify.TestSecurityConfig;

import static com.github.tomakehurst.wiremock.client.WireMock.aResponse;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
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
                "spring.ai.openai.api.url=http://localhost:9561/v1", // <- przekieruj ChatClient tu
                "spring.ai.openai.api.key=dummy",
        })
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
class ChatControllerTest {

    @Autowired
    private MockMvc mockMvc;

    static private WireMockServer wireMockServer;

    @BeforeAll
    static void setupWireMock() {
        wireMockServer = new WireMockServer(9561);
        wireMockServer.start();

        WireMock.configureFor("localhost", 9561);
    }

    @AfterAll
    static void tearDownWireMock() {
        wireMockServer.stop();
    }

//    @Test
//    void chatShouldReturnMockedOpenAiResponse() throws Exception {
//        // Ustal treść odpowiedzi (na podstawie OpenAI Chat API specyfikacji)
//        WireMock.stubFor(WireMock.post(WireMock.urlEqualTo("/v1/chat/completions"))
//                .willReturn(aResponse()
//                        .withStatus(200)
//                        .withHeader("Content-Type", "application/json")
//                        .withBody("""
//                            {
//                              "id": "chatcmpl-xyz",
//                              "object": "chat.completion",
//                              "created": 1234567890,
//                              "model": "gpt-3.5-turbo",
//                              "choices": [
//                                {
//                                  "index": 0,
//                                  "message": {
//                                    "role": "assistant",
//                                    "content": "Symulowana odpowiedź asystenta"
//                                  },
//                                  "finish_reason": "stop"
//                                }
//                              ],
//                              "usage": {
//                                "prompt_tokens": 10,
//                                "completion_tokens": 10,
//                                "total_tokens": 20
//                              }
//                            }
//                        """)));
//
//        mockMvc.perform(post("/api/plantify/chat/generate")
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .content("""
//                             {
//                                "mes": "hello",
//                                "userId": "user123"
//                             }
//                        """)
//                        .header("Accept-Language", "en"))
//                .andExpect(status().isOk())
//                .andExpect(jsonPath("$.content").value("Symulowana odpowiedź asystenta"));
//    }


    @Test
    void refreshEndpointShouldReturnOk() throws Exception {
        mockMvc.perform(
                        delete("/api/plantify/chat/refresh")
                                .param("userId", "user123")
                                .header("Accept-Language", "en"))
                .andDo(print())
                .andExpect(status().isOk());
    }

    @Test
    void chatEndpointShouldReturnBadRequestWhenMissingMessage() throws Exception {
        mockMvc.perform(
                        post("/api/plantify/chat/generate")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("""
                                 {
                                   "mes": "",
                                   "userId": "user123"
                                 }
                                 """))
                .andExpect(status().isBadRequest());
    }
}


