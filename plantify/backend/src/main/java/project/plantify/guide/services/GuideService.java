package project.plantify.guide.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import project.plantify.guide.playloads.response.PlantsResponse;
import project.plantify.guide.playloads.response.PlantsResponseToFrontend;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class GuideService {

    @Autowired
    private WebClient webClient;

    @Value("${plant.api.token}")
    private String apiToken;

    public List<PlantsResponseToFrontend> getAllPlant() {
        PlantsResponse plants =  webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species-list")
                        .queryParam("k", apiToken)
                        .build())
                .retrieve()
                .bodyToMono(PlantsResponse.class)
                .block();

        return preparePlantsForFronted(Objects.requireNonNull(plants).getData());
    }

    public List<PlantsResponseToFrontend> getAllPlantsBySpecies(String species) {
        PlantsResponse plants = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", species)
                        .build())
                .retrieve()
                .bodyToMono(PlantsResponse.class)
                .block();

        return preparePlantsForFronted(Objects.requireNonNull(plants).getData());
    }

    public PlantsResponseToFrontend getSinglePlant(String id) {
        PlantsResponse.Plant plant = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species/details/").path(id)
                        .queryParam("key", apiToken)
                        .build())
                .retrieve()
                .bodyToMono(PlantsResponse.Plant.class)
                .block();

        return preperePlant(Objects.requireNonNull(plant));
    }

    private List<PlantsResponseToFrontend> preparePlantsForFronted(List<PlantsResponse.Plant> plants) {
        List<PlantsResponseToFrontend> plantsResponseToFrontends = new ArrayList<>();
        for (PlantsResponse.Plant plant : plants) {
            PlantsResponseToFrontend plantResponse = preperePlant(plant);
            plantsResponseToFrontends.add(plantResponse);
        }
        return plantsResponseToFrontends;
    }

    private PlantsResponseToFrontend preperePlant(PlantsResponse.Plant plant) {
        PlantsResponseToFrontend plantResponse = new PlantsResponseToFrontend();
        plantResponse.setId(String.valueOf(plant.getId()));
        plantResponse.setCommonName(plant.getCommonName());
        plantResponse.setOriginalUrl(plant.getDefaultImage().getOriginalUrl());
        return plantResponse;
    }
}
