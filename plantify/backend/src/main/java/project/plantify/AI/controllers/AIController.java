package project.plantify.AI.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import project.plantify.AI.payloads.request.PhotoRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import project.plantify.AI.payloads.response.PhotoAnalysisResponseToFrontend;
import project.plantify.AI.services.AIService;

import java.util.List;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/ai")
public class AIController {
    private final AIService aiService;

    public AIController(AIService aiService) {
        this.aiService = aiService;
    }

    @PostMapping(value = "/getSpecies")
    public ResponseEntity<PhotoAnalysisResponseToFrontend> getSpecies(@RequestPart("images") List<MultipartFile> images,
                                                                      @RequestPart("organs") String organs,
                                                                      @RequestPart("lang") String lang) {
        PhotoRequest request = new PhotoRequest(organs, lang);
        PhotoAnalysisResponse response = this.aiService.analyzePhoto(images, request);
        PhotoAnalysisResponseToFrontend frontendResponse = new PhotoAnalysisResponseToFrontend(
                response.getResults().getFirst().getSpecies().getCommonNames().getFirst(),
                response.getResults()
        );
        return ResponseEntity.ok(frontendResponse);
    }

}
