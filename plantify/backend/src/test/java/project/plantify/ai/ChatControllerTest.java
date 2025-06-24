//package project.plantify.ai;
//
//import org.junit.jupiter.api.Test;
//import org.springframework.ai.chat.client.ChatClient;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.http.MediaType;
//import org.springframework.test.context.bean.override.mockito.MockitoBean;
//import org.springframework.test.web.servlet.MockMvc;
//
//import static org.mockito.ArgumentMatchers.anyString;
//import static org.mockito.BDDMockito.given;
//import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
//import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
//
//@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
//        properties = {
//                "spring.profiles.active=test",
//                "spring.datasource.url=jdbc:h2:mem:testdb",
//                "spring.datasource.driver-class-name=org.h2.Driver",
//                "spring.jpa.hibernate.ddl-auto=create-drop",
//                "supabase.jwt.secret=test_jwt_secret",
//                "plant.api.token=test_api_token",
//                "plant.net.api.key=test_net_api_key",
//                "groq.api.key=test_groq_api_key",
//                "deepl.api.key=test_deepl_api_key",
//                "deepl.api.url=test_deepl_api_url"
//        })
//@AutoConfigureMockMvc
//class ChatControllerTest {
//
//    @Autowired
//    private MockMvc mockMvc;
//
//    @MockitoBean
//    private ChatClient chatClient; // Podstawiony bean w SpringContext
//
//    @Test
//    void chatEndpointShouldReturnAssistantMessage() throws Exception {
//        // Arrange: symulujemy odpowiedź z ChatClient
//        given(chatClient.prompt().user(anyString()).call().content())
//                .willReturn("Symulowana odpowiedź asystenta");
//
//        // Act + Assert
//        mockMvc.perform(
//                        post("/api/plantify/chat/generate")
//                                .contentType(MediaType.APPLICATION_JSON)
//                                .content("""
//                                 {
//                                    "mes": "hello",
//                                    "userId": "user123"
//                                 }
//                                 """)
//                                .header("Accept-Language", "en"))
//                .andExpect(status().isOk())
//                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
//                .andExpect(jsonPath("$.content").value("Symulowana odpowiedź asystenta"));
//    }
//
//    @Test
//    void refreshEndpointShouldReturnOk() throws Exception {
//        mockMvc.perform(
//                        delete("/api/plantify/chat/refresh")
//                                .param("userId", "user123")
//                                .header("Accept-Language", "en"))
//                .andExpect(status().isOk());
//    }
//
//    @Test
//    void chatEndpointShouldReturnBadRequestWhenMissingMessage() throws Exception {
//        mockMvc.perform(
//                        post("/api/plantify/chat/generate")
//                                .contentType(MediaType.APPLICATION_JSON)
//                                .content("""
//                                 {
//                                   "mes": "",
//                                   "userId": "user123"
//                                 }
//                                 """))
//                .andExpect(status().isBadRequest());
//    }
//}
//
//
