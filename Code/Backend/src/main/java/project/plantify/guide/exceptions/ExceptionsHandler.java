package project.plantify.guide.exceptions;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice(basePackages = "project.plantify.guide")
public class ExceptionsHandler {
    @ExceptionHandler(NotFoundSpeciesException.class)
    public ResponseEntity<ErrorMessage> handleNotFoundSpecies(NotFoundSpeciesException exception, HttpServletRequest request) {
        ErrorMessage errorMessage = new ErrorMessage(HttpStatus.NOT_FOUND.value(), exception.getMessage());
        errorMessage.setPath(request.getRequestURI());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
    }

    @ExceptionHandler(PerenualApiException.class)
    public ResponseEntity<ErrorMessage> handlePerenualApiException(PerenualApiException exception, HttpServletRequest request) {
        ErrorMessage errorMessage = new ErrorMessage(HttpStatus.INTERNAL_SERVER_ERROR.value(), exception.getMessage());
        errorMessage.setPath(request.getRequestURI());
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
    }

}
