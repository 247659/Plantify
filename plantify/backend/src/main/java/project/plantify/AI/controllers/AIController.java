package project.plantify.AI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import project.plantify.AI.payloads.request.PhotoRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import project.plantify.AI.payloads.response.PhotoAnalysisResponseToFrontend;
import project.plantify.AI.services.AIService;
import project.plantify.guide.services.GuideService;

import java.util.List;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/ai")
public class AIController {

    @Autowired
    private AIService aiService;

    @PostMapping("/getSpecies")
    public ResponseEntity<PhotoAnalysisResponseToFrontend> getSpecies(@ModelAttribute PhotoRequest request) {
        System.out.println(request);
        PhotoAnalysisResponseToFrontend response = this.aiService.analyzePhoto(request);
        return ResponseEntity.ok(response);
    }

}
