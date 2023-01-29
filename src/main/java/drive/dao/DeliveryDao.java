package drive.dao;

import drive.model.CommandStatus;
import drive.model.Delivery;

import java.util.Date;
import java.util.List;
 
public interface DeliveryDao {

    List<Delivery> findAllByStatusAndDate(CommandStatus status, Date start, Date end);
}
