package drive.mock;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import drive.model.CommandMock;
import drive.model.CommandStatus;

@Component
public class CommandeMockDao {
	private HashMap<String, CommandMock> commands = new HashMap<>();

	public CommandeMockDao() {
		{
			CommandMock a = new CommandMock();
			a.setId("1");
			a.setUserID("Reda");
			a.setStatus(CommandStatus.READY_TO_DELIVER);
			a.setAmount(120);
			commands.put(a.getId(), a);
		}
		
		{
			CommandMock a = new CommandMock();
			a.setId("2");
			a.setUserID("Bekir");
			a.setStatus(CommandStatus.READY_TO_DELIVER);
			a.setAmount(420);
			commands.put(a.getId(), a);
		}
		
		{
			CommandMock a = new CommandMock();
			a.setId("3");
			a.setUserID("Louis");
			a.setStatus(CommandStatus.READY_TO_DELIVER);
			a.setAmount(12);
			commands.put(a.getId(), a);
		}
		
		{
			CommandMock a = new CommandMock();
			a.setId("4");
			a.setUserID("Sema");
			a.setStatus(CommandStatus.READY_TO_DELIVER);
			a.setAmount(49);
			commands.put(a.getId(), a);
		}
		{
			CommandMock a = new CommandMock();
			a.setId("5");
			a.setUserID("one");
			a.setStatus(CommandStatus.DELIVERED);
			commands.put(a.getId(), a);
		}
		{
			CommandMock a = new CommandMock();
			a.setId("6");
			a.setUserID("one1");
			a.setStatus(CommandStatus.DELIVERED);
			a.setAmount(484);
			commands.put(a.getId(), a);
		}
		{
			CommandMock a = new CommandMock();
			a.setId("7");
			a.setUserID("one2");
			a.setStatus(CommandStatus.DELIVERED);
			commands.put(a.getId(), a);
		}
		{
			CommandMock a = new CommandMock();
			a.setId("8");
			a.setUserID("one2");
			a.setStatus(CommandStatus.DELIVERED);
			a.setAmount(120);
			commands.put(a.getId(), a);
		}
		{
			CommandMock a = new CommandMock();
			a.setId("9");
			a.setUserID("one2");
			a.setStatus(CommandStatus.DELIVERED);
			a.setAmount(179);
			commands.put(a.getId(), a);
		}

		{
			CommandMock a = new CommandMock();
			a.setId("10");
			a.setUserID("one3");
			a.setStatus(CommandStatus.DELIVERED);
			a.setAmount(69);
			commands.put(a.getId(), a);
		}
	}
	
	
	public void setCommand(String i, CommandMock c) {
		commands.put(i, c);
	}
	
	public CommandMock find(String id) {
		return commands.get(id);
	}
	
	public CommandMock findByUser(String id) {
	    for(Map.Entry<String, CommandMock> entry : commands.entrySet()) {
	        CommandMock cm = entry.getValue();
	        if(cm.getUserID().equals(id)) {
	            return cm;
	        }
	    }
	    return null;
    }
    
}
