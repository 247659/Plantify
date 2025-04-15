package project.plantify.AI.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import project.plantify.AI.payloads.request.PhotoRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import project.plantify.AI.payloads.response.PhotoAnalysisResponseToFrontend;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class AIService {

    @Autowired
    private WebClient webClient;

    public static int nbresults = 3;
    public static String lang = "en";
    private String PROJECT = "all?";
    private String NB_RESULTS = "nbresults=" + nbresults;
    private String API_LANG = "&lang=" + lang;

    @Value("${plant.net.api.key}")
    private String API_KEY;

    private String API_URL = "https://my-api.plantnet.org/v2/identify/" + PROJECT + NB_RESULTS + API_LANG + "?api-key=" + API_KEY;

    public PhotoAnalysisResponseToFrontend analyzePhoto(PhotoRequest request) {
//        List<MultipartFile> file = request.getPhoto();
//        MultipartFile multipartBody = request.getImages();
        System.out.println(API_URL);

//        var multipartBody = new LinkedMultiValueMap<String, Object>();
//        for (MultipartFile multipartFile : file) {
//            multipartBody.add("images", multipartFile);
//        }
//        multipartBody.add("organs", "auto");
//        MediaType mediaType = MediaType.parseMediaType(Objects.requireNonNull(multipartBody.getContentType()));
        MultipartBodyBuilder builder = new MultipartBodyBuilder();
        builder.part("images", request.getImages());
        builder.part("orangs", request.getOrgans());

        try {
            PhotoAnalysisResponseToFrontend response =  webClient.post()
                    .uri(API_URL)
                    .contentType(MediaType.MULTIPART_FORM_DATA)
                    .body(BodyInserters.fromMultipartData(builder.build()))
                    .retrieve()
                    .bodyToMono(PhotoAnalysisResponseToFrontend.class)
                    .block();

            List<PhotoAnalysisResponseToFrontend.PlantMatch> results = Objects.requireNonNull(response).getResults()
                    .stream()
                    .map(result -> {
                        PhotoAnalysisResponseToFrontend.Species species = result.getSpecies();
                        return new PhotoAnalysisResponseToFrontend.PlantMatch(
                                result.getScore(),
                                new PhotoAnalysisResponseToFrontend.Species(
                                        species.getScientificName(),
                                        species.getCommonNames()
                                )
                        );
                    })
                    .collect(Collectors.toList());

            return new PhotoAnalysisResponseToFrontend(response.getBestMatch(), results);

        } catch (RuntimeException e) {
            throw new RuntimeException("Błąd podczas wysyłania pliku do API", e);
        }
    }

}
