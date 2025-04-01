package project.plantify.plants.controllers;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import project.plantify.plants.models.Plant;
import project.plantify.plants.repository.PlantRepository;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/plants")
public class PlantController {
    private final PlantRepository plantRepository;

    @PostMapping
    public Plant createPlant(@RequestBody Plant plant) {
        return plantRepository.save(plant);
    }

    @GetMapping
    public List<Plant> getAllPlants() {
        return plantRepository.findAll();
    }
}
