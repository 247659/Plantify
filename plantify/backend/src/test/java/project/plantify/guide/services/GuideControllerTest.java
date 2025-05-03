package project.plantify.guide.services;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.junit5.WireMockExtension;
import com.github.tomakehurst.wiremock.client.WireMock;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.wireMockConfig;
import static com.github.tomakehurst.wiremock.client.WireMock.*;

import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        properties = {
                "spring.profiles.active=test",
                "spring.datasource.url=jdbc:h2:mem:testdb",
                "spring.datasource.driver-class-name=org.h2.Driver",
                "spring.jpa.hibernate.ddl-auto=create-drop",
                "supabase.jwt.secret=test_jwt_secret",
                "plant.api.token=test_api_token",
                "plant.net.api.key=test_net_api_key",
        }
)
@AutoConfigureMockMvc
@Import(TestSecurityConfig.class)
class GuideControllerTest {

    @Autowired
    protected MockMvc mockMvc;

    @RegisterExtension
    static WireMockExtension wireMockServer = WireMockExtension.newInstance()
            .options(wireMockConfig().port(8080))
            .build();

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        // Klucz musi odpowiadać konfiguracji Twojego serwisu;
        // zakładając, że masz coś w stylu plant.api.base-url
        registry.add("plant.api.url", wireMockServer::baseUrl);
    }

    @Test
    void shouldGetSinglePlant() throws Exception {
        String plantId = "1668";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species/details/" + plantId)) // Właściwy URL API
                .withQueryParam("key", WireMock.matching(".*"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                  {
                                               "id": 1668,
                                               "common_name": "sedge",
                                               "scientific_name": [
                                                   "Carex siderosticha 'Banana Boat'"
                                               ],
                                               "other_name": [],
                                               "family": "Cyperaceae",
                                               "hybrid": null,
                                               "authority": null,
                                               "subspecies": null,
                                               "cultivar": "Banana Boat",
                                               "variety": null,
                                               "species_epithet": "siderosticha",
                                               "genus": "Carex",
                                               "origin": [
                                                   "Japan"
                                               ],
                                               "type": "Rush or Sedge",
                                               "dimensions": [
                                                   {
                                                       "type": null,
                                                       "min_value": 0.5,
                                                       "max_value": 1,
                                                       "unit": "feet"
                                                   }
                                               ],
                                               "cycle": "Perennial",
                                               "attracts": [],
                                               "propagation": [
                                                   "Division",
                                                   "Cutting",
                                                   "Seed Propagation",
                                                   "Layering Propagation"
                                               ],
                                               "hardiness": {
                                                   "min": "5",
                                                   "max": "9"
                                               },
                                               "hardiness_location": {
                                                   "full_url": "https://perenual.com/api/hardiness-map?species_id=1668&size=og&key=sk-anZ367f82841555e99722",
                                                   "full_iframe": "<iframe frameborder=0 scrolling=yes seamless=seamless width=1000 height=550 style='margin:auto;' src='https://perenual.com/api/hardiness-map?species_id=1668&size=og&key=sk-anZ367f82841555e99722'></iframe>"
                                               },
                                               "watering": "Average",
                                               "watering_general_benchmark": {
                                                   "value": null,
                                                   "unit": "days"
                                               },
                                               "plant_anatomy": [],
                                               "sunlight": [
                                                   "part shade",
                                                   "full shade"
                                               ],
                                               "pruning_month": [
                                                   "March",
                                                   "April",
                                                   "May"
                                               ],
                                               "pruning_count": [],
                                               "seeds": false,
                                               "maintenance": "Low",
                                               "care_guides": "http://perenual.com/api/species-care-guide-list?species_id=1668&key=sk-anZ367f82841555e99722",
                                               "soil": [],
                                               "growth_rate": "Low",
                                               "drought_tolerant": true,
                                               "salt_tolerant": true,
                                               "thorny": false,
                                               "invasive": false,
                                               "tropical": false,
                                               "indoor": false,
                                               "care_level": "Medium",
                                               "pest_susceptibility": [],
                                               "flowers": true,
                                               "flowering_season": null,
                                               "cones": false,
                                               "fruits": false,
                                               "edible_fruit": false,
                                               "harvest_season": null,
                                               "leaf": true,
                                               "edible_leaf": false,
                                               "cuisine": false,
                                               "medicinal": false,
                                               "poisonous_to_humans": false,
                                               "poisonous_to_pets": false,
                                               "description": "The Carex siderosticha 'Banana Boat' sedge is an amazing specimen for any landscape. This variety features bold, yellow blades that curve gracefully and elegantly, slightly resembling the hull of a banana boat. It is a garden workhorse, growing rapidly in spring and looking stunning with a backdrop of dark green foliage. Its evergreen foliage provides year-round interest, while its versatility as an ornamental and its hardiness make it a reliable choice for any garden or landscape. The feathery texture and vibrant yellow color of this sedge makes it a show-stopper and a must-have in any landscape.",
                                               "default_image": null,
                                               "other_images": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xWateringQuality": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xWateringPeriod": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xWateringAvgVolumeRequirement": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xWateringDepthRequirement": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xWateringBasedTemperature": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xWateringPhLevel": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xSunlightDuration": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xTemperatureTolence": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry",
                                               "xPlantSpacingRequirement": "Upgrade Plan To Supreme For Access https://perenual.com/subscription-api-pricing. Im sorry"
                                           }
                        """)
                ));

        mockMvc.perform(get("/api/plantify/guide/getSinglePlant")
                        .param("id", plantId)
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(Integer.valueOf(plantId))))
                .andExpect(jsonPath("$.commonName", is("sedge")));
    }
}
