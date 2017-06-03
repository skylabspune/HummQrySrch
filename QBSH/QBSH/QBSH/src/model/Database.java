package model;

import java.sql.*;

public class Database {

	Connection con;
	public Connection dataConnection() {
		
		try
		{
			Class.forName("oracle.jdbc.OracleDriver");
			con= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","tiger");
			
			/*Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			con= DriverManager.getConnection("jdbc:odbc:upload","system","tiger");
			*/
			System.out.println("Database Connected");
		}catch(Exception e)
		{
			System.out.println("Database is not connected : "+e);
		}
		
		
		return con;
		
	}  
	
}
