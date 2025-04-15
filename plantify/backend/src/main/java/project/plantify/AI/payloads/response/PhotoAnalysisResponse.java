package project.plantify.AI.payloads.response;

import lombok.Data;

import java.util.List;

@Data
public class PhotoAnalysisResponse {
    private String id;
    private String label;
    private double confidence;
    private List<String> commonNames;
}
