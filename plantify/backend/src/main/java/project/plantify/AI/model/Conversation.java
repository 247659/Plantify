package project.plantify.AI.model;

import lombok.Data;
import org.springframework.ai.chat.messages.Message;

import java.util.List;

@Data
public class Conversation {
    private final String conversationId;
    private final List<Message> messages;
}
