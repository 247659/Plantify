package project.plantify.guide.playloads.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlantsResponseToFrontend {
    private String id;
    private String commonName;
    private String originalUrl;
}
