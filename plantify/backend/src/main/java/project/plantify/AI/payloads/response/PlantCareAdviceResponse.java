package project.plantify.AI.payloads.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlantCareAdviceResponse {
    private String watering_eng;
    private String sunlight_eng;
    private String pruning_eng;
    private String fertilization_eng;
    private String watering_pl;
    private String sunlight_pl;
    private String pruning_pl;
    private String fertilization_pl;
}
