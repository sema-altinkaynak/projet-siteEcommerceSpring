package drive.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import drive.model.Dock;

public interface DockRepository extends CrudRepository<Dock, Integer> {
	List<Dock> findAllByOrderByIdAsc(); 
	
	Dock findById(int id);
	Dock findTopByFree(boolean free);
	List<Dock> findAll();
	
	@Query(value="SELECT d.id FROM dock d "
	           + "WHERE ?1 < (d.x + d.width) and "
	           + "(?1 + ?3) > d.x and "
	           + "?2 < (d.y + d.length) and "
	           + "(?2 + ?4) > d.y",
	       nativeQuery = true)
	List<Integer> findAllDocksIdOnArea(int  x, int y, int width, int length); 
	
	@Query(value="SELECT d.id FROM dock d "
            + "WHERE ?1 < (d.x + d.width) and "
            + "(?1 + ?3) > d.x and "
            + "?2 < (d.y + d.length) and "
            + "(?2 + ?4) > d.y and "
            + "d.id != ?5",
        nativeQuery = true)
	List<Integer> findAllDocksIdOnAreaExcludingADockId(int x, int y, int width, int length, int idToExclude);

}
