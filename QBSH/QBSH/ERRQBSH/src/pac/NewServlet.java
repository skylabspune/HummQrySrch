package pac;

import java.io.IOException;
import java.io.PrintWriter;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class NewServlet
 */
@WebServlet("/NewServlet")
public class NewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    String usern=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        final PrintWriter out = response.getWriter();
        out.println("<html><link href='backgrounds.css' rel='stylesheet' type='text/css' />");
        out.println("<head>");
        out.println("</head>");
        out.println("<body style='background-image:url(Images/finalb.jpg); background-repeat:no-repeat;onload='myFunction()'>");
        out.println("<script type='text/javascript'>function myFunction() {alert('Dear user, your Query has been loaded.');}" +
        		"window.onload=myFunction();</script>");
        
        out.println(" <img src='Images/head1.jpg'  width='100%' height='124' align='center'/>  ");
        HttpSession sess= request.getSession(false);
  usern=sess.getAttribute("name").toString();
        out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome:"+usern+"</p>");

        out.println("<ul>"+"<li><a href='#home'>Home</a></li>"+" <li><a href='#news'>News</a></li>"+"<li><a href='#contact'>Contact</a></li>"+"<li><a href='#about'>About</a></li>"+"</ul>");
               
        
    
        //out.println("<form method='post' action='Save.jsp'><p>&nbsp;</p> ");
        //out.println("<div class='background' height='332px' width='603'>");
        //out.println("<font color='red' size='6px'>Search Results:</font>");
       // out.println("<table  width='603' height='332' border='10' align='center' bordercolor='#FFFF00' >");
        try {
        	
          final JavaSoundRecorder recorder = new JavaSoundRecorder();
	        // creates a new thread that waits for a specified
	        // of time before stopping
         
	        Thread stopper = new Thread(new Runnable() {
	            public void run() {
	            	try {
	            		Thread.sleep(recorder.RECORD_TIME);
	            
	                  
	            	
	            		      		
	            		recorder.finish();
	            			 

            
            } catch(Exception e){}
	            
	            }
	             
	        }
        		);
          
        stopper.start();
 
        // start recording
        recorder.start();

   response.sendRedirect("SuccessRecord.jsp");


/*try {
	stmt = con.createStatement();
	 String str="insert into CONTOURS values(?,?,?)";
 //out.println(str);
 PreparedStatement ps=con.prepareStatement(str);

   ps.setString(1,save);
  ps.setString(2, usern);
   ps.setInt(3,11);  
 if(str!=null)
 {
	 System.out.println("value is inserted to contours");
 }
 ps.execute();
 ps.close();
 con.close();

}catch(Exception e){
System.out.println(e.getMessage());}
*/

            }finally {            

            }        
        }
    


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	      processRequest(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        processRequest(request, response);
        

	}
	 @Override
	    public String getServletInfo() {
	        return "Short description";
	    }

}
