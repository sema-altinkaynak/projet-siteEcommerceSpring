package drive.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Delivery {

	@Id
	@GeneratedValue
	private Integer id;

	private String commandId;

	private CommandStatus status;

	private String employeeLogin;

    @Temporal(TemporalType.TIMESTAMP)
	private Date date;

	@ManyToOne
	private Dock dock;
	
	private String codeBarId;
	
	public String getEmployeeLogin() {
        return employeeLogin;
    }

    public void setEmployeeLogin(String employeeLogin) {
        this.employeeLogin = employeeLogin;
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCommandId() {
		return commandId;
	}

	public void setCommandId(String command) {
		this.commandId = command;
	}

	public CommandStatus getStatus() {
		return status;
	}

	public void setStatus(CommandStatus status) {
		this.status = status;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Dock getDock() {
		return dock;
	}

	public void setDock(Dock dock) {
		this.dock = dock;
	}
	
	public String getCodeBarId() {
		return codeBarId;
	}

	public void setCodeBarId(String codeBarId) {
		this.codeBarId = codeBarId;
	}
	
	

}
