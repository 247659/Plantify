package project.plantify.AI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import project.plantify.AI.payloads.request.PhotoRequest;
import project.plantify.AI.payloads.request.PhotoUrlRequest;
import project.plantify.AI.payloads.response.GroqResponse;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import project.plantify.AI.payloads.response.PhotoAnalysisResponseToFrontend;
import project.plantify.AI.payloads.response.PlantCareAdviceResponse;
import project.plantify.AI.services.AIService;
import project.plantify.AI.services.GroqService;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Locale;
import java.util.Objects;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/ai")
public class AIController {
    @Autowired
    private AIService aiService;

    @Autowired
    private GroqService groqService;

    public AIController(AIService aiService) {
        this.aiService = aiService;
    }

    @PostMapping(value = "/getSpecies")
    public ResponseEntity<PhotoAnalysisResponseToFrontend> getSpecies(@RequestPart("images") List<MultipartFile> images,
                                                                      @RequestPart("organs") String organs,
                                                                      @RequestPart("lang") Locale lang,
                                                                      @RequestHeader(name = "Accept-Language", required = false) Locale locale) {
        PhotoRequest request = new PhotoRequest(organs, lang.getLanguage());
        PhotoAnalysisResponse response = this.aiService.analyzePhoto(images, request);

        if (response.getResults().getFirst().getSpecies().getCommonNames().isEmpty()) {
            Mono<PlantCareAdviceResponse> plantCareAdviceResponse = groqService.getPlantAdvice(response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(), locale.getLanguage());
            PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                    response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(),
                    response.getResults(),Objects.requireNonNull(plantCareAdviceResponse.block()).getWatering(),
                    Objects.requireNonNull(plantCareAdviceResponse.block()).getSunlight(),
                    Objects.requireNonNull(plantCareAdviceResponse.block()).getPruning(),
                    Objects.requireNonNull(plantCareAdviceResponse.block()).getFertilization()
            );
            return ResponseEntity.ok(frontendResponse);
        }
        Mono<PlantCareAdviceResponse> plantCareAdviceResponse = groqService.getPlantAdvice(response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(), locale.getLanguage());
        PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                response.getResults().getFirst().getSpecies().getCommonNames().getFirst(),
                response.getResults(), Objects.requireNonNull(plantCareAdviceResponse.block()).getWatering(),
                Objects.requireNonNull(plantCareAdviceResponse.block()).getSunlight(),
                Objects.requireNonNull(plantCareAdviceResponse.block()).getPruning(),
                Objects.requireNonNull(plantCareAdviceResponse.block()).getFertilization()
        );
        return ResponseEntity.ok(frontendResponse);
    }

    @PostMapping("/getSpeciesByUrl")
    private ResponseEntity<PhotoAnalysisResponseToFrontend> getSpeciesByUrl(@RequestBody PhotoUrlRequest request,
                                                                            @RequestHeader(name = "Accept-Language", required = false) Locale locale) {
        PhotoAnalysisResponse response = this.aiService.analyzePhotoUrl(request);

        if (response.getResults().getFirst().getSpecies().getCommonNames().isEmpty()) {
            Mono<PlantCareAdviceResponse> plantCareAdviceResponse = groqService.getPlantAdvice(response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(), locale.getLanguage());
            PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                    response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(),
                    response.getResults(), Objects.requireNonNull(plantCareAdviceResponse.block()).getWatering(),
                    Objects.requireNonNull(plantCareAdviceResponse.block()).getSunlight(),
                    Objects.requireNonNull(plantCareAdviceResponse.block()).getPruning(),
                    Objects.requireNonNull(plantCareAdviceResponse.block()).getFertilization()
            );
            System.out.println("Plant Care Advice: " + plantCareAdviceResponse.block());
            return ResponseEntity.ok(frontendResponse);
        }

        Mono<PlantCareAdviceResponse> plantCareAdviceResponse = groqService.getPlantAdvice(response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(), locale.getLanguage());
        PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                response.getResults().getFirst().getSpecies().getCommonNames().getFirst(),
                response.getResults(), Objects.requireNonNull(plantCareAdviceResponse.block()).getWatering(),
                Objects.requireNonNull(plantCareAdviceResponse.block()).getSunlight(),
                Objects.requireNonNull(plantCareAdviceResponse.block()).getPruning(),
                Objects.requireNonNull(plantCareAdviceResponse.block()).getFertilization()
        );
        System.out.println("Plant Care Advice: " + plantCareAdviceResponse.block());
        return ResponseEntity.ok(frontendResponse);
    }

    @GetMapping(value = "/generateShoppingList")
    public ResponseEntity<List<GroqResponse>> generateShoppingList(@RequestParam("species") String species, @RequestHeader("Lang") String lang) throws Exception {
        List<GroqResponse> response = this.groqService.generateShoppingList(species, lang);
        return ResponseEntity.ok(response);
    }
}
