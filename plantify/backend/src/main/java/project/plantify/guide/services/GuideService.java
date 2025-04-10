package project.plantify.guide.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

@Service
public class GuideService {

    @Autowired
    private WebClient webClient;

    @Value("${plant.api.token}")
    private String apiToken;

    public String getAllPlant() {
        return webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species-list")
                        .queryParam("k", apiToken)
                        .build())
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }

    public String getAllPlantsBySpecies(String species) {
        return webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", species)
                        .build())
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }

    public String getSinglePlant(String id) {
        return webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species/details/").path(id)
                        .queryParam("key", apiToken)
                        .build())
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }
}
