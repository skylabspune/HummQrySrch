package model;

import java.sql.*;

public class Database {

	Connection con;
	public Connection dataConnection() {
		
		try
		{

			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("run");
			con= DriverManager.getConnection("jdbc:mysql://localhost:3306/hummingdb","root", "root");
			System.out.println("Database Connected");
		}catch(Exception e)
		{
			System.out.println("Database is not connected : "+e);
		}
		
		
		return con;
		
	}  
	
}
