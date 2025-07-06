package project.plantify.AI.services;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.memory.MessageWindowChatMemory;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.MessageType;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import project.plantify.AI.exceptions.AIResponseException;
import project.plantify.AI.exceptions.BadDataException;
import project.plantify.AI.payloads.response.ChatResponse;

import java.util.List;
import java.util.Locale;
import java.util.Map;

@Service
public class ChatService {

    private final ChatClient chatClient;
    private final Map<String, ChatMemory> chatMemory;

    @Autowired
    private MessageSource messageSource;

    public ChatService(ChatClient.Builder builder, Map<String, ChatMemory> chatMemory) {
        this.chatClient = builder.build();
        this.chatMemory = chatMemory;
    }

    public ChatResponse chat(String message, String userId, Locale locale) {
        try {
            ChatMemory singleChatMemory = getOrCreateChatMemory(userId);

            if (message == null || message.isEmpty()) {
                throw new BadDataException(messageSource.getMessage("chat.noMessage", null, locale));
            } else if (userId == null || userId.isEmpty()) {
                throw new BadDataException(messageSource.getMessage("chat.noUser", null, locale));
            }


            singleChatMemory.add(userId, new UserMessage(message));

            List<Message> currentMessages = singleChatMemory.get(userId);

            if (currentMessages.size() >= 10) {
                singleChatMemory.clear(userId);
                currentMessages.subList(currentMessages.size() - 9, currentMessages.size())
                        .forEach(msg -> singleChatMemory.add(userId, msg));
            }


            String prompt = buildPrompt(singleChatMemory.get(userId), locale);
            String response = chatClient.prompt().user(prompt)
                    .call()
                    .content();

            if (response == null || response.isEmpty()) {
                throw new IllegalStateException(messageSource.getMessage("chat.noResponse", null, locale));
            }
            singleChatMemory.add(userId, new AssistantMessage(response));

            return new ChatResponse("assistant", response);
        } catch (BadDataException | IllegalStateException e) {
            throw e;
        } catch (Exception e) {
            throw new AIResponseException(messageSource.getMessage("chat.error", null, locale));
        }


    }

    private String buildPrompt(List<Message> messages, Locale locale) {
        StringBuilder prompt = new StringBuilder();

        if (locale.getLanguage().equals("pl")) {
            prompt.append("""
                    Jesteś ekspertem w dziedzinie roślin, botaniki i ogrodnictwa. \
                    Pomagasz użytkownikom pielęgnować ich rośliny, diagnozować ich problemy i doradzać w zakresie ogrodnictwa.
                    
                    """);
        } else {
            prompt.append("""
                    You are an expert in plants, botany, and gardening. \
                    You help users care for their plants, diagnose their problems, and provide gardening advice.
                    
                    """);
        }



        for (Message message : messages) {
//            System.out.println(message);
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

    public void refresh(String userId, Locale locale) {
        try {
            if (userId == null || userId.isEmpty()) {
                throw new BadDataException(messageSource.getMessage("chat.noUser", null, locale));
            }

            ChatMemory singleChatMemory = getOrCreateChatMemory(userId);
            singleChatMemory.clear(userId);

        } catch (BadDataException e) {
            throw e;
        } catch (Exception e) {
            throw new AIResponseException(messageSource.getMessage("chat.error", null, locale));
        }

    }

    public ChatMemory getOrCreateChatMemoryTest(String sessionId) {
        return getOrCreateChatMemory(sessionId);
    }

}
