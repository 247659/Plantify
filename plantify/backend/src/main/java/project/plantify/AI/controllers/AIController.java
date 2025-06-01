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
import project.plantify.AI.services.AIService;
import project.plantify.AI.services.GroqService;

import java.util.List;

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
                                                                      @RequestPart("lang") String lang) {
        PhotoRequest request = new PhotoRequest(organs, lang);
        PhotoAnalysisResponse response = this.aiService.analyzePhoto(images, request);

        if (response.getResults().getFirst().getSpecies().getCommonNames().isEmpty()) {
            PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                    response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(),
                    response.getResults()
            );
            return ResponseEntity.ok(frontendResponse);
        }

        PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                response.getResults().getFirst().getSpecies().getCommonNames().getFirst(),
                response.getResults()
        );
        return ResponseEntity.ok(frontendResponse);
    }

    @PostMapping("/getSpeciesByUrl")
    private ResponseEntity<PhotoAnalysisResponseToFrontend> getSpeciesByUrl(@RequestBody PhotoUrlRequest request) {
        PhotoAnalysisResponse response = this.aiService.analyzePhotoUrl(request);

        if (response.getResults().getFirst().getSpecies().getCommonNames().isEmpty()) {
            PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                    response.getResults().getFirst().getSpecies().getScientificNameWithoutAuthor(),
                    response.getResults()
            );
            return ResponseEntity.ok(frontendResponse);
        }

        PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                response.getResults().getFirst().getSpecies().getCommonNames().getFirst(),
                response.getResults()
        );
        return ResponseEntity.ok(frontendResponse);
    }

    @GetMapping(value = "/generateShoppingList")
    public ResponseEntity<GroqResponse> generateShoppingList(@RequestParam("species") String species) throws Exception {
        String language = "pl";
        GroqResponse response = this.groqService.generateShoppingList(species, language);
        return ResponseEntity.ok(response);
    }

}
