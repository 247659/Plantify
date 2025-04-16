package project.plantify.security;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;

@Component
public class SupabaseJwtAuthFilter extends OncePerRequestFilter {

    private final SupabaseJwtValidator jwtValidator;

    public SupabaseJwtAuthFilter(SupabaseJwtValidator jwtValidator) {
        this.jwtValidator = jwtValidator;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // Sprawdzamy nagłówek Authorization
        String authHeader = request.getHeader("Authorization");

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.replace("Bearer ", "");

            // Walidacja tokena
            if (jwtValidator.validateToken(token)) {
                // Uzyskujemy Claims z tokena (np. Subject)
                Claims claims = jwtValidator.getClaims(token);
                String userId = claims.getSubject(); // Możesz także dodać inne dane z tokena, jak email, role itd.

                // Tworzymy token autoryzacyjny
                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(userId, null, new ArrayList<>());

                // Ustawiamy kontekst bezpieczeństwa
                SecurityContextHolder.getContext().setAuthentication(authentication);
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("Invalid JWT token");
                return; // Zatrzymujemy przetwarzanie, bo token jest niepoprawny
            }
        }
//        else {
//            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//            response.getWriter().write("Missing or invalid Authorization header");
//            return; // Zatrzymujemy przetwarzanie, bo nagłówek jest niepoprawny
//        }

        // Przechodzimy do kolejnego filtra w łańcuchu
        filterChain.doFilter(request, response);
    }
}
