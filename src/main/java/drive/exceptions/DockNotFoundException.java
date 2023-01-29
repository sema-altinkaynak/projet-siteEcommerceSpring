package drive.exceptions;

public class DockNotFoundException extends Exception {

	public DockNotFoundException() {
	}

	public DockNotFoundException(String message) {
		super(message);
	}

	public DockNotFoundException(Throwable cause) {
		super(cause);
	}

	public DockNotFoundException(String message, Throwable cause) {
		super(message, cause);
	}

	public DockNotFoundException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
