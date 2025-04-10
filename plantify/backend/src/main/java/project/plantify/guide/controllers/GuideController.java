package project.plantify.guide.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.plantify.guide.playloads.request.FindSpeciesRequest;
import project.plantify.guide.playloads.response.PlantsResponse;
import project.plantify.guide.playloads.response.PlantsResponseToFrontend;
import project.plantify.guide.services.GuideService;

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
        List<PlantsResponseToFrontend> response = this.guideService.getAllPlant();
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/getPlantsBySpecies")
    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlantsBySpecies(@RequestBody FindSpeciesRequest req) {
        String species = req.getSpecies();
        List<PlantsResponseToFrontend> response = this.guideService.getAllPlantsBySpecies(species);
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getSinglePlant")
    public ResponseEntity<PlantsResponseToFrontend> getSinglePlant(@RequestParam("id") String id) {
        PlantsResponseToFrontend response = this.guideService.getSinglePlant(id);
        System.out.println(response);
        return ResponseEntity.ok(response);
    }
}
