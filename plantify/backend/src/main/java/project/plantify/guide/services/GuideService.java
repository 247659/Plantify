package project.plantify.guide.services;


import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cglib.core.Local;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import project.plantify.guide.exceptions.NotFoundSpeciesException;
import project.plantify.guide.exceptions.PerenualApiException;
import project.plantify.guide.playloads.response.*;
import reactor.core.publisher.Mono;

import java.util.*;
import java.util.stream.Collectors;

@Setter
@Service
public class GuideService {

    @Autowired
    @Qualifier("Guide")
    private WebClient webClient;

    @Autowired
    private  MessageSource messageSource;

    @Value("${plant.api.token}")
    private String apiToken;

    public List<PlantsResponseToFrontend> getAllPlant(Locale locale) {
        PlantsResponse plants =  webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/v2/species-list")
                        .queryParam("k", apiToken)
                        .build())
                .retrieve()
                .onStatus(HttpStatusCode::is5xxServerError, response ->
                        Mono.error(new PerenualApiException(messageSource.getMessage("error.failedConnection", null, locale))))
                .bodyToMono(PlantsResponse.class)
                .block();

        if (Objects.requireNonNull(plants).getData().isEmpty()) {
            throw new NotFoundSpeciesException(messageSource.getMessage("error.noPlants", null, locale));
        }

        return preparePlantsForFronted(Objects.requireNonNull(plants).getData());
    }

    public List<PlantsResponseToFrontend> getAllPlantsBySpecies(String species, Locale locale) {
        PlantsResponse plants = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/v2/species-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", species)
                        .build())
                .retrieve()
                .onStatus(HttpStatusCode::is5xxServerError, response ->
                        Mono.error(new PerenualApiException(messageSource.getMessage("error.failedConnection", null, locale))))
                .bodyToMono(PlantsResponse.class)
                .block();

        List<PlantsResponseToFrontend> plantsResponseToFrontends = preparePlantsForFronted(Objects.requireNonNull(plants).getData());

        Set<String> repeatedNames = new HashSet<>();
        List<PlantsResponseToFrontend> uniquePlants = plantsResponseToFrontends.stream()
                .filter(plant -> repeatedNames.add(plant.getCommonName()))
                .collect(Collectors.toList());

        uniquePlants.forEach(plant -> {
            if (plant.getOriginalUrl() == null || plant.getOriginalUrl().isEmpty() || plant.getOriginalUrl().contains("upgrade_access.jpg")) {
                plant.setOriginalUrl("https://images.unsplash.com/photo-1512428813834-c702c7702b78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8cGxhbnR8ZW58MHx8fHwxNzQ0MTMxOTgxfDA&ixlib=rb-4.0.3&q=80&w=1080");
            }
        });

        if (uniquePlants.isEmpty()) {
            System.out.println(messageSource.getMessage("error.noPlantsForSpecies", null, locale));
            throw new NotFoundSpeciesException(messageSource.getMessage("error.noPlantsForSpecies", null, locale));
        }
        return uniquePlants;

    }

    public SinglePlantResponseToFrontend getSinglePlant(String id, Locale locale) {
        SinglePlantResponse plant = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/v2/species/details/").path(id)
                        .queryParam("key", apiToken)
                        .build())
                .retrieve()
                .onStatus(HttpStatusCode::is5xxServerError, response ->
                        Mono.error(new PerenualApiException(messageSource.getMessage("error.failedConnection"
                                , null, locale))))
                .onStatus(HttpStatusCode::is4xxClientError, clientResponse ->
                        Mono.error(new NotFoundSpeciesException(messageSource.getMessage("error.noPlant", null, locale))))
                .bodyToMono(SinglePlantResponse.class)
                .block();

        return prepareSinglePlantForFronted(Objects.requireNonNull(plant));
    }

    public List<PlantsGuideFrontendResponse> getPlantsGuide(String name, Locale locale) {
        PlantsGuideResponse guides = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species-care-guide-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", name)
                        .build())
                .retrieve()
                .onStatus(HttpStatusCode::is5xxServerError, response ->
                        Mono.error(new PerenualApiException(messageSource.getMessage("error.failedConnection", null, locale))))
                .bodyToMono(PlantsGuideResponse.class)
                .block();

        return preparePlantsGuideForFrontend(Objects.requireNonNull(guides).getData());

    }

    public PlantsGuideFrontendResponse getPlantsGuideById(String speciesId, String name, Locale locale) throws RuntimeException {
        List<PlantsGuideFrontendResponse> guides = getPlantsGuide(name, locale);
        Optional<PlantsGuideFrontendResponse> guidesResponse = guides.stream().filter(g
                -> Objects.equals(g.getSpeciesId(), speciesId)).findFirst();

        return guidesResponse.orElseThrow(() ->
                new NotFoundSpeciesException(String.format(messageSource.getMessage("error.noGuide", null, locale), name))
        );
    }

    public List<PlantsFAQFrontendResponse> getPlantsFAQ(String name, Locale locale) {
        PlantsFAQResponse plantsFAQ = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/article-faq-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", name)
                        .build())
                .retrieve()
                .onStatus(HttpStatusCode::is5xxServerError, response ->
                        Mono.error(new PerenualApiException(messageSource.getMessage("error.failedConnection", null, locale))))
                .bodyToMono(PlantsFAQResponse.class)
                .block();

        if (preparePlantsFAQForFrontend(Objects.requireNonNull(plantsFAQ).getData()).isEmpty()) {
            System.out.println(messageSource.getMessage("error.noPlantsForSpecies", null, locale));
            throw new NotFoundSpeciesException(messageSource.getMessage("error.noPlantsForSpecies", null, locale));
        }
        return preparePlantsFAQForFrontend(Objects.requireNonNull(plantsFAQ).getData());
    }

    private List<PlantsFAQFrontendResponse> preparePlantsFAQForFrontend(List<PlantsFAQResponse.Data> data) {
        List<PlantsFAQFrontendResponse> plantsFAQResponseToFrontends = new ArrayList<>();
        for (PlantsFAQResponse.Data faq : data) {
            PlantsFAQFrontendResponse faqResponse = new PlantsFAQFrontendResponse();
            faqResponse.setId(faq.getId());
            faqResponse.setQuestion(faq.getQuestion());
            faqResponse.setAnswer(faq.getAnswer());
            plantsFAQResponseToFrontends.add(faqResponse);
        }
        return plantsFAQResponseToFrontends;
    }

    private List<PlantsGuideFrontendResponse> preparePlantsGuideForFrontend(List<PlantsGuideResponse.PlantData> guides) {
        List<PlantsGuideFrontendResponse> plantsGuideResponseToFrontends = new ArrayList<>();
        for (PlantsGuideResponse.PlantData guide : guides) {
            PlantsGuideFrontendResponse plantResponse = preparePlantGuide(guide);
            plantsGuideResponseToFrontends.add(plantResponse);
        }
        return plantsGuideResponseToFrontends;
    }

    private PlantsGuideFrontendResponse preparePlantGuide(PlantsGuideResponse.PlantData plant) {
        PlantsGuideFrontendResponse plantResponse = new PlantsGuideFrontendResponse();
        plantResponse.setId(String.valueOf(plant.getId()));
        plantResponse.setSpeciesId(String.valueOf(plant.getSpeciesId()));
        plantResponse.setCommonName(plant.getCommonName());

        plant.getSection().forEach(section -> {
            switch (section.getType()) {
                case "watering" -> plantResponse.setWatering(section.getDescription());
                case "sunlight" -> plantResponse.setSunLight(section.getDescription());
                case "pruning" -> plantResponse.setPruning(section.getDescription());
            }
        });

        return plantResponse;
    }

    private SinglePlantResponseToFrontend prepareSinglePlantForFronted(SinglePlantResponse plant) {
        SinglePlantResponseToFrontend plantResponse = new SinglePlantResponseToFrontend();
        plantResponse.setId(plant.getId());
        plantResponse.setCommonName(plant.getCommonName());
        plantResponse.setFamily(plant.getFamily());
        plantResponse.setType(plant.getType());

        List<SinglePlantResponseToFrontend.Dimensions> frontendDimensions = plant.getDimensions().stream()
                .map(d -> {
                    SinglePlantResponseToFrontend.Dimensions fd = new SinglePlantResponseToFrontend.Dimensions();
                    fd.setType(d.getType());
                    fd.setMinValue(d.getMinValue());
                    fd.setMaxValue(d.getMaxValue());
                    fd.setUnit(d.getUnit());
                    return fd;
                })
                .collect(Collectors.toList());
        plantResponse.setDimensions(frontendDimensions);

        plantResponse.setCycle(plant.getCycle());
        plantResponse.setWatering(plant.getWatering());


        SinglePlantResponseToFrontend.WateringBenchmark wateringBenchmark = new SinglePlantResponseToFrontend.WateringBenchmark();
        if (plant.getWateringGeneralBenchmark() != null) {
            wateringBenchmark.setUnit(plant.getWateringGeneralBenchmark().getUnit());
            wateringBenchmark.setValue(plant.getWateringGeneralBenchmark().getValue());
            plantResponse.setWateringGeneralBenchmark(wateringBenchmark);
        }

        List<SinglePlantResponseToFrontend.PlantPart> plantAnatomy = plant.getPlantAnatomy().stream()
                .map(pa -> {
                    SinglePlantResponseToFrontend.PlantPart part = new SinglePlantResponseToFrontend.PlantPart();
                    part.setPart(pa.getPart());
                    part.setColor(pa.getColor());
                    return part;
                })
                .collect(Collectors.toList());
        plantResponse.setPlantAnatomy(plantAnatomy);

        plantResponse.setSunlight(plant.getSunlight());
        plantResponse.setOrigin(plant.getOrigin());
        plantResponse.setPruningMonth(plant.getPruningMonth());

        SinglePlantResponseToFrontend.PruningCount pruningCount = new SinglePlantResponseToFrontend.PruningCount();
        if (plant.getPruningCount() != null) {
            pruningCount.setAmount(plant.getPruningCount().getAmount());
            pruningCount.setInterval(plant.getPruningCount().getInterval());
            plantResponse.setPruningCount(pruningCount);
        }

        plantResponse.setSeeds(plant.getSeeds());
        plantResponse.setPropagation(plant.getPropagation());
        plantResponse.setFlowers(plant.isFlowers());
        plantResponse.setFloweringSeason(plant.getFloweringSeason());

        plantResponse.setSoil(plant.getSoil());
        plantResponse.setCones(plant.getCones());
        plantResponse.setFruits(plant.getFruits());
        plantResponse.setEdibleFruit(plant.getEdibleFruit());
        plantResponse.setFruitingSeason(plant.getFruitingSeason());
        plantResponse.setHarvestSeason(plant.getHarvestSeason());
        plantResponse.setHarvestMethod(plant.getHarvestMethod());
        plantResponse.setLeaf(plant.getLeaf());
        plantResponse.setEdibleLeaf(plant.getEdibleLeaf());
        plantResponse.setGrowthRate(plant.getGrowthRate());
        plantResponse.setMaintenance(plant.getMaintenance());
        plantResponse.setMedicinal(plant.getMedicinal());
        plantResponse.setPoisonousToHumans(plant.getPoisonousToHumans());
        plantResponse.setPoisonousToPets(plant.getPoisonousToPets());
        plantResponse.setDroughtTolerant(plant.getDroughtTolerant());
        plantResponse.setSaltTolerant(plant.getSaltTolerant());
        plantResponse.setThorny(plant.getThorny());
        plantResponse.setInvasive(plant.getInvasive());
        plantResponse.setRare(plant.getRare());
        plantResponse.setTropical(plant.getTropical());
        plantResponse.setCuisine(plant.getCuisine());
        plantResponse.setIndoor(plant.getIndoor());
        plantResponse.setCareLevel(plant.getCareLevel());
        plantResponse.setDescription(plant.getDescription());

        if (plant.getDefaultImage() == null || plant.getDefaultImage().getOriginalUrl().contains("upgrade_access.jpg")) {
            plantResponse.setOriginalUrl("https://images.unsplash.com/photo-1512428813834-c702c7702b78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8cGxhbnR8ZW58MHx8fHwxNzQ0MTMxOTgxfDA&ixlib=rb-4.0.3&q=80&w=1080");
        } else {
            plantResponse.setOriginalUrl(plant.getDefaultImage().getOriginalUrl());
        }

        return plantResponse;
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
        if (plant.getDefaultImage() != null) {
            plantResponse.setOriginalUrl(plant.getDefaultImage().getOriginalUrl());
        } else {
            plantResponse.setOriginalUrl("https://images.unsplash.com/photo-1512428813834-c702c7702b78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8cGxhbnR8ZW58MHx8fHwxNzQ0MTMxOTgxfDA&ixlib=rb-4.0.3&q=80&w=1080");
        }
        return plantResponse;
    }
}
