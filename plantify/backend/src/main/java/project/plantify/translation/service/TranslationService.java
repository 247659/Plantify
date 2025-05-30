package project.plantify.translation.service;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.deepl.api.*;
import project.plantify.translation.exceptions.TranslationException;

@Data
@Service
public class TranslationService {

    private DeepLClient deepLClient;

    public TranslationService(@Value("${deepl.api.key}") String apiKey) {
        this.deepLClient = new DeepLClient(apiKey);
    }

    public String translate(String text, String sourceLanguage, String targetLanguage) {
        try {
            if (text == null || text.isEmpty()) {
                return text;
            }
            TextResult textResult = deepLClient.translateText(text, sourceLanguage, targetLanguage);

            return textResult.getText();
        } catch (Exception e) {
            throw new TranslationException("Translation failed: " + e.getMessage());
        }


    }
}