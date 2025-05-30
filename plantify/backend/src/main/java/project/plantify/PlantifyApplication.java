package project.plantify;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

import java.util.Locale;

@SpringBootApplication
public class PlantifyApplication {

	public static void main(String[] args) {
		Dotenv dotenv = Dotenv.load();
		System.setProperty("DATABASE_URL", dotenv.get("DATABASE_URL"));
		System.setProperty("PLANT_API_TOKEN", dotenv.get("PLANT_API_TOKEN"));
		System.setProperty("SUPABASE_JWT_SECRET", dotenv.get("SUPABASE_JWT_SECRET"));
		System.setProperty("PLANT_NET_API_KEY", dotenv.get("PLANT_NET_API_KEY"));
		System.setProperty("GROQ_API_KEY", dotenv.get("GROQ_API_KEY"));
		System.setProperty("GROQCHAT_API_KEY", dotenv.get("GROQCHAT_API_KEY"));
		System.out.println(dotenv.get("PLANT_NET_API_KEY"));

		SpringApplication.run(PlantifyApplication.class, args);
	}

	@Bean
	public LocaleResolver localeResolver() {
		AcceptHeaderLocaleResolver resolver = new AcceptHeaderLocaleResolver();
		resolver.setDefaultLocale(Locale.ENGLISH);
		return resolver;
	}

	@Bean
	public MessageSource messageSource() {

		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("messages");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setFallbackToSystemLocale(false);
		return messageSource;
	}

}
