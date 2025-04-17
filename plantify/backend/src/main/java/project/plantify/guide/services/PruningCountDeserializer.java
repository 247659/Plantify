package project.plantify.guide.services;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.ObjectCodec;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.node.ObjectNode;
import project.plantify.guide.playloads.response.SinglePlantResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PruningCountDeserializer extends JsonDeserializer<List<SinglePlantResponse.PruningCount>> {

    @Override
    public List<SinglePlantResponse.PruningCount> deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        ObjectCodec codec = p.getCodec();
        JsonNode node = codec.readTree(p);

        List<SinglePlantResponse.PruningCount> result = new ArrayList<>();

        ObjectMapper mapper = (ObjectMapper) codec;

        if (node.isArray()) {
            for (JsonNode element : node) {
                result.add(mapper.treeToValue(element, SinglePlantResponse.PruningCount.class));
            }
        } else if (node.isObject()) {
            result.add(mapper.treeToValue(node, SinglePlantResponse.PruningCount.class));
        }

        return result;
    }
}

