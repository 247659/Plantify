package project.plantify.guide.playloads.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
@Getter
@Setter
public class PlantsResponse {

    @JsonProperty("data")
    private List<Plant> data;

    @Getter
    @Setter
    public static class Plant {
        private int id;
        @JsonProperty("common_name")
        private String commonName;
        @JsonProperty("scientific_name")
        private List<String> scientificName;
        @JsonProperty("default_image")
        private DefaultImage defaultImage;

        @Getter
        @Setter
        public static class DefaultImage {
            @JsonProperty("original_url")
            private String originalUrl;

        }
    }
}

