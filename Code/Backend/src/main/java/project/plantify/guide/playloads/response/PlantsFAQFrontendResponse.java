package project.plantify.guide.playloads.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlantsFAQFrontendResponse {
    private int id;
    private String question;
    private String answer;
}
