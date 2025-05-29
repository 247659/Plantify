package project.plantify.guide.services;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;
import project.plantify.guide.playloads.response.SinglePlantResponse.WateringBenchmark;

import java.io.IOException;

public class WateringBenchmarkDeserializer extends JsonDeserializer<WateringBenchmark> {

    @Override
    public WateringBenchmark deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JacksonException {
        JsonNode node = p.getCodec().readTree(p);

        // Pobierz pole "value" i dynamicznie dostosuj typ
        String cleanedValue;
        if (node.has("value")) {
            JsonNode valueNode = node.get("value");

            // Rozpoznaj, czy wartość to Integer, czy String
            if (valueNode.isInt()) {
                cleanedValue = String.valueOf(valueNode.intValue()); // Konwersja Integer -> String
            } else {
                cleanedValue = valueNode.asText().replace("\"", ""); // Usuń cudzysłowy, jeśli są
            }
        } else {
            cleanedValue = null; // Brak wartości
        }

        // Pobierz pole "unit" bez modyfikacji
        String unit = node.has("unit") ? node.get("unit").asText() : null;

        // Utwórz obiekt WateringBenchmark i ustaw wartości
        WateringBenchmark benchmark = new WateringBenchmark();
        benchmark.setValue(cleanedValue); // Wartość w postaci Stringa
        benchmark.setUnit(unit);

        return benchmark;
    }
}
