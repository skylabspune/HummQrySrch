<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, model.Database, process.matchingcode,matching.editdistance"%>
 
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

<%!
        int sid = 0;
         Database db=new Database();
          Connection con=db.dataConnection();
        
%>
        <%
            try
            {
                int hid=0,flag=0;
                String sname=null;
                String name=null;
                    String song = request.getParameter("song");
                    System.out.println("song"+song);
                    Integer id = (Integer)session.getAttribute("songid");
                 out.println(id);
                 String uname = (String)session.getAttribute("name");//get userid from session
                String query = (String)session.getAttribute("query");
                out.println(uname);
                out.println(query);
               
            Statement stmt=con.createStatement();
              
             String str1="select hid from qbsh_searchhistory";
             ResultSet rs=stmt.executeQuery(str1);
              while(rs.next())
              {
                  hid=rs.getInt(1);
              }
              hid++;
              
              Statement stt = con.createStatement();
              String ss = "Select songid from song where songtitle like '%"+song+"%'";
              ResultSet rr = stt.executeQuery(ss);
              while(rr.next())
              {
                  sid = rr.getInt(1);
                  System.out.println("Song id " +sid);
              }
              
              String str2="select user_id,songname from qbsh_searchhistory where songid='"+sid+"'";
               ResultSet r1 = stt.executeQuery(str2);
               while(r1.next())
               {
                   name=r1.getString(1);
                   sname=r1.getString(2);
               }
               if(song.equals(sname) && uname.equals(name)) //to avoid duplicate query      
                   {
                      flag=0; 
                   }
                   else
                   {
                      flag=1; 
                   }
               System.out.println("flag="+flag+"\t"+name);
               if(flag==1)
               {
                   String str="insert into qbsh_searchhistory values(?,?,?,?,?)";
                   PreparedStatement ps=con.prepareStatement(str);
                   ps.setInt(1,hid);
                   ps.setString(2,uname);
                   ps.setString(3,query);
                   
                   ps.setString(5,song);
                   if(sid==0)
                	   sid=1;
                   
                   ps.setInt(4,sid);
                   boolean i=ps.execute();
              
                   if(i=true)
                   {
                     response.sendRedirect("feedback.jsp?sucess");
                   }
                   ps.close();
                 }
                 if(flag==0)
                 {
                     response.sendRedirect("feedback.jsp?sucess");
                 }
              
              
       } 
             
            catch(Exception e)
            {
                out.println(""+e);
            }
        %>
</body>
</html>