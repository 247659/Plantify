package project.plantify.translation.service;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.deepl.api.*;
import project.plantify.guide.playloads.response.PlantsFAQFrontendResponse;
import project.plantify.guide.playloads.response.PlantsGuideFrontendResponse;
import project.plantify.guide.playloads.response.SinglePlantResponseToFrontend;
import project.plantify.translation.exceptions.TranslationException;

import java.util.List;

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

    public SinglePlantResponseToFrontend translateSinglePlant(SinglePlantResponseToFrontend plant, String sourceLanguage, String targetLanguage) {
        try {
           SinglePlantResponseToFrontend translatedPlant = plant;
           translatedPlant.setType(translate(plant.getType(), sourceLanguage, targetLanguage));
           translatedPlant.getDimensions().getFirst().setType(translate(plant.getDimensions().getFirst().getType(), sourceLanguage, targetLanguage));
           translatedPlant.setCycle(translate(plant.getCycle(), sourceLanguage, targetLanguage));
           translatedPlant.setWatering(translate(plant.getWatering(), sourceLanguage, targetLanguage));
           translatedPlant.getWateringGeneralBenchmark().setUnit(translate(plant.getWateringGeneralBenchmark().getUnit(), sourceLanguage, targetLanguage));

            for (int i = 0; i < translatedPlant.getPlantAnatomy().size(); i++) {
                translatedPlant.getPlantAnatomy().get(i).setPart(translate(plant.getPlantAnatomy().get(i).getPart(), sourceLanguage, targetLanguage));
                for (int j = 0; j < translatedPlant.getPlantAnatomy().get(i).getColor().size(); j++) {
                    translatedPlant.getPlantAnatomy().get(i).getColor().set(i, translate(plant.getPlantAnatomy().get(i).getColor().get(j), sourceLanguage, targetLanguage));
                }
            }
            for (int i = 0; i < translatedPlant.getSunlight().size(); i++) {
                translatedPlant.getSunlight().set(i, translate(plant.getSunlight().get(i), sourceLanguage, targetLanguage));
            }
            int originSize = Math.min(translatedPlant.getOrigin().size(), 3);

            for (int i = 0; i < originSize; i++) {
                translatedPlant.getOrigin().set(i, translate(plant.getOrigin().get(i), sourceLanguage, targetLanguage));
            }

            translatedPlant.setCareLevel(translate(plant.getCareLevel(), sourceLanguage, targetLanguage));
            translatedPlant.setDescription(translate(plant.getDescription(), sourceLanguage, targetLanguage));

           return translatedPlant;
        } catch (Exception e) {
            return plant;
        }
    }

    public PlantsGuideFrontendResponse translateGuide(PlantsGuideFrontendResponse guide, String sourceLanguage, String targetLanguage) {
        try {
            PlantsGuideFrontendResponse translatedGuide = guide;
            translatedGuide.setWatering(translate(guide.getWatering(), sourceLanguage, targetLanguage));
            translatedGuide.setSunLight(translate(guide.getSunLight(), sourceLanguage, targetLanguage));
            translatedGuide.setPruning(translate(guide.getPruning(), sourceLanguage, targetLanguage));

            return translatedGuide;
        } catch (Exception e) {
            return guide;
        }
    }

    public List<PlantsFAQFrontendResponse> translateFAQ(List<PlantsFAQFrontendResponse> faqList, String sourceLanguage, String targetLanguage) {
        try {
            for (PlantsFAQFrontendResponse faq : faqList) {
                faq.setQuestion(translate(faq.getQuestion(), sourceLanguage, targetLanguage));
                faq.setAnswer(translate(faq.getAnswer(), sourceLanguage, targetLanguage));
            }
            return faqList;
        } catch (Exception e) {
            return faqList;
        }
    }

}