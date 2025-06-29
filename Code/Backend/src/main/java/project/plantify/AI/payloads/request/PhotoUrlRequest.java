package project.plantify.AI.payloads.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import java.net.URL;

@Getter
@Setter
@AllArgsConstructor
public class PhotoUrlRequest {
    private URL url;
    private String organs;
    private String lang;
}
