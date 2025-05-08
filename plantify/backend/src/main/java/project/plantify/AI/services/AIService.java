package project.plantify.AI.services;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import project.plantify.AI.exceptions.*;
import project.plantify.AI.payloads.request.PhotoRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Objects;

import static org.springframework.http.HttpStatus.*;

@Service
public class AIService {

    private final WebClient webClient;
    private final String apiKey;

    public AIService(@Qualifier("AI") WebClient webClient, @Value("${plant.net.api.key}") String apiKey) {
        this.webClient = webClient;
        this.apiKey = apiKey;
    }

    public PhotoAnalysisResponse analyzePhoto(List<MultipartFile> images, PhotoRequest request) {
        if (images.getFirst().getContentType() == null || images.isEmpty()) {
            throw new EmptyImageException("There is no image to analyze");
        }
        try {
            MultipartBodyBuilder requestBuilder = buildMultipartBody(images, request.getOrgans());
            return sendRequestToAPI(requestBuilder, request.getLang());
        } catch (WebClientResponseException e) {
            throw new PhotoAnalysisException("Server error", e);
        }
    }

    private MultipartBodyBuilder buildMultipartBody(List<MultipartFile> images, String organs) {
        MultipartBodyBuilder builder = new MultipartBodyBuilder();

        for (MultipartFile image : images) {
            builder.part("images", image.getResource())
                    .filename(Objects.requireNonNull(image.getOriginalFilename()));
        }
        builder.part("organs", organs);
        return builder;
    }

    private PhotoAnalysisResponse sendRequestToAPI(MultipartBodyBuilder requestBuilder, String lang) {
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
                .onStatus(HttpStatusCode::is4xxClientError, this::handle4xxError)
                .onStatus(HttpStatusCode::is5xxServerError, this::handle5xxError)
                .bodyToMono(PhotoAnalysisResponse.class)
                .block();
    }

    private Mono<? extends Throwable> handle4xxError(ClientResponse response) {
        return response
                .bodyToMono(String.class)
                .map(msg -> {
                    HttpStatusCode status = response.statusCode();
                    return switch (status) {
                        case NOT_FOUND -> new UnrecognizedPlantException("Plant unrecognized");
                        case BAD_REQUEST -> new UnsupportedMediaTypeException("Wrong file format");
                        case PAYLOAD_TOO_LARGE -> new MaxSizeException("File too large");
                        default -> new PhotoAnalysisException("Server error", new Throwable(msg));
                    };
                });
    }

    private Mono<? extends Throwable> handle5xxError(ClientResponse response) {
        return response
                .bodyToMono(String.class)
                .map(msg -> new PhotoAnalysisException("ServerError" , new Throwable(msg)));
    }
}
