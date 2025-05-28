package project.plantify.AI.controllers;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.memory.ChatMemoryRepository;
import org.springframework.ai.chat.memory.InMemoryChatMemoryRepository;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.web.bind.annotation.*;
import project.plantify.AI.model.Conversation;
import reactor.core.publisher.Flux;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/chat")
public class ChatController {

    private final ChatClient chatClient;
    private final Map<String, ChatMemoryRepository> chatsHistory;
    private final int MAX_SESSIONS = 20;
    private final ChatMemory chatMemory;

    public ChatController(ChatClient.Builder builder, ChatMemory chatMemory) {
        this.chatClient = builder.build();
        this.chatsHistory = new ConcurrentHashMap<>();
        this.chatMemory = chatMemory;
    }

    @PostMapping("/generate")
    public String chat(@RequestBody Map<String, String> body,
                       @RequestParam(value = "userId") String userId) {
        String message = body.get("mes");

        if (message == null || message.isEmpty()) {
            throw new IllegalArgumentException("Message cannot be empty");
        }

        System.out.println("Received message: " + message);

        ChatMemoryRepository chatMemory = getOrCreateChatMemory(userId);

        if (chatMemory.findByConversationId(userId).isEmpty()) {
            List<Message> messages = new ArrayList<>();
            messages.add(new UserMessage(message));
            chatMemory.saveAll(userId, messages);
        } else {
            List<Message> messages1 = chatMemory.findByConversationId(userId);
            messages1.add(new UserMessage(message));
            chatMemory.saveAll(userId, messages1);
        }

        for (Message m : chatMemory.findByConversationId(userId)) {
            System.out.println("Message in chat memory: " + m);
        }

        String response = chatClient.prompt().user(message)
                .call()
                .content();

        List<Message> messages2 = chatMemory.findByConversationId(userId);
        messages2.add(new AssistantMessage(message));
        chatMemory.saveAll(userId, messages2);

        return response;
    }

    private ChatMemoryRepository getOrCreateChatMemory(String sessionId) {
        // Oczyść stare sesje jeśli osiągnięto limit
        if (chatsHistory.size() >= MAX_SESSIONS) {
            chatsHistory.clear();
        }

        return chatsHistory.computeIfAbsent(sessionId, id -> {
            System.out.println("Creating new chat memory for session: " + id);
            return new InMemoryChatMemoryRepository();
        });
    }


    @GetMapping("/stream")
    public Flux<String> stream(@RequestParam("mes") String message) {
        System.out.println("Received message for streaming: " + message);
        return chatClient.prompt().user(message).stream().content();
    }
}
