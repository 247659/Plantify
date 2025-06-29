package project.plantify.guide.services;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.ObjectCodec;
import com.fasterxml.jackson.databind.*;

import java.io.IOException;

public class ArrayToObjectDeserializer<T> extends JsonDeserializer<T> {

    private final Class<T> targetType;

    public ArrayToObjectDeserializer(Class<T> targetType) {
        this.targetType = targetType;
    }

    @Override
    public T deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        ObjectCodec codec = p.getCodec();
        JsonNode node = codec.readTree(p);

        ObjectMapper mapper = (ObjectMapper) codec;

        if (node.isArray()) {
            return null;
        } else if (node.isObject()) {
            return mapper.treeToValue(node, targetType);
        }
        return null;
    }
}

