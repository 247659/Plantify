package project.plantify.security;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // Wyłączenie CSRF dla testów
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().permitAll() // Zezwolenie na wszystkie requesty bez logowania
                );
        return http.build();
    }
}
