package drive.web;

import drive.mock.CommandeMockDao;
import drive.model.CommandMock;
import drive.model.CommandStatus;
import drive.model.Delivery;
import drive.repository.DeliveryRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping(path = "/statistic")
public class StatisticController {

    @Autowired
    DeliveryRepository dv;

    @Autowired
    CommandeMockDao cmd;

    @GetMapping(produces="text/html" )
    public String getCommandNumber(@RequestParam(required = false) String date,Model model) throws ParseException{

        Date start = new Date();
        Date end = new Date();

        // si la date est pas nulle alors on récupere celle en paramètre
        if(date!=null){
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy",Locale.FRANCE);
             start = formatter.parse(date);
             end = formatter.parse(date);
        }

        // On va récuperer seulement les livraison d'une journée 
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(start);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        
        Calendar calendar2 = Calendar.getInstance();
        calendar2.setTime(end);
        calendar2.set(Calendar.HOUR_OF_DAY, 0);
        calendar2.set(Calendar.MINUTE, 0);
        calendar2.set(Calendar.SECOND, 0);
        calendar2.add(Calendar.DAY_OF_YEAR, 1);
        
        // recuperation des commande livrée par tranche d'heure
        List<Object[]> obj = dv.findByDateAndHourAndStatus(calendar.getTime(),calendar2.getTime(),CommandStatus.DELIVERED);

        model.addAttribute("dateChosen", start);

        model.addAttribute("del",obj);

        model.addAttribute("date",calendar.getTime());

        // récuperation du nombre total de commande livrée
        Integer element = dv.findByCommandDelivered(calendar.getTime(),calendar2.getTime(),CommandStatus.DELIVERED);
        model.addAttribute("total", element);

        // récuperation du nombre de commande livrée par employée et par heure
        List<Object[]> empl = dv.findByDateAndHourAndStatusAndEmployeeLogin(calendar.getTime(),calendar2.getTime(),CommandStatus.DELIVERED);
        for (Object elem : empl) {
            System.out.println(elem);
        }
        model.addAttribute("empl",empl);


        List<Delivery> deliveries = dv.findByStatusAndDateBetween(CommandStatus.DELIVERED, calendar.getTime(),calendar2.getTime());
        
        int amount = 0;

        for (Delivery iterable : deliveries) {
            CommandMock md = cmd.find(iterable.getCommandId());
                amount= amount + md.getAmount();            
        }
        
        model.addAttribute("amount", amount);
        
        return "statistic";
    }

    @PostMapping()
    public String getDate(@RequestParam String date,Model model){
        //model.addAttribute("date", date);
        return "redirect:/app/statistic?date="+date;
    }
    
}
