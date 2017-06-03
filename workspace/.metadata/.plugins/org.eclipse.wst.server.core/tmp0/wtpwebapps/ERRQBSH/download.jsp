<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, model.Database"%>
 
<%@ page import="java.io.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>


<link href="backgrounds.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#Layer1 {
	position:absolute;
	width:1096px;
	height:115px;
	z-index:1;
	top: 14px;
}
#Layer2 {
	position:absolute;
	width:1097px;
	height:1075px;
	z-index:2;
	left: 12px;
	top: 133px;
}
.submit
{
background-image:url(Images/Download.png);
width:95px;
hieght:300px;
color:white;
}

</style>
</head>



<body style="background-image:url(Images/finalb.jpg); background-repeat:no-repeat; ">

 <img src="Images/head1.jpg"  width="100%" height="124" align="center"/>  
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


<div id="Layer1"></div>


</body>
</html>
<%


try{
Database db=new Database();
Connection con=db.dataConnection();
Byte song;
String id = request.getQueryString();
out.println(id);

Statement stmt=con.createStatement();

String str="Select * from song where songid='"+id+"' ";
String[] d= new String[10];
int i=0;
ResultSet rs=stmt.executeQuery(str);
System.out.println(rs.getRow());
out.println("<html>");

out.println("<body>");

out.println("<form method='post' action='Save.jsp'><p>&nbsp;</p> ");
out.println("<div class='background' height='332px' width='603'>");
out.println("<font color='red' size='6px'>Search Results:</font>");
out.println("<table  width='603' height='332' border='10' align='center' bordercolor='#FFFF00' >");

while(rs.next())
{
 out.println("<tr><td width='207' align='center' class='style1 subtitle'><span class='style2'>"+rs.getString(1)+"</td><td width='207' class='style1 subtitle'><span class='style2'>"+rs.getString(2)+"</td><td><input type='submit' name='download' class='submit'   value="+rs.getString(2)+"></td></tr>");	
  //rs.getString(2).toCharArray(); 
 System.out.println("Down"+rs.getString(2));
 d[i]=rs.getString(1);
  
}


//response.setContentType("audio/mp3");

//String path=request.getParameter("download");
//application.setAttribute("abc",path);
//System.out.println(path);

out.println("</table>");
}catch(Exception e)
{
out.println();
	}
out.println("</div>");
out.println("</form>");
out.println("</body>");
out.println("</html>");

%>