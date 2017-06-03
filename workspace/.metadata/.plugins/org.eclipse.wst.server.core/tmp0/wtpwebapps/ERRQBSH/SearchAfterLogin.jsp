<%@ page language="java" contentType="text/html; charset=iso-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Insert title here</title>
<link href="SearchBar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var c = 0;
var t;
var timer_is_on = 0;

function timedCount() {
    document.getElementById("txt").value = c;
    if(c<30)
    c = c + 1;
    else
    	clearTimeout(t);
    timer_is_on = 0;
    t = setTimeout(function(){timedCount()}, 1000);
}

function startCount() {
    if (!timer_is_on) {
        timer_is_on = 1;
        timedCount();
    }
}
</script>
<style>
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    width:800px;
}

li {
    float: left;
}

a:link, a:visited {
    display: block;
    width: 120px;
    font-weight: bold;
    color: #FFFFFF;
    background-color: #98bf21;
    text-align: center;
    padding: 4px;
    text-decoration: none;
    text-transform: uppercase;
}

a:hover, a:active {
    background-color: #7A991A;
}

div.background {
    background-color:#33CCCC ;
    border: 2px solid black;
    opacity: 0.9;
    filter: alpha(opacity=60); /* For IE8 and earlier */
    width:700px;
    height:250px;
   margin-left:320px;
   
     padding:0px;
        
}
</style>

</head>
<body style="background-image:url(Images/finalb.jpg); background-repeat:no-repeat;color:white;">

 <img src="Images/head1.jpg"  width="100%" height="124"/>  

 <% 
//HttpSession sess=request.getSession(false);
String usern=session.getAttribute("name").toString();

if(usern!=null)
{
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+" ");	
 out.println(" <ul><li><a href='SearchAfterLogin.jsp'>Home</a></li>");
}
else
	out.println("<ul><li><a href='Search.jsp'>Home</a></li>");
	
%>
 <li><a href="Search.jsp">User</a></li>
  <li><a href="#about">About</a></li>
<li><a href="login.html">Logout</a></li>

</ul>

<p>&nbsp;</p>
<form action="DownloadSong.jsp" method="post" > 
<div style=" margin-left:1000px; align:right;  background-color:#9ACD32;   opacity: 0.9;
    padding:6px;">    
<p>Enter song title to search the song:</p> 
    <input type="text"  name="downloads" size="30" />
    <input type="submit" name="Submit" value="Search" size="20"/>
  </div>
</form>
<br />
  <form action="NewServlet" method="post">
  
  <div class="background"  id="timer">
  <table style="padding:0px;">
   <tr><td><input type="submit" name="Search" value="Click here to start recording" onclick="startCount()" style="height:150px; width:200px; margin:10px;align:left;"/></td>
   <td>Timer:
   <input type="text" id="txt" size="30"value="Sing a song until timer given here is on: " style="font-size:18px;   color:brown; background-color:#33CCCC ;"/>
   </td>
   </tr>

    
  
 </table>
</div>
</form>


<p align="center">&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>