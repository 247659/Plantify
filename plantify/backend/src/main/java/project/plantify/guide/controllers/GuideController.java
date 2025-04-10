package project.plantify.guide.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import project.plantify.guide.playloads.request.FindSpeciesRequest;
import project.plantify.guide.services.GuideService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
//@RequestMapping("/test")
@RequestMapping("/api/plantify/guide")
public class GuideController {

    @Autowired
    private GuideService guideService;

    @GetMapping("/getAll")
    public String getAllPlants() {
        String response = this.guideService.getAllPlant();
        System.out.println(response);
        return response;
    }

    @PostMapping("/getPlantsBySpecies")
    public String getAllPlantsBySpecies(@RequestBody FindSpeciesRequest req) {
        String species = req.getSpecies();
        String response = this.guideService.getAllPlantsBySpecies(species);
        System.out.println(response);
        return response;
    }

    @GetMapping("/getSinglePlant")
    public String getSinglePlant(@RequestParam("id") String id) {
        String response = this.guideService.getSinglePlant(id);
        System.out.println(response);
        return response;
    }
}
