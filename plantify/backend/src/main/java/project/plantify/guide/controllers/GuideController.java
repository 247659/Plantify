package project.plantify.guide.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.plantify.guide.exceptions.ErrorMessage;
import project.plantify.guide.exceptions.NotFoundSpeciesException;
import project.plantify.guide.exceptions.PerenualApiException;
import project.plantify.guide.playloads.response.*;
import project.plantify.guide.services.GuideService;

import java.util.List;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/guide")
public class GuideController {

    @Autowired
    private GuideService guideService;

    @GetMapping("/getAll")
    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlants() {
        List<PlantsResponseToFrontend> response = this.guideService.getAllPlant();
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getPlantsBySpecies")
    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlantsBySpecies(@RequestParam("species") String species) {
        List<PlantsResponseToFrontend> response = this.guideService.getAllPlantsBySpecies(species.toLowerCase());
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getSinglePlant")
    public ResponseEntity<SinglePlantResponseToFrontend> getSinglePlant(@RequestParam("id") String id) {
        SinglePlantResponseToFrontend response = this.guideService.getSinglePlant(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getPlantsGuide")
    public ResponseEntity<List<PlantsGuideFrontendResponse>> getPlantsGuide(@RequestParam("name") String name) {
        List<PlantsGuideFrontendResponse> response = this.guideService.getPlantsGuide(name.toLowerCase());
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getPlantsGuideById")
    public ResponseEntity<PlantsGuideFrontendResponse> getPlantsGuideById(@RequestParam("speciesId") String id,
                                                                          @RequestParam("speciesName") String name) {
        System.out.println("Raz");
        PlantsGuideFrontendResponse response = this.guideService.getPlantsGuideById(id, name.toLowerCase());
        System.out.println("Dwa");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getPlantsFAQ")
    public ResponseEntity<List<PlantsFAQFrontendResponse>> getPlantsFAQ(@RequestParam("name") String name) {
        List<PlantsFAQFrontendResponse> response = this.guideService.getPlantsFAQ(name.toLowerCase());
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

}
