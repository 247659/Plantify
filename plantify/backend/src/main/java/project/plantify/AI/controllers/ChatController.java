package project.plantify.AI.controllers;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/api/plantify/chat")
public class ChatController {

    private final ChatClient chatClient;

    public ChatController(ChatClient.Builder builder) {
        this.chatClient = builder.build();
    }

    @PostMapping("/generate")
    public String chat(@RequestParam("mes") String message) {
        System.out.println("Received message: " + message);
        return chatClient.prompt().user(message).call().content();
    }

    @GetMapping("/stream")
    public Flux<String> stream(@RequestParam("mes") String message) {
        return chatClient.prompt().user(message).stream().content();
    }
}
