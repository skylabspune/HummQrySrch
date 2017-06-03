package view;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Database;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class loginAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 String name;
    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	/**
     * @see HttpServlet#HttpServlet()
     */
    public loginAdmin() {
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

			
			
		name=request.getParameter("user_name");
			 
			 String password=request.getParameter("password");
			 //String cpassword=request.getParameter("cpassword");
			 String dbpwd=null;int flag=0;			 
			 String strin="Select * from ADMIN where username='"+name+"'";
				ResultSet rs=stmt.executeQuery(strin);
				while(rs.next())
				{
				dbpwd=rs.getString(3);
					if(dbpwd.matches(password))
					{
						flag=1;
					}
					
				}
			if (flag==1){
				out.println("login successful");
				HttpSession sess=request.getSession(true);
				sess.setAttribute("name", name);
			RequestDispatcher rd=request.getRequestDispatcher("Admin.jsp");
			    	rd.forward(request, response);
			}
			else
				out.println("please enter valid data");
			 
		
			 
		}catch(Exception e)
		{
			out.println(e);
		}
		
		 
		 
		
	}

}
