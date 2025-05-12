package project.plantify.guide.services;

import project.plantify.guide.playloads.response.SinglePlantResponse;

public class WateringBenchmarkDeserializer extends ArrayToObjectDeserializer<SinglePlantResponse.WateringBenchmark> {
    public WateringBenchmarkDeserializer() {
        super(SinglePlantResponse.WateringBenchmark.class);
    }
}

