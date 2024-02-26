package mbg.javaee.utils;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatabaseConnectionManager {
	private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USERNAME = "mbg";
    private static final String DB_PASSWORD = "mbg";

    public static Connection getConnection() {
    	Connection connection = null;
            try {
                Driver driver = new oracle.jdbc.OracleDriver();
                DriverManager.registerDriver(driver);
                connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return connection;
    }
}