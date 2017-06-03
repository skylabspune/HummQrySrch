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
   
  <ul>
  <li><a href="Search.jsp">Home</a></li>

 <% 

	
 out.print("<li><a href='login.html'>Login</a></li>");

%> <li> <a href="UserRegistration.jsp">SignUp</a></li>
  <li><a href="#about">About</a>
 </li></ul>
 
   <div class="background1" height="332px" width="603" >
   
 
  <p>Please, fill your details:  </p>
 
   <form name="form1" method="post" action="UserRegistration" margin-left="30px">
     <table width="603" height="332" border="10" align="center" bordercolor="#FFFF00" class="table">
       <tr>
         <th width="118" scope="col"><div align="left">Name</div></th>
         <th width="294" scope="col"><div align="left"><samp>
           <input type="text" name="name" width="200px">
         </samp></div></th>
       </tr>
       <tr>
         <td> Email ID </td>
         <td><samp>
           <input type="text" name="emailid" width="200px">
         </samp></td>
       </tr>
       <tr>
         <td>Profession</td>
         <td><samp>
           <input type="text" name="profession" width="200px">
         </samp></td>
       </tr>
       <tr>
         <td>Age</td>
         <td><samp>
           <input type="text" name="age" width="200px">
         </samp></td>
       </tr>
       <tr>
         <td>Nationality</td>
         <td><samp>
           <input type="text" name="nationality" width="200px">
         </samp></td>
       </tr>
       <tr>
         <td>Favorite Song Type </td>
         <td><samp>
           <input type="text" name="favorite" width="200px">
         </samp></td>
       </tr>
       <tr>
         <td>Password</td>
         <td><samp>
           <input type="password" name="password" width="200px">
         </samp></td>
       </tr>
       <tr>
         <td>Confirm Password </td>
         <td><samp>
           <input type="password" name="cpassword" width="200px">
         </samp></td>
       </tr>
     </table>
     <label></label>
     <p align="center"><input type="submit" name="Submit" value="Submit" style="width:150px; height:30px;">
     </p>
    
   </form>

</div>
</body>
</html>