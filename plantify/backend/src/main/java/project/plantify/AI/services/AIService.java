package project.plantify.AI.services;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import project.plantify.AI.exceptions.MaxSizeException;
import project.plantify.AI.exceptions.PhotoAnalysisException;
import project.plantify.AI.exceptions.ResourceNotFoundException;
import project.plantify.AI.exceptions.UnsupportedMediaTypeException;
import project.plantify.AI.payloads.request.PhotoRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;

import java.util.List;
import java.util.Objects;

@Service
public class AIService {

    private final WebClient webClient;
    private final String apiKey;

    public AIService(@Qualifier("AI") WebClient webClient, @Value("${plant.net.api.key}") String apiKey) {
        this.webClient = webClient;
        this.apiKey = apiKey;
    }

    public PhotoAnalysisResponse analyzePhoto(List<MultipartFile> images, PhotoRequest request) {
        try {
            MultipartBodyBuilder requestBuilder = buildRequest(images, request.getOrgans());
            return sendRequestToAPI(requestBuilder, request.getLang());
        } catch (WebClientResponseException e) {
            throw new PhotoAnalysisException("Server error", e);
        }
    }

    public MultipartBodyBuilder buildRequest(List<MultipartFile> images, String organs) {
        MultipartBodyBuilder builder = new MultipartBodyBuilder();

        for (MultipartFile image : images) {
            builder.part("images", image.getResource())
                    .filename(Objects.requireNonNull(image.getOriginalFilename()));
        }
        builder.part("organs", organs);
        return builder;
    }

    public PhotoAnalysisResponse sendRequestToAPI(MultipartBodyBuilder requestBuilder, String lang) {
        return webClient.post()
                .uri(uriBuilder -> uriBuilder
                        .path("/all")
                        .queryParam("nb-results", "1")
                        .queryParam("lang", lang)
                        .queryParam("api-key", apiKey)
                        .build())
                .contentType(MediaType.MULTIPART_FORM_DATA)
                .body(BodyInserters.fromMultipartData(requestBuilder.build()))
                .retrieve()
                .onStatus(HttpStatusCode::is4xxClientError, response -> {
                    if (response.statusCode() == HttpStatus.NOT_FOUND) {
                        return response
                                .bodyToMono(String.class)
                                .map(msg -> new ResourceNotFoundException("Plant unrecognized"));
                    }
                    if (response.statusCode() == HttpStatus.BAD_REQUEST) {
                        return response
                                .bodyToMono(String.class)
                                .map(msg -> new UnsupportedMediaTypeException("Wrong file format"));
                    }
                    if (response.statusCode() == HttpStatus.PAYLOAD_TOO_LARGE) {
                        return response
                                .bodyToMono(String.class)
                                .map(msg -> new MaxSizeException("File too large"));
                    }
                    return response
                            .bodyToMono(String.class)
                            .map(msg -> new PhotoAnalysisException("Server error", new Throwable(msg)));
                })
                .onStatus(HttpStatusCode::is5xxServerError, response -> response
                        .bodyToMono(String.class)
                        .map(msg -> new PhotoAnalysisException("ServerError" , new Throwable(msg))))
                .bodyToMono(PhotoAnalysisResponse.class)
                .block();
    }
}
