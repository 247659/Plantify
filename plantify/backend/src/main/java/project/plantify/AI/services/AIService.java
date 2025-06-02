package project.plantify.AI.services;

import org.hibernate.sql.results.spi.LoadContexts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.io.ByteArrayResource;
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
import project.plantify.AI.payloads.request.PhotoUrlRequest;
import project.plantify.AI.payloads.response.PhotoAnalysisResponse;
import reactor.core.publisher.Mono;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

import static org.springframework.http.HttpStatus.*;

@Service
public class AIService {

    private final WebClient webClient;
    private final String apiKey;

    @Autowired
    private MessageSource messageSource;

    public AIService(@Qualifier("AI") WebClient webClient, @Value("${plant.net.api.key}") String apiKey) {
        this.webClient = webClient;
        this.apiKey = apiKey;
    }

    public PhotoAnalysisResponse analyzePhotoUrl(PhotoUrlRequest photoRequest) {
        URL url = photoRequest.getUrl();

        Map<String, String> FORMAT_TO_MIME = Map.of(
                "png", MediaType.IMAGE_PNG_VALUE,
                "jpg", MediaType.IMAGE_JPEG_VALUE,
                "jpeg", MediaType.IMAGE_JPEG_VALUE
        );

        String path = url.getPath().toLowerCase();
        String extension = path.substring(path.lastIndexOf('.') + 1);
        String contentType = FORMAT_TO_MIME.get(extension);

        if (contentType == null) {
            throw new IllegalArgumentException("Nieobsługiwany format: " + extension);
        }

        try {
            BufferedImage image = ImageIO.read(url);
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            ImageIO.write(image, extension, outputStream);
            byte[] imageBytes = outputStream.toByteArray();
            ByteArrayResource imageResource = new ByteArrayResource(imageBytes) {
                @Override
                public String getFilename() {
                    return "image." + extension;
                }
            };

            MultipartBodyBuilder builder = new MultipartBodyBuilder();
            builder.part("images", imageResource).filename(imageResource.getFilename());
            builder.part("organs", photoRequest.getOrgans());

            return sendRequestToAPI(builder, photoRequest.getLang());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    public PhotoAnalysisResponse analyzePhoto(List<MultipartFile> images, PhotoRequest request) {
        Locale lang = LocaleContextHolder.getLocale();
        if (images.getFirst().getContentType() == null || images.isEmpty()) {
            throw new EmptyImageException(messageSource.getMessage("ai.noImage", null, lang));
        }
        try {
            MultipartBodyBuilder requestBuilder = buildMultipartBody(images, request.getOrgans());
            return sendRequestToAPI(requestBuilder, request.getLang());
        } catch (WebClientResponseException e) {
            throw new PhotoAnalysisException(messageSource.getMessage("ai.serverError", null, lang), e);
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
        Locale locale = LocaleContextHolder.getLocale();
        return response
                .bodyToMono(String.class)
                .map(msg -> {
                    HttpStatusCode status = response.statusCode();
                    return switch (status) {
                        case NOT_FOUND -> new UnrecognizedPlantException(messageSource.getMessage("ai.plantUnrecognized", null, locale));
                        case BAD_REQUEST -> new UnsupportedMediaTypeException(messageSource.getMessage("ai.badFormat", null, locale));
                        case PAYLOAD_TOO_LARGE -> new MaxSizeException(messageSource.getMessage("ai.toLarge", null, locale));
                        default -> new PhotoAnalysisException(messageSource.getMessage("ai.serverError", null, locale), new Throwable(msg));
                    };
                });
    }

    private Mono<? extends Throwable> handle5xxError(ClientResponse response) {
        Locale locale = LocaleContextHolder.getLocale();
        return response
                .bodyToMono(String.class)
                .map(msg -> new PhotoAnalysisException(messageSource.getMessage("ai.serverError", null, locale), new Throwable(msg)));
    }
}
