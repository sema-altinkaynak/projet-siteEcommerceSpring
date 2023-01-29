package drive.repository;
import drive.dao.DeliveryDao;
import drive.model.CommandStatus;
import drive.model.Delivery;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface DeliveryRepository extends DeliveryDao, CrudRepository<Delivery,Long> {

    @Query("select hour(d.date) as heure,count(*) as cpt from Delivery d where d.date>=?1 and d.date<?2 and d.status=?3 group by hour(d.date) ")
    List<Object[]> findByDateAndHourAndStatus(Date start, Date end, CommandStatus status);

    @Query("select count(*) from Delivery d where d.date>=?1 and d.date<?2 and d.status=?3 ")
    Integer findByCommandDelivered(Date start, Date end, CommandStatus status);

    @Query("select d.employeeLogin,hour(d.date) as heure,count(*) as cpt from Delivery d where d.date>=?1 and d.date<?2 and d.status=?3 group by d.employeeLogin,hour(d.date) order by d.employeeLogin")
    List<Object[]> findByDateAndHourAndStatusAndEmployeeLogin(Date start, Date end, CommandStatus status);
    Delivery findById(Integer id);
    Delivery findByCodeBarId(String codeBarId);
    boolean existsByCodeBarId(String codeBarId);
    List<Delivery> findAllByStatus(CommandStatus status);
    List<Delivery> findByStatusAndDateBetween(CommandStatus status,Date start,Date end);    
}
