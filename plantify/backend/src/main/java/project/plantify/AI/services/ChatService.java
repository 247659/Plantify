package project.plantify.AI.services;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.memory.MessageWindowChatMemory;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.MessageType;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.stereotype.Service;
import project.plantify.AI.exceptions.AIResponseException;
import project.plantify.AI.exceptions.BadDataException;
import project.plantify.AI.payloads.response.ChatResponse;

import java.util.List;
import java.util.Map;

@Service
public class ChatService {

    private final ChatClient chatClient;
    private final Map<String, ChatMemory> chatMemory;

    public ChatService(ChatClient.Builder builder, Map<String, ChatMemory> chatMemory) {
        this.chatClient = builder.build();
        this.chatMemory = chatMemory;
    }

    public ChatResponse chat(String message, String userId) {
        try {
            ChatMemory singleChatMemory = getOrCreateChatMemory(userId);

            if (message == null || message.isEmpty()) {
                throw new BadDataException("Message cannot be empty");
            } else if (userId == null || userId.isEmpty()) {
                throw new BadDataException("User ID cannot be empty");
            }

            if (singleChatMemory.get(userId).size() >= 10) {
                singleChatMemory.get(userId).removeFirst();
            }

            singleChatMemory.add(userId, new UserMessage(message));

//            System.out.println(singleChatMemory.get(userId).getFirst().getMessageType());
//            System.out.println(singleChatMemory.get(userId).getFirst().getText());
            System.out.println("Received message: " + message);

            String prompt = buildPrompt(singleChatMemory.get(userId));
//            System.out.println(prompt);
            String response = chatClient.prompt().user(prompt)
                    .call()
                    .content();

            if (response == null || response.isEmpty()) {
                throw new IllegalStateException("Response from chat client is empty");
            }
            singleChatMemory.add(userId, new AssistantMessage(response));

            return new ChatResponse("assistant", response);
        } catch (BadDataException e) {
            throw e;
        } catch (Exception e) {
            throw new AIResponseException("Something gone wrong... Try again later.");
        }


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
        int MAX_SESSIONS = 20;
        if (chatMemory.size() >= MAX_SESSIONS) {
            chatMemory.clear();
        }

        return chatMemory.computeIfAbsent(sessionId, id -> {
            System.out.println("Creating new chat memory for session: " + id);
            return MessageWindowChatMemory.builder().build();
        });
    }

}
