package project.plantify.guide.playloads.response;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PlantsGuideFrontendResponse {
    private String id;
    private String speciesId;
    private String commonName;
    private List<Section> sections;

    @Getter
    @Setter
    public static class Section {
        private String id;
        private String type;
        private String description;
    }
}
