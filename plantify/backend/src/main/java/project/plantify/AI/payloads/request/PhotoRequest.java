package project.plantify.AI.payloads.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PhotoRequest {
    private String organs;
    private String lang;
}
