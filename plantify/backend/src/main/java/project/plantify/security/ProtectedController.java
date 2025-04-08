package project.plantify.security;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

@RestController
public class ProtectedController {

    @GetMapping("/api/plantify/hello")
    public String securedHello(@AuthenticationPrincipal String userId) {
        System.out.println("[CONTROLLER] Reached /api/protected/hello");
        System.out.println("[CONTROLLER] Authenticated userId: " + userId);

        return "Witaj, użytkowniku o ID: " + userId;
    }

}

