package project.plantify.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.SignatureException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
@Component
public class SupabaseJwtValidator {

    private String secret = "WgcMITsQCp0jy850hLGhgzaD3hCQmQ79nTRf0ErHFBaYaG8tn3CWTiD3smvshOkNyMs6qnEpXKnjGtKWHb57CA==";

    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder()
                    .setSigningKey(secret.getBytes(StandardCharsets.UTF_8)) // HS256 key
                    .build()
                    .parseClaimsJws(token);

            return true; // Token poprawny

        } catch (ExpiredJwtException e) {
            System.out.println("Token wygasł: " + e.getMessage());
        } catch (UnsupportedJwtException e) {
            System.out.println("Nieobsługiwany token: " + e.getMessage());
        } catch (MalformedJwtException e) {
            System.out.println("Niepoprawny token: " + e.getMessage());
        } catch (SignatureException e) {
            System.out.println("Niepoprawny podpis tokena: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Błąd przy walidacji tokena: " + e.getMessage());
        }

        return false;
    }

    public Claims getClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(secret.getBytes(StandardCharsets.UTF_8))
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}