package project.plantify.guide.playloads.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.Getter;
import lombok.Setter;
import project.plantify.guide.services.ArrayToObjectDeserializer;
import project.plantify.guide.services.PruningCountDeserializer;
import project.plantify.guide.services.WateringBenchmarkDeserializer;

import java.util.List;

@Getter
@Setter
public class SinglePlantResponse {

    @JsonProperty("id")
    private int id;

    @JsonProperty("common_name")
    private String commonName;

    @JsonProperty("family")
    private String family;

    @JsonProperty("type")
    private String type;

    @JsonProperty("dimensions")
    private List<Dimensions> dimensions;

    @Getter
    @Setter
    public static class Dimensions {
        @JsonProperty("type")
        private String type;

        @JsonProperty("min_value")
        private String minValue;

        @JsonProperty("max_value")
        private String maxValue;

        @JsonProperty("unit")
        private String unit;
    }

    @JsonProperty("cycle")
    private String cycle;

    @JsonProperty("watering")
    private String watering;

    @JsonProperty("watering_general_benchmark")
    @JsonDeserialize(using = WateringBenchmarkDeserializer.class)
    private WateringBenchmark wateringGeneralBenchmark;

    @Getter
    @Setter
    public static class WateringBenchmark {
        @JsonProperty("value")
        private Integer value;

        @JsonProperty("unit")
        private String unit;
    }

    @JsonProperty("plant_anatomy")
    private List<PlantPart> plantAnatomy;

    @Getter
    @Setter
    public static class PlantPart {
        @JsonProperty("part")
        private String part;

        @JsonProperty("color")
        private List<String> color;
    }

    @JsonProperty("origin")
    private List<String> origin;

    @JsonProperty("sunlight")
    private List<String> sunlight;

    @JsonProperty("pruning_month")
    private List<String> pruningMonth;

    @JsonProperty("pruning_count")
    @JsonDeserialize(using = PruningCountDeserializer.class)
    private PruningCount pruningCount;

    @Getter
    @Setter
    public static class PruningCount {
        @JsonProperty("amount")
        private int amount;

        @JsonProperty("interval")
        private String interval;
    }

    @JsonProperty("seeds")
    private String seeds;

    @JsonProperty("propagation")
    private List<String> propagation;

    @JsonProperty("flowers")
    private boolean flowers;

    @JsonProperty("flowering_season")
    private String floweringSeason;

    @JsonProperty("soil")
    private List<String> soil;

    @JsonProperty("cones")
    private Boolean cones;

    @JsonProperty("fruits")
    private Boolean fruits;

    @JsonProperty("edible_fruit")
    private Boolean edibleFruit;

    @JsonProperty("fruiting_season")
    private String fruitingSeason;

    @JsonProperty("harvest_season")
    private String harvestSeason;

    @JsonProperty("harvest_method")
    private String harvestMethod;

    @JsonProperty("leaf")
    private Boolean leaf;

    @JsonProperty("edible_leaf")
    private Boolean edibleLeaf;

    @JsonProperty("growth_rate")
    private String growthRate;

    @JsonProperty("maintenance")
    private String maintenance;

    @JsonProperty("medicinal")
    private Boolean medicinal;

    @JsonProperty("poisonous_to_humans")
    private Boolean poisonousToHumans;

    @JsonProperty("poisonous_to_pets")
    private Boolean poisonousToPets;

    @JsonProperty("drought_tolerant")
    private Boolean droughtTolerant;

    @JsonProperty("salt_tolerant")
    private Boolean saltTolerant;

    @JsonProperty("thorny")
    private Boolean thorny;

    @JsonProperty("invasive")
    private Boolean invasive;

    @JsonProperty("rare")
    private Boolean rare;

    @JsonProperty("tropical")
    private Boolean tropical;

    @JsonProperty("cuisine")
    private Boolean cuisine;

    @JsonProperty("indoor")
    private Boolean indoor;

    @JsonProperty("care_level")
    private String careLevel;

    @JsonProperty("description")
    private String description;

    @JsonProperty("default_image")
    private Image defaultImage;

    @Getter
    @Setter
    public static class Image {
        @JsonProperty("image_id")
        private String imageId;

        @JsonProperty("original_url")
        private String originalUrl;

    }
//
//    @JsonProperty("xWateringQuality")
//    private List<String> xWateringQuality;

//    @JsonProperty("xWateringPeriod")
//    private List<String> xWateringPeriod;

//    @JsonProperty("xWateringAvgVolumeRequirement")
//    private List<String> xWateringAvgVolumeRequirement;

//    @JsonProperty("xWateringDepthRequirement")
//    private List<String> xWateringDepthRequirement;

//    @JsonProperty("xWateringBasedTemperature")
//    private Range xWateringBasedTemperature;

//    @JsonProperty("xWateringPhLevel")
//    private Range xWateringPhLevel;

//    @JsonProperty("xSunlightDuration")
//    private SunlightDuration xSunlightDuration;

//    @Getter
//    @Setter
//    public static class Range {
//        @JsonProperty("min")
//        private Double min;
//
//        @JsonProperty("max")
//        private Double max;
//
//        @JsonProperty("unit")
//        private String unit;
//    }
//
//    @Getter
//    @Setter
//    public static class SunlightDuration {
//        @JsonProperty("min")
//        private String min;
//
//        @JsonProperty("max")
//        private String max;
//
//        @JsonProperty("unit")
//        private String unit;
//    }
}
