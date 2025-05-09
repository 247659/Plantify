package project.plantify.guide.playloads.response;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class SinglePlantResponseToFrontend {
    private int id;
    private String commonName;
    private String family;
    private String type;
    private List<Dimensions> dimensions;
    private String cycle;
    private String watering;
    private WateringBenchmark wateringGeneralBenchmark;
    private List<PlantPart> plantAnatomy;
    private List<String> sunlight;
    private List<String> origin;
    private List<String> pruningMonth;
    private PruningCount pruningCount;
    private String seeds;
    private List<String> propagation;
    private boolean flowers;
    private String floweringSeason;
    private List<String> soil;
    private Boolean cones;
    private Boolean fruits;
    private Boolean edibleFruit;
    private String fruitingSeason;
    private String harvestSeason;
    private String harvestMethod;
    private Boolean leaf;
    private Boolean edibleLeaf;
    private String growthRate;
    private String maintenance;
    private Boolean medicinal;
    private Boolean poisonousToHumans;
    private Boolean poisonousToPets;
    private Boolean droughtTolerant;
    private Boolean saltTolerant;
    private Boolean thorny;
    private Boolean invasive;
    private Boolean rare;
    private Boolean tropical;
    private Boolean cuisine;
    private Boolean indoor;
    private String careLevel;
    private String description;
    private String originalUrl;


    @Getter
    @Setter
    public static class Dimensions {
        private String type;
        private String minValue;
        private String maxValue;
        private String unit;
    }

    @Getter
    @Setter
    public static class WateringBenchmark {
        private String value;
        private String unit;
    }

    @Getter
    @Setter
    public static class PlantPart {
        private String part;
        private List<String> color;
    }

    @Getter
    @Setter
    public static class PruningCount {
        private String amount;
        private String interval;
    }
}
