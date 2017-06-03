<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, model.Database, process.matchingcode"%>
 
<%@ page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="backgrounds.css" rel="stylesheet" type="text/css" />

<style type="text/css">

@import url("table");
.style1 {font-size: 24px}
</style>

<style type="text/css">

.style2 {
	font-family: "Comic Sans MS";
	font-weight: bold;
}

</style>

</head>

<body style="background-image:url(Images/finalb.jpg); background-repeat:no-repeat; ">
 <img src="Images/head1.jpg"  width="100%" height="124">
  <% 
//HttpSession sess=request.getSession(false);
String usern=session.getAttribute("name").toString();

if(usern!=null)
{
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+" ");	
 out.println("<ul><li><a href='SearchAfterLogin.jsp'>Home</a></li>");
}
else
	out.println("<ul><li><a href='Search.jsp'>Home</a></li>");
	
%>
 
  <li><a href="#news">User</a></li>
  <li><a href="#about">About</a></li>
<li><a href="login.html">Logout</a></li>

</ul>
 
  <div class="background">
 <form action="processquery" method="post" id="contactform">
            
                <h2>Click Next</h2>
              <input type="submit" value="Next"/>
        </form>

</div>
<% 


//this was previously commented -----------------------------------------------------------------------------------
String songcont = null;
String sub=null;
//PrintWriter out = response.getWriter();
String str="Select * from song";
	int[] edit=new int[4000];
	int[] songid=new int[10];
	Statement stmt=null;
	String save=null;
	
			int e=0;
			  Database db=new Database();
                Connection con=db.dataConnection();
        		
        		String str1="select * from query";
        		try {
        			
        		stmt = con.createStatement();
        		ResultSet rs1=stmt.executeQuery(str1);
        		
        		while(rs1.next())
        		{
        			save=rs1.getString(1);
        		}
        	} catch (SQLException e1) {
        		// TODO Auto-generated catch block
        		e1.printStackTrace();
        	}
        	
			
try {
		
		stmt = con.createStatement();
	ResultSet rs=stmt.executeQuery(str);int l2=0;
	int f=0;
	 out.println("<form method='post' action='Save.jsp'><p>&nbsp;</p> ");
     out.println("<div class='background' height='332px' width='603'>");
     out.println("<font color='red' size='6px'>Search Results:</font>");
     out.println("<table  width='603' height='332' border='10' align='center' bordercolor='#FFFF00' >");
	while(rs.next())
	{
		songcont=rs.getString(7);
	//	matchingcode m=new matchingcode();
		
		if(save!=null){
	 l2=save.length();}
		if(l2!=0)
		{
		edit[e]=matchingcode.EditDistanceDP(songcont, save);
		songid[e]=rs.getInt(1);
		e++;
		
		}	

	}
		Statement stmt1=con.createStatement();
		for(f=0;f<e;f++)
		{String str4="Select * from song where songid="+songid[f]+"";
		
		String[] d= new String[10];
		int i=0;
		
		ResultSet rs1=stmt1.executeQuery(str4);
		 
       
	
		while(rs1.next())
		{
			System.out.println("servlet: "+songid[f]);
			out.println("<tr><td width='207' align='center' >"+rs1.getString(1)+"</td><td width='207'>"+rs1.getString(2)+"</td><td><input type='submit' name='download' class='submit'   value="+rs1.getString(2)+"></td><td><a href=select.jsp?song="+rs1.getString(2)+" '\'>Select</a></td></tr>");	
		  //rs.getString(2).toCharArray(); 
		 System.out.println("Serveltss: "+rs1.getString(2));
		 d[i]=rs1.getString(1);
		  
		}
		rs1.close();
		}
		
		
								
	out.println("</table>");
	out.println("</div>");
	out.println("<input type='button' name='Re-Rank' value='Re-Rank' >");
	out.println("</form>");out.println("</body>");
    out.println("</html>");
} catch (SQLException ex) {
	// TODO Auto-generated catch block
	ex.printStackTrace();
}

%>