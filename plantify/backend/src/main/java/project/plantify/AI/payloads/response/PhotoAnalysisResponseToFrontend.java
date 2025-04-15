package project.plantify.AI.payloads.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class PhotoAnalysisResponseToFrontend {
    private String bestMatch;
    private List<PlantMatch> results;

    @Getter
    @Setter
    @AllArgsConstructor
    public static class PlantMatch {
        private double score;
        private Species species;
    }

    @Getter
    @Setter
    @AllArgsConstructor
    public static class Species {
        private String scientificName;
        private List<String> commonNames;
    }

}
