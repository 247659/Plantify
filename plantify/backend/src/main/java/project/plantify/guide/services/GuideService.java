package project.plantify.guide.services;


import org.aspectj.weaver.patterns.HasThisTypePatternTriedToSneakInSomeGenericOrParameterizedTypePatternMatchingStuffAnywhereVisitor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import project.plantify.guide.playloads.response.*;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class GuideService {

    @Autowired
    @Qualifier("Guide")
    private WebClient webClient;

    @Value("${plant.api.token}")
    private String apiToken;

    public List<PlantsResponseToFrontend> getAllPlant() {
        PlantsResponse plants =  webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/v2/species-list")
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
                        .path("/v2/species-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", species)
                        .build())
                .retrieve()
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

        return uniquePlants;
    }

    public SinglePlantResponseToFrontend getSinglePlant(String id) {
        SinglePlantResponse plant = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/v2/species/details/").path(id)
                        .queryParam("key", apiToken)
                        .build())
                .retrieve()
                .bodyToMono(SinglePlantResponse.class)
                .block();

        System.out.println("CHECK");
        SinglePlantResponseToFrontend plantResponse = prepareSinglePlantForFronted(Objects.requireNonNull(plant));
        System.out.println("CHECK2");
        return checkNull(plantResponse);
    }

    private SinglePlantResponseToFrontend checkNull(SinglePlantResponseToFrontend plant) {
//        if (plant.getDimensions() == null || plant.getDimensions().isEmpty()) {
//            SinglePlantResponseToFrontend.Dimensions dimensions = new SinglePlantResponseToFrontend.Dimensions();
//            dimensions.setType("Unknown");
//            dimensions.setMinValue("Unknown");
//            dimensions.setMaxValue("Unknown");
//            dimensions.setUnit("Unknown");
//            plant.getDimensions().add(dimensions);
//        }
//        if (plant.getWateringGeneralBenchmark() == null) {
//            plant.setWateringGeneralBenchmark(new SinglePlantResponseToFrontend.WateringBenchmark());
//            plant.getWateringGeneralBenchmark().setUnit("Unknown");
//            plant.getWateringGeneralBenchmark().setValue("Unknown");
//        }
//        if (plant.getPruningCount() == null || plant.getPruningCount().isEmpty()) {
//            SinglePlantResponseToFrontend.PruningCount pruningCount = new SinglePlantResponseToFrontend.PruningCount();
//            pruningCount.setAmount(0);
//            pruningCount.setInterval("Unknown");
//            plant.getPruningCount().add(pruningCount);
//        }
//        if (plant.getPlantAnatomy() == null || plant.getPlantAnatomy().isEmpty()) {
//            SinglePlantResponseToFrontend.PlantPart plantPart = new SinglePlantResponseToFrontend.PlantPart();
//            plantPart.setPart("Unknown");
//            plantPart.getColor().add("Unknown");
//            plant.getPlantAnatomy().add(plantPart);
//        }

        if (plant.getOriginalUrl() == null || plant.getOriginalUrl().isEmpty() || plant.getOriginalUrl().contains("upgrade_access.jpg")) {
            plant.setOriginalUrl("https://images.unsplash.com/photo-1512428813834-c702c7702b78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8cGxhbnR8ZW58MHx8fHwxNzQ0MTMxOTgxfDA&ixlib=rb-4.0.3&q=80&w=1080");
        }

        return plant;
    }

    public List<PlantsGuideFrontendResponse> getPlantsGuide(String name) {
        PlantsGuideResponse guides = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/species-care-guide-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", name)
                        .build())
                .retrieve()
                .bodyToMono(PlantsGuideResponse.class)
                .block();

        return preparePlantsGuideForFrontend(Objects.requireNonNull(guides).getData());
    }

    public PlantsGuideFrontendResponse getPlantsGuideById(String speciesId, String name) {
        List<PlantsGuideFrontendResponse> guides = getPlantsGuide(name);
        Optional<PlantsGuideFrontendResponse> guidesResponse = guides.stream().filter(g
                -> Objects.equals(g.getSpeciesId(), speciesId)).findFirst();
        System.out.println(Objects.requireNonNull(guidesResponse.orElse(null)).getSpeciesId());
        return guidesResponse.orElse(null);
    }

    public List<PlantsFAQFrontendResponse> getPlantsFAQ(String name) {
        PlantsFAQResponse plantsFAQ = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/article-faq-list")
                        .queryParam("key", apiToken)
                        .queryParam("q", name)
                        .build())
                .retrieve()
                .bodyToMono(PlantsFAQResponse.class)
                .block();

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

        List<PlantsGuideFrontendResponse.Section> sections = plant.getSection().stream()
                .map(s -> {
                    PlantsGuideFrontendResponse.Section section = new PlantsGuideFrontendResponse.Section();
                    section.setId(String.valueOf(s.getId()));
                    section.setType(s.getType());
                    section.setDescription(s.getDescription());
                    return section;
                })
                .collect(Collectors.toList());
        plantResponse.setSections(sections);

        return plantResponse;
    }

    private SinglePlantResponseToFrontend prepareSinglePlantForFronted(SinglePlantResponse plant) {
        SinglePlantResponseToFrontend plantResponse = new SinglePlantResponseToFrontend();
        plantResponse.setId(plant.getId());
        plantResponse.setCommonName(plant.getCommonName());
        plantResponse.setFamily(plant.getFamily());
        plantResponse.setType(plant.getType());

        if (plant.getDimensions() == null || plant.getDimensions().isEmpty()) {
            plantResponse.setDimensions(null);
        } else {
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
        }


        plantResponse.setCycle(plant.getCycle());
        plantResponse.setWatering(plant.getWatering());

        if (plant.getWateringGeneralBenchmark() == null) {
            plantResponse.setWateringGeneralBenchmark(null);
        } else {
            SinglePlantResponseToFrontend.WateringBenchmark wateringBenchmark = new SinglePlantResponseToFrontend.WateringBenchmark();
            wateringBenchmark.setUnit(plant.getWateringGeneralBenchmark().getUnit());
            wateringBenchmark.setValue(plant.getWateringGeneralBenchmark().getValue());
            plantResponse.setWateringGeneralBenchmark(wateringBenchmark);
        }

        if (plant.getPlantAnatomy() == null || plant.getPlantAnatomy().isEmpty()) {
            plantResponse.setPlantAnatomy(null);
        }
        else {
            List<SinglePlantResponseToFrontend.PlantPart> plantAnatomy = plant.getPlantAnatomy().stream()
                    .map(pa -> {
                        SinglePlantResponseToFrontend.PlantPart part = new SinglePlantResponseToFrontend.PlantPart();
                        part.setPart(pa.getPart());
                        part.setColor(pa.getColor());
                        return part;
                    })
                    .collect(Collectors.toList());
            plantResponse.setPlantAnatomy(plantAnatomy);
        }

        plantResponse.setSunlight(plant.getSunlight());
        plantResponse.setPruningMonth(plant.getPruningMonth());

        System.out.println("HALOO");
        if (plant.getPruningCount() == null || plant.getPruningCount().isEmpty()) {
            plantResponse.setPruningCount(null);
        } else {
            List<SinglePlantResponseToFrontend.PruningCount> pruningCounts = plant.getPruningCount().stream()
                    .map(pc -> {
                        SinglePlantResponseToFrontend.PruningCount pcResponse = new SinglePlantResponseToFrontend.PruningCount();
                        pcResponse.setAmount(pc.getAmount());
                        pcResponse.setInterval(pc.getInterval());
                        return pcResponse;
                    })
                    .collect(Collectors.toList());
            plantResponse.setPruningCount(pruningCounts);
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
        if (plant.getDefaultImage() != null) {
            plantResponse.setOriginalUrl(plant.getDefaultImage().getOriginalUrl());
        } else {
            plantResponse.setOriginalUrl(null);
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
