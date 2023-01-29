package drive.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import drive.mock.CommandeMockDao;
import drive.mock.UserMock;
import drive.model.CommandMock;
import drive.model.CommandStatus;
import drive.model.Delivery;
import drive.model.Dock;
import drive.model.User;
import drive.repository.DeliveryRepository;
import drive.repository.DockRepository;

@Controller
@RequestMapping(path = "/borne")
public class BorneController {

    @Autowired
    UserMock userMock;
    
    @Autowired
    DeliveryRepository dv;

    @Autowired
    CommandeMockDao commandDao;

    @Autowired
    DockRepository dockDao;

    @RequestMapping(path = "/user.html", produces = "text/html")
    public String client() {        
        return "borne";
    }

    @RequestMapping(path = "/submit")
    public String submit(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        Delivery dev = new Delivery();
        CommandMock cmd;
        Dock dock;
        
        try {
            cmd = commandDao.findByUser(id);
        } catch (Exception e) {
            model.addAttribute("error", "User not Found.");
            return "redirect:/app/borne/user.html";
        }
        try {
            dock = dockDao.findTopByFree(true);
        }catch (Exception e) {
            model.addAttribute("error", "No Dock Free, please wait.");
            return "redirect:/app/borne/user.html";
        }
        
        if(cmd == null) {
            model.addAttribute("error", "User not Found.");
            return "redirect:/app/borne/user.html";
        }
        if(dock == null) {
            model.addAttribute("error", "No Dock Free, please wait.");
            return "redirect:/app/borne/user.html";
        }
        
        dev.setCommandId(cmd.getId());
        dev.setStatus(CommandStatus.READY_TO_DELIVER);
        dev.setEmployeeLogin(null);
        
        Date date = new Date();
        //Calendar calendar = Calendar.getInstance();
        //calendar.setTime(date);
        dev.setDate(date);
        
        dev.setDock(dock);
        dev = dv.save(dev);
        dock.setFree(false);
        dock= dockDao.save(dock);
        return "redirect:/app/codeBar/deliveryId/"+dev.getId()+".html";
    }

    
    @RequestMapping(path = "/all.html", produces = "text/html")
    public String employe(Model model) {
        model.addAttribute("users", userMock.getEmploye());
        model.addAttribute("commands", dv.findAllByStatus(CommandStatus.READY_TO_DELIVER));
        return "borneEmploye";
    }
    
    @PostMapping(path = "/select")
    public String select(HttpServletRequest request, Model model) {
        
        String login = request.getParameter("employe");
        String id = request.getParameter("command");
        if(id == null) {
            System.out.println("ID mauvais");
        }
        if(login == null) {
            System.out.println("login mauvais");
        }
        Delivery dev = dv.findById(Integer.parseInt(id));
        User emp = userMock.findEmployeByLogin(login);
        System.out.println("user = "+ emp.getId());
        dev.setEmployeeLogin(emp.getLogin());
        
        System.out.println("avant save");
        System.out.println(dev.getEmployeeLogin());
        dev = dv.save(dev);
        System.out.println("apres save");
        System.out.println(dev.getEmployeeLogin());
        
        return "redirect:/app/borne/all.html";
    }

}
