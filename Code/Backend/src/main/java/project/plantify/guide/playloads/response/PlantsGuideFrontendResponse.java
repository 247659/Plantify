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
    private String watering;
    private String sunLight;
    private String pruning;

}
