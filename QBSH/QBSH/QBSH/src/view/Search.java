package view;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Database;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
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
	    //out.println("Redirected");
		
		try
		{
	
			String stitle=request.getParameter("title");
			Database db=new Database();
			 Connection con=db.dataConnection();
	
				Statement stmt=con.createStatement();
				out.println("<html>");

				out.println("<body>");
				out.println("<form method='post' action='Save.jsp'> ");

				out.println("<table width='745', height='40', border='1', bgcolor='#FFECEC';>");

				String str="Select * from song where songtitle='"+stitle+"' ";
				ResultSet rs=stmt.executeQuery(str);
				
					
 
					while(rs.next())
					{
					 out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td><input type='submit' name='download' value='"+rs.getString(2)+"'></td></tr>");	
					  //rs.getString(2).toCharArray(); 
					 
					  
					}
					out.println("</table>");

					out.println("</form>");
					out.println("</body>");
					out.println("</html>");

					}
		catch(Exception e)
		{
			
		}
	}

}
