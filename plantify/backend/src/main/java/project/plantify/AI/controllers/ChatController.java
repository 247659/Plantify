package project.plantify.AI.controllers;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.memory.MessageWindowChatMemory;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.MessageType;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/chat")
public class ChatController {

    private final ChatClient chatClient;
    private final int MAX_SESSIONS = 20;
    private final Map<String, ChatMemory> chatMemory;

    public ChatController(ChatClient.Builder builder) {
        this.chatClient = builder.build();
        this.chatMemory = new ConcurrentHashMap<>();
    }

    @PostMapping("/generate")
    public String chat(@RequestBody Map<String, String> body,
                       @RequestParam(value = "userId") String userId) {
        ChatMemory singleChatMemory = getOrCreateChatMemory(userId);

        String message = body.get("mes");
        if (message == null || message.isEmpty()) {
            throw new IllegalArgumentException("Message cannot be empty");
        }

        singleChatMemory.add(userId, new UserMessage(message));

        System.out.println(singleChatMemory.get(userId).getFirst().getMessageType());
        System.out.println(singleChatMemory.get(userId).getFirst().getText());
        System.out.println("Received message: " + message);

        String prompt = buildPrompt(singleChatMemory.get(userId));
        System.out.println(prompt);
        String response = chatClient.prompt().user(prompt)
                .call()
                .content();

        singleChatMemory.add(userId, new AssistantMessage(response));

        return response;
    }

    private String buildPrompt(List<Message> messages) {
        StringBuilder prompt = new StringBuilder();

        for (Message message : messages) {
            System.out.println(message);
            if (message.getMessageType() == MessageType.USER) {
                prompt.append("User: ").append(message.getText()).append("\n");
            } else if (message.getMessageType() == MessageType.ASSISTANT) {
                prompt.append("Assistant: ").append(message.getText()).append("\n");
            }
        }
        return prompt.toString();
    }

    private ChatMemory getOrCreateChatMemory(String sessionId) {
        if (chatMemory.size() >= MAX_SESSIONS) {
            chatMemory.clear();
        }

        return chatMemory.computeIfAbsent(sessionId, id -> {
            System.out.println("Creating new chat memory for session: " + id);
            return MessageWindowChatMemory.builder().build();
        });
    }


    @GetMapping("/stream")
    public Flux<String> stream(@RequestParam("mes") String message) {
        System.out.println("Received message for streaming: " + message);
        return chatClient.prompt().user(message).stream().content();
    }
}
