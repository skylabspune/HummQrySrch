<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<form method="post" action="AudioFileUpload" >
 <img src="Images/head1.jpg"  width="100%" height="124">
<% 
String usern=session.getAttribute("name").toString();
if(usern!=null)
{
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+"</p>");	
 out.println(" <ul><li><a href='SearchAfterLogin.jsp'>Home</a></li>");
}
%>
   
  <li><a href="Search.jsp">Home</a></li>
  <li><a href="#news">User</a></li>
  <li><a href="#about">About</a></li>
<li><a href="Search.jsp">Logout</a></li>

</ul>
  
   <div class="background1" height="332px" width="603" >
   <table width="603" height="332" border="10" align="center" bordercolor="#FFFF00" class="table">
   
     <tr>
       <td width="207" class="style1 subtitle"><span class="style2"> Song ID </span></td>
       <td width="384"><input name="id" type="text" class="style1"></td>
     </tr>
     <tr>
       <td class="style1 subtitle"><span class="style2">Song Title </span></td>
       <td><input name="stitle" type="text" class="style1">
       </td>
     </tr>
     <tr>
       <td class="style1 subtitle"><span class="style2"> Genre </span></td>
       <td><input name="genre" type="text" class="style1"></td>
     </tr>
     <tr>
       <td class="style1 subtitle"><span class="style2"> Year </span></td>
       <td><input name="year" type="text" class="style1"></td>
     </tr>
      <tr>
       <td class="style1 subtitle"><span class="style2"> Tempo </span></td>
       <td>
                       <select class="field small-field" name="tempo">
							<option value="Slow">slow</option>
							<option value="Fast">Fast</option>
							<option value="Very Fast">Very Fast</option></select>
	   </td>                                                   
       
     </tr>
      <tr>
       <td class="style1 subtitle"><span class="style2"> Singer Gender </span></td><td>
        <select class="field small-field" name="s_gender">
							<option value="Female">Female</option>
							<option value="Male">Male</option>
							</select></td>
     </tr>
     <tr>
       <td class="style1 subtitle"><span class="style2"> Song </span></td>
       <td><input name="song" type="file" class="style2" value=""></td>
     </tr>
     <tr>
       <td><input name="button" type="file" class="style2"  value="Click Here to upload MIDI file ">Click Here to upload MIDI file </td>
     </tr>
     
     <tr>
       <td><input name="submit" type="submit" class="style2" style="width:100px; Height:24px;" value="Save"></td>
     </tr>
   </table>
   </div>
   <p><br>
  </p>
   <p><br>
     <br>
    </p> 
  <p>&nbsp;</p>
</form>
</body>

 

</html>
