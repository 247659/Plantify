package project.plantify.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final SupabaseJwtAuthFilter supabaseJwtAuthFilter;

    public SecurityConfig(SupabaseJwtAuthFilter supabaseJwtAuthFilter) {
        this.supabaseJwtAuthFilter = supabaseJwtAuthFilter;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable()).cors(Customizer.withDefaults())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/plantify/**").authenticated()
//                        .anyRequest().authenticated()// Zabezpieczony endpoint
//                        .anyRequest().permitAll() // Pozwól na dostęp do innych żądań
                )
                .addFilterBefore(supabaseJwtAuthFilter, UsernamePasswordAuthenticationFilter.class); // Dodaj nasz filtr przed standardowym filtrem
        return http.build();
    }

}