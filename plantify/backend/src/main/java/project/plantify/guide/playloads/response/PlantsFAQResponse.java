package project.plantify.guide.playloads.response;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PlantsFAQResponse {
    private List<Data> data;

    @Getter
    @Setter
    public static class Data {
        private int id;
        private String question;
        private String answer;
    }
}
