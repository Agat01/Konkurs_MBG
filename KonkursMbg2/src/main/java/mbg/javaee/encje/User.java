package mbg.javaee.encje;

public class User {
	private boolean loggedIn = false;

	private String userId = "";

	public boolean isLoggedIn() {
		return loggedIn;
	}

	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		if (userId == null) {
			this.userId = "";
		} else {
			this.userId = userId;
		}
	}

	public void logIn(String userId) {
		setLoggedIn(true);
		setUserId(userId);
	}

	public void logOut() {
		setLoggedIn(false);
		setUserId("");
	}
}
