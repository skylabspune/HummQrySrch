<%@ page language="java" contentType="text/html; charset=iso-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
String usern=session.getAttribute("name").toString();
if(usern!=null)
{
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+"</p>");	
 
}
%>
   
 <ul>
  <li><a href="Admin.jsp">Home</a></li>
  <li><a href="AudioFileUpload.jsp">Upload Song</a></li>
 
  <li><a href="#about">About</a></li>
<li><a href="AdminLogin.html">Logout</a></li>

</ul>
 
   
 </body>
 </html>
