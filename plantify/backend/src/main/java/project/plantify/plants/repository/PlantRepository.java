package project.plantify.plants.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import project.plantify.plants.models.Plant;

public interface PlantRepository extends JpaRepository<Plant, Integer> {
}
