package springapp.database;

public class PropertiesDataHolder {
	private String connectionUrl;
	private String username;
	private String password;
	private String driverClass;
	private String testSchema;

	public String getConnectionUrl() {
		return connectionUrl;
	}

	public void setConnectionUrl(String connectionUrl) {
		this.connectionUrl = connectionUrl;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDriverClass() {
		return driverClass;
	}

	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}

	public String getTestSchema() {
		return testSchema;
	}

	public void setTestSchema(String testSchema) {
		this.testSchema = testSchema;
	}

}
