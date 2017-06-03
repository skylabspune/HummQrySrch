package view;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
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
 * Servlet implementation class Save
 */
@WebServlet("/Save")
public class Save extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Save() {
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
		String path=request.getParameter("download");
		System.out.println(path);


		Database db=new Database();
		Connection con=db.dataConnection();
		Statement stmt;
		try {
			stmt = con.createStatement();
		

		String str="Select * from song where songtitle='"+path+"' ";
		ResultSet rs=stmt.executeQuery(str);
		while(rs.next())
		{
		String s= rs.getString(2);
		System.out.println("Name of song:"+s);
		Blob song=(rs.getBlob(5));

		InputStream inputstream=song.getBinaryStream();
		int filelength=inputstream.available();
		System.out.println("\nSize of song:"+filelength);

		response.setContentType("audio/mp3");

		//long length=song.length();
		//int l =(int) length;
		//byte[] data=new byte[l];
		 
		}}
		catch(Exception e)
		{
	
		}


	
	}

}
