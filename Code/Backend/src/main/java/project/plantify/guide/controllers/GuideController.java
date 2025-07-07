package project.plantify.guide.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import project.plantify.guide.exceptions.ErrorMessage;
import project.plantify.guide.exceptions.NotFoundSpeciesException;
import project.plantify.guide.exceptions.PerenualApiException;
import project.plantify.guide.playloads.response.*;
import project.plantify.guide.services.GuideService;
import project.plantify.translation.service.TranslationService;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/api/plantify/guide")
public class GuideController {

    @Autowired
    private GuideService guideService;

    @Autowired
    private TranslationService translationService;

    /**
     Nigdzie nie wykorzystywane, ale zostawiam na przyszłość
     */
//    @GetMapping("/getAll")
//    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlants(@RequestHeader(name = "Accept-Language", required = false) Locale locale) {
//        List<PlantsResponseToFrontend> response = this.guideService.getAllPlant(locale);
//        System.out.println(response);
//        return ResponseEntity.ok(response);
//    }

    @GetMapping("/getPlantsBySpecies")
    public ResponseEntity<List<PlantsResponseToFrontend>> getAllPlantsBySpecies(@RequestParam("species") String species,
                                                                                @RequestHeader(name = "Accept-Language", required = false) Locale locale){
        List<PlantsResponseToFrontend> response = this.guideService.getAllPlantsBySpecies(species.toLowerCase(), locale);
        System.out.println(response);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getSinglePlant")
    public ResponseEntity<SinglePlantResponseToFrontend> getSinglePlant(@RequestParam("id") String id,
                                                                        @RequestHeader(name = "Accept-Language", required = false) Locale locale) {
        SinglePlantResponseToFrontend response = this.guideService.getSinglePlant(id, locale);
        if (locale.getLanguage().equals("pl")) {
            response = translationService.translateSinglePlant(response, "en", locale.getLanguage());
        }
        return ResponseEntity.ok(response);
    }

//    @GetMapping("/getPlantsGuide")
//    public ResponseEntity<List<PlantsGuideFrontendResponse>> getPlantsGuide(@RequestParam("name") String name,
//                                                                            @RequestHeader(name = "Accept-Language", required = false) Locale locale) {
//        List<PlantsGuideFrontendResponse> response = this.guideService.getPlantsGuide(name.toLowerCase(), locale);
//        System.out.println(response);
//        return ResponseEntity.ok(response);
//    }

    @GetMapping("/getPlantsGuideById")
    public ResponseEntity<PlantsGuideFrontendResponse> getPlantsGuideById(@RequestParam("speciesId") String id,
                                                                          @RequestParam("speciesName") String name,
                                                                          @RequestHeader(name = "Accept-Language", required = false) Locale locale) {
        PlantsGuideFrontendResponse response = this.guideService.getPlantsGuideById(id, name.toLowerCase(), locale);
        if (locale.getLanguage().equals("pl")) {
            response = translationService.translateGuide(response, "en", locale.getLanguage());
        }
       return ResponseEntity.ok(response);
    }

    @GetMapping("/getPlantsFAQ")
    public ResponseEntity<List<PlantsFAQFrontendResponse>> getPlantsFAQ(@RequestParam("name") String name,
                                                                        @RequestHeader(name = "Accept-Language", required = false) Locale locale) {

        List<PlantsFAQFrontendResponse> response = this.guideService.getPlantsFAQ(name.toLowerCase(), locale);
        if (locale.getLanguage().equals("pl")) {
            response = translationService.translateFAQ(response, "en", locale.getLanguage());
        }
        return ResponseEntity.ok(response);
    }

}
