package view;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Database;

/**
 * Servlet implementation class UserRegistration
 */
@WebServlet("/UserRegistration")
public class UserRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		try
		{
			int id=0;
			Database db=new Database();
			 Connection con=db.dataConnection();
			Statement stmt=con.createStatement();

			String strin="Select * from cust_data";
			ResultSet rs=stmt.executeQuery(strin);
			while(rs.next())
			{
				id=rs.getInt(8);
				
			}
			id++;
			
			 String name=request.getParameter("name");
			 String emailid=request.getParameter("emailid");
			 String profession=request.getParameter("profession");
			 int age=Integer.parseInt(request.getParameter("age"));	
			 String nationality=request.getParameter("nationality");
			 String favorite=request.getParameter("favorite");
			 String password=request.getParameter("password");
			 //String cpassword=request.getParameter("cpassword");
			 			 
		
			 
			 String str="insert into cust_data values(?,?,?,?,?,?,?,?)";
			 out.println(str);
			 PreparedStatement ps=con.prepareStatement(str);
			 
		
			 
			 ps.setString(1, name);
			 ps.setString(2, emailid);
			 ps.setString(3,profession);
			 ps.setInt(4, age);
			 ps.setString(5, nationality);
			 ps.setString(6,favorite);
			 ps.setString(7, password);
			 ps.setInt(8, id);
			 
			 if(str!=null)
			 {
				 out.println("value is inserted");
			 }
			 ps.execute();
			 ps.close();
			 
			 String str1="insert into login values(?,?,?)";
			 out.println(str);
			 PreparedStatement ps1=con.prepareStatement(str1);
			 
		
			 
			 ps1.setInt(1, id);
			 ps1.setString(2,emailid);
			 ps1.setString(3,password);
			
			 
			 if(str!=null)
			 {
				 out.println("value is inserted");
			 }
			 ps1.execute();
			 ps1.close();
			 
			 
			 con.close();
			 
			}
			catch(Exception e)
			{
				out.println(e);
			}
		}


}
