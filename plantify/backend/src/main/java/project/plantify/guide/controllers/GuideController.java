package project.plantify.guide.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.plantify.guide.playloads.response.*;
import project.plantify.guide.services.GuideService;

import java.util.Collections;
import java.util.List;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
//@RequestMapping("/test")
@RequestMapping("/api/plantify/guide")
public class GuideController {

    @Autowired
    private GuideService guideService;

    @GetMapping("/getAll")
    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlants() {
        try {
            List<PlantsResponseToFrontend> response = this.guideService.getAllPlant();
            System.out.println(response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("Błąd: " + e.getMessage());
            return ResponseEntity.internalServerError().body(Collections.emptyList());
        }
    }

    @GetMapping("/getPlantsBySpecies")
    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlantsBySpecies(@RequestParam("species") String species) {
        try {
            List<PlantsResponseToFrontend> response = this.guideService.getAllPlantsBySpecies(species.toLowerCase());
            System.out.println(response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("Błąd: " + e.getMessage());
            return ResponseEntity.internalServerError().body(Collections.emptyList());
        }
    }

    @GetMapping("/getSinglePlant")
    public ResponseEntity<SinglePlantResponseToFrontend> getSinglePlant(@RequestParam("id") String id) {
        try {
            SinglePlantResponseToFrontend response = this.guideService.getSinglePlant(id);
            System.out.println(response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("Błąd: " + e.getMessage());
            return ResponseEntity.internalServerError().body(null);
        }

    }

    @GetMapping("/getPlantsGuide")
    public ResponseEntity<List<PlantsGuideFrontendResponse>> getPlantsGuide(@RequestParam("name") String name) {
        try {
            List<PlantsGuideFrontendResponse> response = this.guideService.getPlantsGuide(name.toLowerCase());
            System.out.println(response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("Błąd: " + e.getMessage());
            return ResponseEntity.internalServerError().body(Collections.emptyList());
        }
    }

    @GetMapping("/getPlantsGuideById")
    public ResponseEntity<PlantsGuideFrontendResponse> getPlantsGuideById(@RequestParam("speciesId") String id,
                                                                          @RequestParam("speciesName") String name) {
        try {
            PlantsGuideFrontendResponse response = this.guideService.getPlantsGuideById(id, name.toLowerCase());
            System.out.println(response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("Błąd: " + e.getMessage());
            return ResponseEntity.internalServerError().body(null);
        }
    }

    @GetMapping("/getPlantsFAQ")
    public ResponseEntity<List<PlantsFAQFrontendResponse>> getPlantsFAQ(@RequestParam("name") String name) {
        try {
            List<PlantsFAQFrontendResponse> response = this.guideService.getPlantsFAQ(name.toLowerCase());
            System.out.println(response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.out.println("Błąd: " + e.getMessage());
            return ResponseEntity.internalServerError().body(Collections.emptyList());
        }
    }

}
