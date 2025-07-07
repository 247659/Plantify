package project.plantify.AI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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

import java.util.ArrayList;
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
    @PostMapping("/getSpeciesByUrl")
    public Mono<ResponseEntity<PhotoAnalysisResponseToFrontend>> getSpeciesByUrl(
            @RequestBody PhotoUrlRequest request,
            @RequestHeader(name = "Accept-Language", required = false) Locale locale) {

        return aiService.analyzePhotoUrl(request)
                .flatMap(photoResponse -> {
                    List<PhotoAnalysisResponse.Result> results = new ArrayList<>();
                    results.add(photoResponse.getResults());
                    var species = results.getFirst().getSpecies();
                    String scientificName = species.getScientificNameWithoutAuthor();
                    String commonName = species.getCommonNames().isEmpty()
                            ? scientificName
                            : species.getCommonNames().getFirst();

                    return groqService.getPlantAdvice(scientificName, locale.getLanguage())
                            .map(advice -> {
                                PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                                        commonName,
                                        results,
                                        advice.getWatering_eng(),
                                        advice.getSunlight_eng(),
                                        advice.getPruning_eng(),
                                        advice.getFertilization_eng(),
                                        advice.getWatering_pl(),
                                        advice.getSunlight_pl(),
                                        advice.getPruning_pl(),
                                        advice.getFertilization_pl()
                                );
                                return ResponseEntity.ok(frontendResponse);
                            });
                });
    }


    @GetMapping(value = "/generateShoppingList")
    public ResponseEntity<List<GroqResponse>> generateShoppingList(@RequestParam("species") String species, @RequestHeader("Lang") String lang) throws Exception {
        List<GroqResponse> response = this.groqService.generateShoppingList(species, lang);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/tips")
    public ResponseEntity<PlantCareAdviceResponse> getTips(@RequestHeader(name = "Accept-Language", required = false) Locale locale,
                                          @RequestParam(value = "species") String species) {

        Mono<PlantCareAdviceResponse> plantCareAdviceResponse = groqService.getPlantAdvice(species, locale.getLanguage());
        System.out.println("Plant Care Advice: " + plantCareAdviceResponse.block());
        return ResponseEntity.ok(plantCareAdviceResponse.block());
    }

}
