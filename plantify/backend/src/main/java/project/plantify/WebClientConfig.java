package project.plantify;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {
    @Bean("Guide")
    public WebClient GuideWebClient() {
        return WebClient.builder().baseUrl("https://perenual.com/api").build();
    }

    @Bean("AI")
    public WebClient aiWebClient() {return WebClient.builder().baseUrl("https://my-api.plantnet.org/v2/identify").build();}
}
