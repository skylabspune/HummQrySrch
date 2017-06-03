package view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.Database;
import midi.*;

/**
 * Servlet implementation class AudioFileUpload
 */
@WebServlet("/AudioFileUpload")
public class AudioFileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public AudioFileUpload() {
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
			
			try
			{
			 id=Integer.parseInt(request.getParameter("id"));
			}
			catch(NumberFormatException ne)
			{
				
			}
			 String stitle=request.getParameter("stitle");
			 String genre=request.getParameter("genre");
			int  year=Integer.parseInt(request.getParameter("year"));
			String song=request.getParameter("song");
			 String button=request.getParameter("button");
			 String tempo=request.getParameter("tempo");
			 String s_gender=request.getParameter("s_gender");
			 
			 Database db=new Database();
			 Connection con=db.dataConnection();
			
			 
			 System.setProperty("dir", "D:/song");
			 String upsong=System.getProperty("dir")+File.separatorChar+song;
			 String midi=System.getProperty("dir")+File.separatorChar+button;
			 
			 System.out.println(System.getProperty("dir"));
			 
			// File f= new File(song);
			 File f1= new File(midi);
			 
			 
			// out.println(f.getAbsolutePath());
		//	FileInputStream fis=new FileInputStream(song);
			 
			/* InputStream fis=null;
			 Part song=request.getPart("song");
	            song.getName();
				String getname=String.valueOf(song);
	            String songname=getname.substring(10,22);
	          */
				FileInputStream fis=null;
			 out.println(f1.getAbsolutePath());
			 FileInputStream fis1=new FileInputStream(midi);
			 out.println("\n2");
			 if(song!=null)
			 {
					 fis=new FileInputStream(upsong);
					
				  
			 }
			 
			 String str="insert into song values(?,?,?,?,?,?,?,?,?)";
			 out.println(str);
			 PreparedStatement ps=con.prepareStatement(str);
			 
			 out.println("3");
		/*	 String remString=upsong;
			 char[] ch1= remString.toCharArray();
			 char[] ch=upsong.toCharArray();

			 int s=0,i=0,j=ch.length;

			 				for(s=8;s<ch.length;s++)
			 				{
			 			
			 					ch1[i]=ch[s];
			 					i++;
			 						
			 				}
			 				remString=new String(ch1);
*/
		//	System.out.println("variables: "+id+" "+stitle+year+tempo+s_gender); 
			 ps.setInt(1, id);
			
			 ps.setString(2, stitle);
			 ps.setBinaryStream(3,fis,fis.available());
			 ps.setBinaryStream(4,fis1,fis1.available());
			 ps.setString(5,"null");
			 ps.setString(6,genre );
			 ps.setInt(7, year);
			 ps.setString(8,tempo);
			 ps.setString(9,s_gender );
			 
			 
			 //System.out.println("\ncontour:\t"+ m.getStr1());
			 if(str!=null)
			 {
				 out.println("value is inserted");
			 }
			 ps.execute();
			 ps.close();
			 con.close();
			 System.out.println();
			 MidiLoader m=new MidiLoader(f1.getAbsolutePath(),stitle);
			 response.sendRedirect("Admin.jsp");
			}
			catch(Exception e)
			{
				out.println(""+e);
			}
		}
	}


