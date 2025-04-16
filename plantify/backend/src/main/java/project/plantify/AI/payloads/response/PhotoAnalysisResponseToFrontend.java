package project.plantify.AI.payloads.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class PhotoAnalysisResponseToFrontend {
    private String bestMatch;
    private List<PhotoAnalysisResponse.Result> results;
}
