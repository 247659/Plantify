package project.plantify.AI.payloads.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlantCareAdviceResponse {
    private String watering;
    private String sunlight;
    private String pruning;
    private String fertilization;
}
