package project.plantify.AI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.plantify.AI.payloads.response.ChatResponse;
import project.plantify.AI.services.ChatService;
import java.util.Map;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @PostMapping("/generate")
    public ResponseEntity<ChatResponse> chat(@RequestBody Map<String, String> body) {

        String message = body.get("mes");
        String userId = body.get("userId");
        ChatResponse chatResponse = chatService.chat(message, userId);
        System.out.println("Response " + chatResponse.getContent());
        return ResponseEntity
                .ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(chatResponse);
    }

}
