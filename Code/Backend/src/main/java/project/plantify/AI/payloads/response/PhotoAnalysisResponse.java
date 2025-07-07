package project.plantify.AI.payloads.response;

import lombok.Data;

import java.util.List;

@Data
public class PhotoAnalysisResponse {
    private Query query;
    private List<PredictedOrgan> predictedOrgans;
    private String language;
    private String preferedReferential;
    private String bestMatch;
    private Result results;
    private String version;
    private int remainingIdentificationRequests;

    @Data
    public static class Query {
        private String project;
        private List<String> images;
        private List<String> organs;
        private boolean includeRelatedImages;
        private boolean noReject;
        private String type;
    }

    @Data
    public static class PredictedOrgan {
        private String image;
        private String filename;
        private String organ;
        private double score;
    }

    @Data
    public static class Result {
        private double score;
        private Species species;
        private Gbif gbif;
        private Powo powo;
    }

    @Data
    public static class Species {
        private String scientificNameWithoutAuthor;
        private String scientificNameAuthorship;
        private Genus genus;
        private Family family;
        private List<String> commonNames;
        private String scientificName;
    }

    @Data
    public static class Genus {
        private String scientificNameWithoutAuthor;
        private String scientificNameAuthorship;
        private String scientificName;
    }

    @Data
    public static class Family {
        private String scientificNameWithoutAuthor;
        private String scientificNameAuthorship;
        private String scientificName;
    }

    @Data
    public static class Gbif {
        private String id;
    }

    @Data
    public static class Powo {
        private String id;
    }
}
