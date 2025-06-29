package project.plantify.guide.playloads.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PlantsGuideResponse {
    @JsonProperty("data")
    private List<PlantData> data;

    @Getter
    @Setter
    public static class PlantData {

        @JsonProperty("id")
        private int id;

        @JsonProperty("species_id")
        private int speciesId;

        @JsonProperty("common_name")
        private String commonName;

        @JsonProperty("section")
        private List<Section> section;

        @Getter
        @Setter
        public static class Section {
            @JsonProperty("id")
            private int id;

            @JsonProperty("type")
            private String type;

            @JsonProperty("description")
            private String description;

        }


    }


}
