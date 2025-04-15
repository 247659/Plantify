package project.plantify;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PlantifyApplication {

	public static void main(String[] args) {
		Dotenv dotenv = Dotenv.load();
		System.setProperty("DATABASE_URL", dotenv.get("DATABASE_URL"));
		System.setProperty("PLANT_API_TOKEN", dotenv.get("PLANT_API_TOKEN"));
		System.setProperty("SUPABASE_JWT_SECRET", dotenv.get("SUPABASE_JWT_SECRET"));
		System.setProperty("PLANT_NET_API_KEY", dotenv.get("PLANT_NET_API_KEY"));

		SpringApplication.run(PlantifyApplication.class, args);
	}

}
