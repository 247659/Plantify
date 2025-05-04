package project.plantify.guide.exceptions;

public class NotFoundSpeciesException extends RuntimeException {
    public NotFoundSpeciesException(String message) {
        super(message);
    }
}
