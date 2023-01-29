package drive.model;

public class CommandMock {

    String id;

    String userID;

    CommandStatus currentStatus;

    int amount;

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public CommandStatus getStatus() {
        return currentStatus;
    }

    public void setStatus(CommandStatus status) {
        this.currentStatus = status;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
}
