package project.plantify.guide.services;

import com.github.tomakehurst.wiremock.junit5.WireMockExtension;
import com.github.tomakehurst.wiremock.client.WireMock;
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

import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
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
                "groq.api.key=test_groq_api_key",
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
    void shouldGetFAQ() throws Exception {
        String name = "strawberry";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/article-faq-list"))
                .withQueryParam("key", WireMock.matching(".*"))
                .withQueryParam("q", WireMock.equalTo(name))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                {
                                    "data": [
                                        {
                                            "id": 213,
                                            "question": "How long does it take for strawberry plants to produce fruit?",
                                            "answer": "Strawberry plants typically take 3-4 weeks from flowering to the production of a ripe berry. The entire process of planting and producing fruit can take up to 3 months, depending on the variety of strawberry being grown, climate and growing conditions. Some strawberries may bear fruit as early as 2 months from planting. Minature varieties are often the fastest ripening varieties, while larger varieties may take longer to bear fruit.",
                                            "tags": [
                                                "strawberry",
                                                "Strawberry Tree",
                                                "plants",
                                                "grow",
                                                "fruits"
                                            ],
                                            "default_image": {
                                                "license": 451,
                                                "license_name": "CC0 1.0 Universal (CC0 1.0) Public Domain Dedication",
                                                "license_url": "https://creativecommons.org/publicdomain/zero/1.0/",
                                                "original_url": "https://perenual.com/storage/article_faq/faq_213AylQ6435fc4f1a749/og.jpg",
                                                "regular_url": "https://perenual.com/storage/article_faq/faq_213AylQ6435fc4f1a749/regular.jpg",
                                                "medium_url": "https://perenual.com/storage/article_faq/faq_213AylQ6435fc4f1a749/medium.jpg"
                                            }
                                        },
                                        {
                                            "id": 214,
                                            "question": "Is it possible to grow strawberries from seed?",
                                            "answer": "Yes, it is possible to grow strawberries from seed. Growing strawberries from seed is often considered to be a bit more challenging than other fruits and vegetables, but with the right preparation and patience it can be done. You will need to use fresh, ripe strawberries to get the best chance for successful germination. You will also need to prepare a moist soil mix, plant the seeds in it, and ensure that the environment is moist but not soggy to create ideal germination conditions. If done properly, you can have strawberries ready for harvesting in approximately four months.",
                                            "tags": [
                                                "strawberry",
                                                "seeds",
                                                "grow",
                                                "fruits",
                                                "plants"
                                            ],
                                            "default_image": {
                                                "license": 451,
                                                "license_name": "CC0 1.0 Universal (CC0 1.0) Public Domain Dedication",
                                                "license_url": "https://creativecommons.org/publicdomain/zero/1.0/",
                                                "original_url": "https://perenual.com/storage/article_faq/faq_214kFmE6435fc4f51a91/og.jpg",
                                                "regular_url": "https://perenual.com/storage/article_faq/faq_214kFmE6435fc4f51a91/regular.jpg",
                                                "medium_url": "https://perenual.com/storage/article_faq/faq_214kFmE6435fc4f51a91/medium.jpg"
                                            }
                                        }
                                    ],
                                    "to": 18,
                                    "per_page": 30,
                                    "current_page": 1,
                                    "from": 1,
                                    "last_page": 1,
                                    "total": 18
                                }
                                """)
                ));

        mockMvc.perform(get("/api/plantify/guide/getPlantsFAQ")
                        .param("name", name))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].id", is(213)))
                .andExpect(jsonPath("$[0].question", is("How long does it take for strawberry plants to produce fruit?")))
                .andExpect(jsonPath("$[1].*", hasSize(3)));
    }

    @Test
    void getFAQEmptyData() throws Exception {
        String name = "strawberry";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/article-faq-list"))
                .withQueryParam("key", WireMock.matching(".*"))
                .withQueryParam("q", WireMock.equalTo(name))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                {
                                    "data": [],
                                    "to": 18,
                                    "per_page": 30,
                                    "current_page": 1,
                                    "from": 1,
                                    "last_page": 1,
                                    "total": 18
                                }
                                """)
                ));

        String expectedError = "No plants found for the given species.";
        mockMvc.perform(get("/api/plantify/guide/getPlantsFAQ")
                        .param("name", name))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message", is(expectedError)));
    }

    @Test
    void shouldGetPlantsGuideById() throws Exception {
        String name = "strawberry";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/species-care-guide-list"))
                .withQueryParam("key", WireMock.matching(".*"))
                .withQueryParam("q", WireMock.equalTo(name))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                {
                                    "data": [
                                        {
                                            "id": 588,
                                            "species_id": 183,
                                            "common_name": "Strawberry Tree",
                                            "scientific_name": [
                                                "Arbutus unedo"
                                            ],
                                            "section": [
                                                {
                                                    "id": 1765,
                                                    "type": "watering",
                                                    "description": "The Strawberry Tree prefers well-drained, acidic soil and likes to be watered deeply but not too frequently. During the spring and summer months, the strawberry tree should be watered every 7-10 days. In the autumn and winter, reduce watering frequency and only water every 3-4 weeks or when the soil is dry down to a depth of 2-3 inches below the surface. Make sure not to over-water, as this can lead to root rot. Use your finger to check the soil moisture before deciding to water your plant."
                                                },
                                                {
                                                    "id": 1766,
                                                    "type": "sunlight",
                                                    "description": "A Strawberry Tree (Arbutus unedo) requires full sun to partial shade. It performs best in areas where it receives at least 6 hours of direct sunlight each day. It can also tolerate light shade, but its growth may be slowed. During the summer months, it is beneficial to provide some afternoon shade, especially in hot climates, to prevent the leaves from scorching."
                                                },
                                                {
                                                    "id": 1767,
                                                    "type": "pruning",
                                                    "description": "Strawberry Tree (Arbutus unedo) should generally be pruned once yearly in the early spring months. This will help to maintain its desired form and size. Young trees can be pruned heavily to promote a better shape, but older trees should only be lightly pruned. All dead, diseased, and broken branches should be removed promptly to maintain the health of the plant. Pruning should include selectively removing no more than 1/3 of the tree's total growth in any given season."
                                                }
                                            ]
                                        },
                                        {
                                            "id": 590,
                                            "species_id": 181,
                                            "common_name": "Marina Strawberry Tree",
                                            "scientific_name": [
                                                "Arbutus 'Marina'"
                                            ],
                                            "section": [
                                                {
                                                    "id": 1771,
                                                    "type": "watering",
                                                    "description": "Watering a Marina Strawberry Tree should be done on a regular basis throughout the growing season. During its growing season, which is roughly between April and October, this tree should be watered 2 to 3 times a week.\\n\\nWater the plant until the soil is moist and be sure to water deeply so that the root system is watered thoroughly. During the winter, the tree should be watered every 2 weeks, but water the tree less in periods of cooler weather and less during the summer months when the soil will naturally be more moist.\\n\\nIt is important to make sure that the tree is not overwatered as this can lead to root rot and other diseases. A good way to ensure proper watering is to check the soil frequently and water when needed."
                                                },
                                                {
                                                    "id": 1772,
                                                    "type": "sunlight",
                                                    "description": "The Marina Strawberry Tree thrives best in full sun for at least 6 to 8 hours of direct sunlight per day. Plants grown in shade may not bloom or will produce fewer flowers. In warm climates, Marina Strawberry trees can perform well in semi-shade or lightly filtered sunlight. However, too much shade will lead to a less productive plant."
                                                },
                                                {
                                                    "id": 1773,
                                                    "type": "pruning",
                                                    "description": "Marina Strawberry Trees should be pruned twice a year, in spring and in late summer. In the spring, prune any damaged or dead wood, as well as crossing branches, suckers, and competing growth. The late summer pruning should remove any light suckers and reduce branch length to encourage flower bud formation and to increase air flow. Depending on the size of the tree, the amount of pruning should not exceed 1/3 - 1/2 of the total canopy. For smaller trees, prune lightly, removing no more than 1/3 of the canopy. For larger trees, 1/2 of the canopy can safely be removed without too much disruption to the overall structure."
                                                }
                                            ]
                                        }
                                    ],
                                    "to": 8,
                                    "per_page": 30,
                                    "current_page": 1,
                                    "from": 1,
                                    "last_page": 1,
                                    "total": 8
                                }
                                """)
                ));

        mockMvc.perform(get("/api/plantify/guide/getPlantsGuideById")
                        .param("speciesId", "183")
                        .param("speciesName", name))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("speciesId", is("183")))
                .andExpect(jsonPath("commonName", is("Strawberry Tree")))
                .andExpect(jsonPath("watering").isNotEmpty())
                .andExpect(jsonPath("sunLight").isNotEmpty())
                .andExpect(jsonPath("pruning").isNotEmpty());

    }

    @Test
    void getPlantsGuideByIdEmptyData() throws Exception {
        String name = "strawberry";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/species-care-guide-list"))
                .withQueryParam("key", WireMock.matching(".*"))
                .withQueryParam("q", WireMock.equalTo(name))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                {
                                    "data": [
                                        {
                                            "id": 588,
                                            "species_id": 183,
                                            "common_name": "Strawberry Tree",
                                            "scientific_name": [
                                                "Arbutus unedo"
                                            ],
                                            "section": [
                                                {
                                                    "id": 1765,
                                                    "type": "watering",
                                                    "description": "The Strawberry Tree prefers well-drained, acidic soil and likes to be watered deeply but not too frequently. During the spring and summer months, the strawberry tree should be watered every 7-10 days. In the autumn and winter, reduce watering frequency and only water every 3-4 weeks or when the soil is dry down to a depth of 2-3 inches below the surface. Make sure not to over-water, as this can lead to root rot. Use your finger to check the soil moisture before deciding to water your plant."
                                                },
                                                {
                                                    "id": 1766,
                                                    "type": "sunlight",
                                                    "description": "A Strawberry Tree (Arbutus unedo) requires full sun to partial shade. It performs best in areas where it receives at least 6 hours of direct sunlight each day. It can also tolerate light shade, but its growth may be slowed. During the summer months, it is beneficial to provide some afternoon shade, especially in hot climates, to prevent the leaves from scorching."
                                                },
                                                {
                                                    "id": 1767,
                                                    "type": "pruning",
                                                    "description": "Strawberry Tree (Arbutus unedo) should generally be pruned once yearly in the early spring months. This will help to maintain its desired form and size. Young trees can be pruned heavily to promote a better shape, but older trees should only be lightly pruned. All dead, diseased, and broken branches should be removed promptly to maintain the health of the plant. Pruning should include selectively removing no more than 1/3 of the tree's total growth in any given season."
                                                }
                                            ]
                                        },
                                        {
                                            "id": 590,
                                            "species_id": 181,
                                            "common_name": "Marina Strawberry Tree",
                                            "scientific_name": [
                                                "Arbutus 'Marina'"
                                            ],
                                            "section": [
                                                {
                                                    "id": 1771,
                                                    "type": "watering",
                                                    "description": "Watering a Marina Strawberry Tree should be done on a regular basis throughout the growing season. During its growing season, which is roughly between April and October, this tree should be watered 2 to 3 times a week.\\n\\nWater the plant until the soil is moist and be sure to water deeply so that the root system is watered thoroughly. During the winter, the tree should be watered every 2 weeks, but water the tree less in periods of cooler weather and less during the summer months when the soil will naturally be more moist.\\n\\nIt is important to make sure that the tree is not overwatered as this can lead to root rot and other diseases. A good way to ensure proper watering is to check the soil frequently and water when needed."
                                                },
                                                {
                                                    "id": 1772,
                                                    "type": "sunlight",
                                                    "description": "The Marina Strawberry Tree thrives best in full sun for at least 6 to 8 hours of direct sunlight per day. Plants grown in shade may not bloom or will produce fewer flowers. In warm climates, Marina Strawberry trees can perform well in semi-shade or lightly filtered sunlight. However, too much shade will lead to a less productive plant."
                                                },
                                                {
                                                    "id": 1773,
                                                    "type": "pruning",
                                                    "description": "Marina Strawberry Trees should be pruned twice a year, in spring and in late summer. In the spring, prune any damaged or dead wood, as well as crossing branches, suckers, and competing growth. The late summer pruning should remove any light suckers and reduce branch length to encourage flower bud formation and to increase air flow. Depending on the size of the tree, the amount of pruning should not exceed 1/3 - 1/2 of the total canopy. For smaller trees, prune lightly, removing no more than 1/3 of the canopy. For larger trees, 1/2 of the canopy can safely be removed without too much disruption to the overall structure."
                                                }
                                            ]
                                        }
                                    ],
                                    "to": 8,
                                    "per_page": 30,
                                    "current_page": 1,
                                    "from": 1,
                                    "last_page": 1,
                                    "total": 8
                                }
                                """)
                ));

        String expectedError = "Guide not found for species with name " + name;
        mockMvc.perform(get("/api/plantify/guide/getPlantsGuideById")
                        .param("speciesId", "1000")
                        .param("speciesName", name))
                .andDo(print())
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message", is(expectedError)));
    }

    @Test
    void shouldGetPlantsBySpecies() throws Exception {
        String species = "banana";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species-list"))
                .withQueryParam("key", WireMock.matching(".*"))
                .withQueryParam("q", WireMock.equalTo(species))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                {
                                          "data": [
                                              {
                                                  "id": 184,
                                                  "common_name": "Common Paw Paw",
                                                  "scientific_name": [
                                                      "Asimina triloba"
                                                  ],
                                                  "other_name": [
                                                      "Pawpaw Apple",
                                                      "False-Banana",
                                                      "Poor Man's Banana",
                                                      "Pawpaw",
                                                      "False Banana",
                                                      "Pawpaw Custardapple"
                                                  ],
                                                  "family": "Annonaceae",
                                                  "hybrid": null,
                                                  "authority": null,
                                                  "subspecies": null,
                                                  "cultivar": null,
                                                  "variety": null,
                                                  "species_epithet": "triloba",
                                                  "genus": "Asimina",
                                                  "default_image": {
                                                      "license": 5,
                                                      "license_name": "Attribution-ShareAlike License",
                                                      "license_url": "https://creativecommons.org/licenses/by-sa/2.0/",
                                                      "original_url": "https://perenual.com/storage/species_image/184_asimina_triloba/og/36488336082_9d0132fcd0_b.jpg",
                                                      "regular_url": "https://perenual.com/storage/species_image/184_asimina_triloba/regular/36488336082_9d0132fcd0_b.jpg",
                                                      "medium_url": "https://perenual.com/storage/species_image/184_asimina_triloba/medium/36488336082_9d0132fcd0_b.jpg",
                                                      "small_url": "https://perenual.com/storage/species_image/184_asimina_triloba/small/36488336082_9d0132fcd0_b.jpg",
                                                      "thumbnail": "https://perenual.com/storage/species_image/184_asimina_triloba/thumbnail/36488336082_9d0132fcd0_b.jpg"
                                                  }
                                              },
                                              {
                                                  "id": 1596,
                                                  "common_name": "sweet pepper",
                                                  "scientific_name": [
                                                      "Capsicum annuum 'Bananarama'"
                                                  ],
                                                  "other_name": [],
                                                  "family": "Solanaceae",
                                                  "hybrid": null,
                                                  "authority": null,
                                                  "subspecies": null,
                                                  "cultivar": "Bananarama",
                                                  "variety": null,
                                                  "species_epithet": "annuum",
                                                  "genus": "Capsicum",
                                                  "default_image": {
                                                      "license": 4,
                                                      "license_name": "Attribution License",
                                                      "license_url": "https://creativecommons.org/licenses/by/2.0/",
                                                      "original_url": "https://perenual.com/storage/species_image/1596_capsicum_annuum_bananarama/og/52253428433_0748cd6ff6_b.jpg",
                                                      "regular_url": "https://perenual.com/storage/species_image/1596_capsicum_annuum_bananarama/regular/52253428433_0748cd6ff6_b.jpg",
                                                      "medium_url": "https://perenual.com/storage/species_image/1596_capsicum_annuum_bananarama/medium/52253428433_0748cd6ff6_b.jpg",
                                                      "small_url": "https://perenual.com/storage/species_image/1596_capsicum_annuum_bananarama/small/52253428433_0748cd6ff6_b.jpg",
                                                      "thumbnail": "https://perenual.com/storage/species_image/1596_capsicum_annuum_bananarama/thumbnail/52253428433_0748cd6ff6_b.jpg"
                                                  }
                                              },
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
                                                  "default_image": null
                                              }
                                          ],
                                          "to": 16,
                                          "per_page": 30,
                                          "current_page": 1,
                                          "from": 1,
                                          "last_page": 1,
                                          "total": 16
                                      }
                                """)
                ));

        mockMvc.perform(get("/api/plantify/guide/getPlantsBySpecies")
                        .param("species", species))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].id", is("184")))
                .andExpect(jsonPath("$[0].commonName", is("Common Paw Paw")))
                .andExpect(jsonPath("$[0].originalUrl").value("https://perenual.com/storage/species_image/184_asimina_triloba/og/36488336082_9d0132fcd0_b.jpg"))
                .andExpect(jsonPath("$[0].*", hasSize(3)))
                .andExpect(jsonPath("$[1].id", is("1596")))
                .andExpect(jsonPath("$[1].commonName", is("sweet pepper")))
                .andExpect(jsonPath("$[1].originalUrl").value("https://perenual.com/storage/species_image/1596_capsicum_annuum_bananarama/og/52253428433_0748cd6ff6_b.jpg"))
                .andExpect(jsonPath("$[0].*", hasSize(3)));
    }

    @Test
    void getPlantBySpeciesEmptyData() throws Exception {
        String species = "banana";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species-list"))
                .withQueryParam("key", WireMock.matching(".*"))
                .withQueryParam("q", WireMock.equalTo(species))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                {
                                      "data": [],
                                      "to": 16,
                                      "per_page": 30,
                                      "current_page": 1,
                                      "from": 1,
                                      "last_page": 1,
                                      "total": 16
                                 }
                                """)
                ));

        String expectedError = "No plants found for the given species.";
        mockMvc.perform(get("/api/plantify/guide/getPlantsBySpecies")
                        .param("species", species))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message", is(expectedError)));
    }

    @Test
    void shouldGetSinglePlant() throws Exception {
        String plantId = "183";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species/details/" + plantId)) // Właściwy URL API
                .withQueryParam("key", WireMock.matching(".*"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                  {
                                      "id": 183,
                                      "common_name": "Strawberry Tree",
                                      "scientific_name": [
                                          "Arbutus unedo"
                                      ],
                                      "other_name": [
                                          "Apple of Cain; Cane Apple"
                                      ],
                                      "family": "Ericaceae",
                                      "hybrid": null,
                                      "authority": null,
                                      "subspecies": null,
                                      "cultivar": null,
                                      "variety": null,
                                      "species_epithet": "unedo",
                                      "genus": "Arbutus",
                                      "origin": [
                                          "Southern Europe",
                                          "western Asia",
                                          "northern Africa"
                                      ],
                                      "type": "tree",
                                      "dimensions": [
                                          {
                                              "type": "Height",
                                              "min_value": 25,
                                              "max_value": 25,
                                              "unit": "feet"
                                          }
                                      ],
                                      "cycle": "Perennial",
                                      "attracts": [],
                                      "propagation": [
                                          "Greenwood Cuttings",
                                          "Greenwood Cuttings",
                                          "Hardwood Cuttings",
                                          "Seed Propagation"
                                      ],
                                      "hardiness": {
                                          "min": "7",
                                          "max": "7"
                                      },
                                      "hardiness_location": {
                                          "full_url": "https://perenual.com/api/hardiness-map?species_id=183&size=og&key=sk-anZ367f82841555e99722",
                                          "full_iframe": "<iframe frameborder=0 scrolling=yes seamless=seamless width=1000 height=550 style='margin:auto;' src='https://perenual.com/api/hardiness-map?species_id=183&size=og&key=sk-anZ367f82841555e99722'></iframe>"
                                      },
                                      "watering": "Average",
                                      "watering_general_benchmark": {
                                          "value": 3,
                                          "unit": "days"
                                      },
                                      "plant_anatomy": [
                                          {
                                              "part": "stems",
                                              "color": [
                                                  "pink-red"
                                              ]
                                          },
                                          {
                                              "part": "leaves",
                                              "color": [
                                                  "dark-green"
                                              ]
                                          },
                                          {
                                              "part": "fruits",
                                              "color": [
                                                  "yellow-red"
                                              ]
                                          },
                                          {
                                              "part": "flowers",
                                              "color": [
                                                  "white-beige"
                                              ]
                                          },
                                          {
                                              "part": "stem",
                                              "color": [
                                                  "red-pink"
                                              ]
                                          },
                                          {
                                              "part": "branch",
                                              "color": [
                                                  "brown"
                                              ]
                                          }
                                      ],
                                      "sunlight": [
                                          "full sun",
                                          "part sun/part shade",
                                          "sheltered"
                                      ],
                                      "pruning_month": [
                                          "March",
                                          "April"
                                      ],
                                      "pruning_count": {
                                          "amount": 1,
                                          "interval": "yearly"
                                      },
                                      "seeds": true,
                                      "maintenance": "Low",
                                      "care_guides": "http://perenual.com/api/species-care-guide-list?species_id=183&key=sk-anZ367f82841555e99722",
                                      "soil": [
                                          "Well-drained"
                                      ],
                                      "growth_rate": "Moderate",
                                      "drought_tolerant": true,
                                      "salt_tolerant": false,
                                      "thorny": true,
                                      "invasive": false,
                                      "tropical": false,
                                      "indoor": false,
                                      "care_level": "Medium",
                                      "pest_susceptibility": [
                                          "Fungal leaf spot",
                                          " Root rot",
                                          " Scale insects",
                                          "  Drought resistant "
                                      ],
                                      "flowers": true,
                                      "flowering_season": "Winter",
                                      "cones": false,
                                      "fruits": true,
                                      "edible_fruit": true,
                                      "harvest_season": "Fall",
                                      "leaf": true,
                                      "edible_leaf": false,
                                      "cuisine": false,
                                      "medicinal": true,
                                      "poisonous_to_humans": false,
                                      "poisonous_to_pets": false,
                                      "description": "The Strawberry Tree (Arbutus unedo) is an amazing species that offers year-round beauty. It is a fruiting evergreen with attractive foliage and delicate whitish-pink blooms that develop into bright, red-orange fruits throughout the season. In addition to its showy beauty, this plant is incredibly hardy and can survive in a wide range of soil types and light conditions. With its easy maintenance and interesting lifestyle, the Strawberry Tree is a must for any gardener looking for a low-care, eye-catching addition to their landscape.",
                                      "default_image": {
                                          "license": 6,
                                          "license_name": "Attribution-NoDerivs License",
                                          "license_url": "https://creativecommons.org/licenses/by-nd/2.0/",
                                          "original_url": "https://perenual.com/storage/species_image/183_arbutus_unedo/og/50433219232_449b440340_b.jpg"
                                      },
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
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(Integer.valueOf(plantId))))
                .andExpect(jsonPath("$.commonName", is("Strawberry Tree")));
    }

    @Test
    void getSinglePlantEmptyImageURL() throws Exception {
        String plantId = "1668";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species/details/" + plantId))
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
                                           "dimensions": [],
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
                                               "value": 5,
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
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.originalUrl", is("https://images.unsplash.com/photo-1512428813834-c702c7702b78?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMXx8cGxhbnR8ZW58MHx8fHwxNzQ0MTMxOTgxfDA&ixlib=rb-4.0.3&q=80&w=1080")));
    }

    @Test
    void getSinglePlantInternalServerError() throws Exception {
        String plantId = "1668";

        wireMockServer.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species/details/" + plantId))
                        .withQueryParam("key", WireMock.matching(".*"))
                .willReturn(aResponse().withStatus(500)));

        String expectedError = "Failed to connect with external API. Please try again later.";
        this.mockMvc.perform(get("/api/plantify/guide/getSinglePlant")
                .param("id", plantId))
                .andExpect(status().isInternalServerError())
                .andExpect(jsonPath("$.message", is(expectedError)));

    }

    @Test
    void getSinglePlantNotFoundPlant() throws Exception {
        String plantId = "1000";
        wireMockServer.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species/details/" + plantId))
                .withQueryParam("key", WireMock.matching(".*"))
                .willReturn(aResponse().withStatus(429)));

        String expectedError = "Plant not found";
        mockMvc.perform(get("/api/plantify/guide/getSinglePlant")
                        .param("id", plantId))
                .andDo(print())
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message", is(expectedError)));
    }

    @Test
    void getSinglePlantEmptyArrays() throws Exception {
        String plantId = "183";
        WireMock.stubFor(WireMock.get(WireMock.urlPathEqualTo("/v2/species/details/" + plantId)) // Właściwy URL API
                .withQueryParam("key", WireMock.matching(".*"))
                .willReturn(aResponse()
                        .withHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                        .withBody("""
                                  {
                                      "id": 183,
                                      "common_name": "Strawberry Tree",
                                      "scientific_name": [
                                          "Arbutus unedo"
                                      ],
                                      "other_name": [
                                          "Apple of Cain; Cane Apple"
                                      ],
                                      "family": "Ericaceae",
                                      "hybrid": null,
                                      "origin": [],
                                      "type": "tree",
                                      "dimensions": [],
                                      "cycle": "Perennial",
                                      "attracts": [],
                                      "propagation": [
                                          "Greenwood Cuttings",
                                          "Greenwood Cuttings",
                                          "Hardwood Cuttings",
                                          "Seed Propagation"
                                      ],
                                      "hardiness": {
                                          "min": "7",
                                          "max": "7"
                                      },
                                      "hardiness_location": {
                                          "full_url": "https://perenual.com/api/hardiness-map?species_id=183&size=og&key=sk-anZ367f82841555e99722",
                                          "full_iframe": "<iframe frameborder=0 scrolling=yes seamless=seamless width=1000 height=550 style='margin:auto;' src='https://perenual.com/api/hardiness-map?species_id=183&size=og&key=sk-anZ367f82841555e99722'></iframe>"
                                      },
                                      "watering": "Average",
                                      "watering_general_benchmark": [],
                                      "plant_anatomy": [],
                                      "sunlight": [],
                                      "pruning_month": [],
                                      "pruning_count": [],
                                      "seeds": true,
                                      "maintenance": "Low",
                                      "care_guides": "http://perenual.com/api/species-care-guide-list?species_id=183&key=sk-anZ367f82841555e99722",
                                      "soil": [],
                                      "growth_rate": "Moderate",
                                      "drought_tolerant": true,
                                      "salt_tolerant": false,
                                      "thorny": true,
                                      "invasive": false,
                                      "tropical": false,
                                      "indoor": false,
                                      "care_level": "Medium",
                                      "pest_susceptibility": [
                                          "Fungal leaf spot",
                                          " Root rot",
                                          " Scale insects",
                                          "  Drought resistant "
                                      ],
                                      "flowers": true,
                                      "flowering_season": "Winter",
                                      "cones": false,
                                      "fruits": true,
                                      "edible_fruit": true,
                                      "harvest_season": "Fall",
                                      "leaf": true,
                                      "edible_leaf": false,
                                      "cuisine": false,
                                      "medicinal": true,
                                      "poisonous_to_humans": false,
                                      "poisonous_to_pets": false,
                                      "description": "The Strawberry Tree (Arbutus unedo) is an amazing species that offers year-round beauty. It is a fruiting evergreen with attractive foliage and delicate whitish-pink blooms that develop into bright, red-orange fruits throughout the season. In addition to its showy beauty, this plant is incredibly hardy and can survive in a wide range of soil types and light conditions. With its easy maintenance and interesting lifestyle, the Strawberry Tree is a must for any gardener looking for a low-care, eye-catching addition to their landscape.",
                                      "default_image": {
                                          "license": 6,
                                          "license_name": "Attribution-NoDerivs License",
                                          "license_url": "https://creativecommons.org/licenses/by-nd/2.0/",
                                          "original_url": "https://perenual.com/storage/species_image/183_arbutus_unedo/og/50433219232_449b440340_b.jpg"
                                      }
                                  }
                        """)
                ));

        mockMvc.perform(get("/api/plantify/guide/getSinglePlant")
                        .param("id", plantId)
                )
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.origin").isEmpty())
                .andExpect(jsonPath("$.dimensions").isEmpty())
                .andExpect(jsonPath("$.sunlight").isEmpty())
                .andExpect(jsonPath("$.wateringGeneralBenchmark").isEmpty())
                .andExpect(jsonPath("$.pruningMonth").isEmpty())
                .andExpect(jsonPath("$.pruningCount").isEmpty())
                .andExpect(jsonPath("$.soil").isEmpty())
                .andExpect(jsonPath("$.plantAnatomy").isEmpty());

    }

}
