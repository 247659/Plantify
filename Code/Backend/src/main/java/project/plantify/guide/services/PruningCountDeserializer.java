package project.plantify.guide.services;

import project.plantify.guide.playloads.response.SinglePlantResponse;

public class PruningCountDeserializer extends ArrayToObjectDeserializer<SinglePlantResponse.PruningCount> {
    public PruningCountDeserializer() {
        super(SinglePlantResponse.PruningCount.class);
    }
}

