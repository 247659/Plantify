package project.plantify;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {
//    @Value("${plant.api.url}")
//    private String plantUrl;

    @Bean("Guide")
    public WebClient GuideWebClient(@Value("${plant.api.url}") String plantUrl) {
        return WebClient.builder().baseUrl(plantUrl).build();
    }

    @Bean("AI")
    public WebClient aiWebClient() {return WebClient.builder().baseUrl("https://my-api.plantnet.org/v2/identify").build();}
    
}
