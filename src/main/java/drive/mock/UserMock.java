package drive.mock;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.stereotype.Component;

import drive.model.CommandMock;
import drive.model.Role;
import drive.model.User;

@Component
public class UserMock {
    private List<User> admins = new ArrayList<User>();
    private List<User> employe = new ArrayList<User>();
    private List<User> users = new ArrayList<User>();

    public UserMock() {
        {
            User u = new User();
            u.setId(0);
            u.setFirstname("admin");
            u.setLastname("admin");
            u.setLogin("admin");
            u.setPassword("root");
            u.setRole(Role.Admin);
            admins.add(u);
        }

        {
            User u = new User();
            u.setId(1);
            u.setFirstname("toto");
            u.setLastname("tot");
            u.setLogin("toto");
            u.setPassword("pass");
            u.setRole(Role.Employee);
            employe.add(u);

        }

        {
            User u = new User();
            u.setId(2);
            u.setFirstname("titi");
            u.setLastname("tit");
            u.setLogin("titi");
            u.setPassword("pass");
            u.setRole(Role.Employee);
            employe.add(u);
        }

        {
            User u = new User();
            u.setId(3);
            u.setFirstname("tutu");
            u.setLastname("tut");
            u.setLogin("tutu");
            u.setPassword("pass");
            u.setRole(Role.Employee);
            employe.add(u);
        }

        {
            User u = new User();
            u.setId(4);
            u.setFirstname("ctoto");
            u.setLastname("tot");
            u.setLogin("ctoto");
            u.setPassword("pass");
            u.setRole(Role.Client);
            users.add(u);
        }

        {
            User u = new User();
            u.setId(5);
            u.setFirstname("ctiti");
            u.setLastname("tit");
            u.setLogin("ctiti");
            u.setPassword("pass");
            u.setRole(Role.Client);
            users.add(u);
        }

        {
            User u = new User();
            u.setId(6);
            u.setFirstname("ctutu");
            u.setLastname("tut");
            u.setLogin("ctutu");
            u.setPassword("pass");
            u.setRole(Role.Client);
            users.add(u);
        }

    }

    public List<User> getAdmins() {
        return admins;
    }

    public List<User> getEmploye() {
        return employe;
    }

    public List<User> getClients() {
        return users;
    }

    public User getRandomEmploye() {
        Random rand = new Random();
        return employe.get(rand.nextInt(employe.size()));
    }

    public User findEmployeByLogin(String login) {
        for (User em : employe) {
            if (em.getLogin().equals(login)) {
                return em;
            }
        }
        return null;
    }
}
