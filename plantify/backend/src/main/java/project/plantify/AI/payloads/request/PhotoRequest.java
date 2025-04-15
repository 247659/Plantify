package project.plantify.AI.payloads.request;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
public class PhotoRequest {
//    private List<MultipartFile> photo;
    private String images;
    private String organs;
}
