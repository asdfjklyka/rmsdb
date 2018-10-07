package POS;


import java.sql.DriverManager;
import java.sql.Connection;
public class DB {
	
	static Connection con; 
	static String url; 

	public static Connection getConnection() { 
	
	
	String url ="jdbc:mysql://localhost:3306/rmsdb";
	String driver ="com.mysql.jdbc.Driver";
	String username= "root";
	String pass = "";
	try{
		Class.forName(driver);
		con = DriverManager.getConnection(url,username,pass);
		System.out.println("connected");
	
	}
	catch(Exception e){
		e.printStackTrace();
		System.out.println("cant connected");
	}
	return con;
	
}

}