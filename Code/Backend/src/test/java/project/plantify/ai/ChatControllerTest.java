package project.plantify.ai;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.bean.override.mockito.MockitoSpyBean;
import org.springframework.test.web.servlet.MockMvc;
import project.plantify.AI.exceptions.AIResponseException;
import project.plantify.AI.payloads.response.ChatResponse;
import project.plantify.AI.services.ChatService;
import project.plantify.TestSecurityConfig;

import java.util.Locale;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
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
                "spring.ai.openai.base-url=http://localhost:8080",
                "spring.ai.openai.api-key=test-key"

        })
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
class ChatControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoSpyBean
    private ChatService chatService;

    @MockitoBean
    private ChatClient chatClient;

    @MockitoBean
    private MessageSource messageSource;


    static private WireMockServer wireMockServer;

    @BeforeAll
    static void setupWireMock() {
        wireMockServer = new WireMockServer(8080);
        wireMockServer.start();

        WireMock.configureFor("localhost", 8080);
    }

    @AfterAll
    static void tearDownWireMock() {
        wireMockServer.stop();
    }

    @Test
    void chatEndpointShouldReturnValidResponse() throws Exception {
        // Given
        String expectedResponse = "Test response from AI";
        doReturn(new ChatResponse("assistant", "Test response from AI"))
                .when(chatService).chat(anyString(), anyString(), any(Locale.class));

        // When/Then
        mockMvc.perform(
                        post("/api/plantify/chat/generate")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("""
                        {
                          "mes": "Jak dbać o róże?",
                          "userId": "user123"
                        }
                        """)
                                .header("Accept-Language", "pl"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.role").value("assistant"))
                .andExpect(jsonPath("$.content").value(expectedResponse));
    }

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
    void chatEndpointShouldReturnBadRequestWhenMissingUserId() throws Exception {
        mockMvc.perform(
                        post("/api/plantify/chat/generate")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("""
                        {
                          "mes": "Hello",
                          "userId": ""
                        }
                        """))
                .andExpect(status().isBadRequest());
    }

    @Test
    void refreshEndpointEmptyUser() throws Exception {
        mockMvc.perform(
                        delete("/api/plantify/chat/refresh")
                                .param("userId", "")
                                .header("Accept-Language", "en"))
                .andDo(print())
                .andExpect(status().isBadRequest());
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

    @Test
    void chatShouldHandleMultipleMessages() {
        // given
        String userId = "testUser";
        Locale locale = Locale.ENGLISH;

        // Konfiguracja WireMocka
        wireMockServer.stubFor(WireMock.post(WireMock.urlEqualTo("/v1/chat/completions"))
                .willReturn(WireMock.aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                                {
                                    "id": "chatcmpl-123",
                                    "object": "chat.completion",
                                    "created": 1677652288,
                                    "choices": [{
                                        "index": 0,
                                        "message": {
                                            "role": "assistant",
                                            "content": "Test response"
                                        },
                                        "finish_reason": "stop"
                                    }],
                                    "usage": {
                                        "prompt_tokens": 9,
                                        "completion_tokens": 12,
                                        "total_tokens": 21
                                    }
                                }
                                """)));

        // Wysyłamy 11 wiadomości
        for (int i = 0; i < 11; i++) {
            ChatResponse response = chatService.chat("Message " + i, userId, locale);
            assertEquals("assistant", response.getRole());
            assertEquals("Test response", response.getContent());
        }

        // Sprawdzamy, czy pamięć zawiera maksymalnie 10 wiadomości
        ChatMemory memory = chatService.getOrCreateChatMemoryTest(userId);
        System.out.println("Memory size: " + memory.get(userId).size());
        assertTrue(memory.get(userId).size() <= 10,
                "Pamięć czatu powinna zawierać maksymalnie 10 wiadomości");
    }

    @Test
    void chatShouldThrowExceptionWhenResponseIsEmpty() {
        // given
        String userId = "testUser";
        Locale locale = Locale.ENGLISH;
        String message = "Test message";

        // Konfiguracja WireMocka dla pustej odpowiedzi
        wireMockServer.stubFor(WireMock.post(WireMock.urlEqualTo("/v1/chat/completions"))
                .willReturn(WireMock.aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                            {
                                "choices": [{
                                    "message": {
                                        "role": "assistant",
                                        "content": ""
                                    }
                                }]
                            }
                            """)));

        // Mockowanie MessageSource dla komunikatu błędu
        when(messageSource.getMessage("chat.error", null, locale))
                .thenReturn("Something gone wrong... Try again later.");

        // when & then
        AIResponseException thrown = assertThrows(
                AIResponseException.class,
                () -> chatService.chat(message, userId, locale),
                "Powinien rzucić IllegalStateException dla pustej odpowiedzi"
        );

        assertEquals("Something gone wrong... Try again later.", thrown.getMessage());
    }

    @Test
    void chatShouldThrowExceptionWhenResponseIsNull() {
        // given
        String userId = "testUser";
        Locale locale = Locale.ENGLISH;
        String message = "Test message";

        // Konfiguracja WireMocka dla null w odpowiedzi
        wireMockServer.stubFor(WireMock.post(WireMock.urlEqualTo("/v1/chat/completions"))
                .willReturn(WireMock.aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", "application/json")
                        .withBody("""
                            {
                                "choices": [{
                                    "message": {
                                        "role": "assistant",
                                        "content": null
                                    }
                                }]
                            }
                            """)));

        // Mockowanie MessageSource dla komunikatu błędu
        when(messageSource.getMessage("chat.error", null, locale))
                .thenReturn("Something gone wrong... Try again later.");

        // when & then
        AIResponseException thrown = assertThrows(
                AIResponseException.class,
                () -> chatService.chat(message, userId, locale),
                "Powinien rzucić IllegalStateException dla null w odpowiedzi"
        );

        assertEquals("Something gone wrong... Try again later.", thrown.getMessage());
    }

}


