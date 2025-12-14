package miniproject2;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE"; 
    private static final String USER = "system";    
    private static final String PASSWORD = "3564";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.out.println("DB Error: " + e.getMessage());
        }
        return con;
    }

}
