<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, model.Database, process.matchingcode,matching.editdistance,primaryrank.globalvar"%>
 
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
 

 <%
                globalvar g=new globalvar();
                Database db=new Database();
                Connection con=db.dataConnection();
                Statement stmt=con.createStatement();
                float [][]preference=new float[50][2];
                int counthist=0,i;
        %>
    <%
               String uid = (String)session.getAttribute("name");
               System.out.println("It is global array ");
               int j,w;
               float w1=0,tempid=0;
               System.out.println("id\tweight");
                for(i=0;i<50;i++)
                {
                                 j=0;
                                System.out.println("\t"+g.weight[i][j]+"\t"+g.weight[i][j+1]);
                }
               
               /*folowing 5 line use to find no of accurate search of perticular user that is stored in searchhistory table */ 
               String maxcount="select count(*) from qbsh_searchhistory where user_id='"+uid+"'";
               ResultSet count=stmt.executeQuery(maxcount);
               while(count.next())
               {
                       counthist=count.getInt(1);
               }
               count.close();
               System.out.println("Welcome:"+uid);
               System.out.println("count History:"+counthist);
               
               int gen=0,year=0,genre=0,tempo=0,y1=0;
               String sin_gen=null,y=null,genr=null,temp=null;
               String q=null;
               ResultSet r1,r2,r3,r4;
               for(i=0;i<20;i++)
               {
                    
                    preference[i][0]=g.weight[i][0];
                    preference[i][1]=0.0F;
                    //singer gender
                    sin_gen="select s_gender from song where songid='"+g.weight[i][0]+"'";
                    r1=stmt.executeQuery(sin_gen);
                    while(r1.next())
                    {
                        sin_gen=r1.getString(1);
                    }
                    System.out.println(""+sin_gen);
                    if(sin_gen==null)
                    {
                    	sin_gen="female";
                    }
                    r1.close();
                    q="select max(count(u.s_gender)) from song u,qbsh_searchhistory s  where u.songid=s.songid and s.user_id='"+uid+"' and u.s_gender='"+sin_gen+"' group by s_gender ";
                    r2=stmt.executeQuery(q);
                    while(r2.next())
                    {
                        gen=r2.getInt(1);
                    }
                    System.out.println(""+gen+"\t"+i);
                    r2.close();
                

                    //year of song                      
                    y="select year from song where songid='"+g.weight[i][0]+"'";
                    r1=stmt.executeQuery(y);
                    while(r1.next())
                    {
                        year=r1.getInt(1);
                    }
                    //System.out.println(""+year);
                    r1.close();
                    System.out.println("Check"+uid);
                    q="select max(count(u.year)) from song u,qbsh_searchhistory s where (u.songid=s.songid and s.user_id='"+uid+"' and year='"+year+"') group by year";
                    System.out.println("Check"+uid);
                    r2=stmt.executeQuery(q);
                    while(r2.next())
                    {
                        y1=r2.getInt(1);
                    }
                    System.out.println(""+y1+"\t"+i);
                    r2.close();
                    
                    
                    
                    //genre of song
                    if(g.weight[i][0]==0)
                    	g.weight[i][0]=1;
                    genr="select genre from song where songid='"+g.weight[i][0]+"'";
                    
                    r1=stmt.executeQuery(genr);
                    while(r1.next())
                    {
                        genr=r1.getString(1);
                    }
                    System.out.println(""+genr);
                    r1.close();
                    q="select max(count(u.genre)) from song u,qbsh_searchhistory s where u.songid=s.songid and s.user_id='"+uid+"' and genre='"+genr+"' group by genre";
                    System.out.println("Check"+uid);
                    r2=stmt.executeQuery(q);
                    while(r2.next())
                    {
                        genre=r2.getInt(1);
                    }
                    System.out.println(""+genre+"\t"+i);
                    r2.close();
                    
                    
                    //tempo of the song
                    temp="select tempo from song where songid='"+g.weight[i][0]+"'";
                    r1=stmt.executeQuery(temp);
                    while(r1.next())
                    {
                        temp=r1.getString(1);
                    }
                    System.out.println(""+temp);
                    r1.close();
                    q="select max(count(u.tempo)) from song u,qbsh_searchhistory s where u.songid=s.songid and s.user_id='"+uid+"' and tempo='"+temp+"' group by tempo";
                    r2=stmt.executeQuery(q);
                    while(r2.next())
                    {
                        tempo=r2.getInt(1);
                    }
                    r2.close();
                    preference[i][1]=(Float.valueOf(gen)/Float.valueOf(counthist)+Float.valueOf(y1)/Float.valueOf(counthist)+Float.valueOf(genre)/Float.valueOf(counthist)+Float.valueOf(tempo)/Float.valueOf(counthist))/4;//((gen/counthist)+(y1/counthist)+(genre/counthist)+(tempo/counthist))/4;
                    System.out.println("songid: "+g.weight[i][0]+"\tGender: "+sin_gen+"\tYear: "+year+"\tGenre: "+genr+"\ttempo: "+temp+"\tpreference:"+preference[i][1]+"count: "+counthist);
                    System.out.println("songid: "+g.weight[i][0]+"\tmax Gender: "+gen+"\tmax Year: "+y1+"\tmax Genre: "+genre+"\tmax tempo: "+tempo);             
               }
               System.out.println("Before");
               for(i=0;i<12;i++)
               {
                                System.out.println("\t"+preference[i][0]+"\t"+preference[i][1]);
               }
               
               w=i;
                i=0;
              while(i<w)
              {
                for(j=0;j<w;j++)
                {
                    if(preference[i][1]>preference[j][1])
                    {
                        w1=preference[i][1];
                        tempid=preference[i][0];
                        preference[i][1]=preference[j][1];
                        preference[i][0]=preference[j][0];;
                        preference[j][1]=w1;
                        preference[j][0]=tempid;
                    }
                }
                i++;
             }     
             System.out.println("After:");
               for(i=0;i<12;i++)
               {
                                System.out.println("\t"+preference[i][0]+"\t"+preference[i][1]);
               }
               
        %>
        <%
            String song=null;
            String midi=null;
            String list;
            out.println("<form method='post' action='Save.jsp'><p>&nbsp;</p> ");
            out.println("<div class='background' height='332px' width='603'>");
            out.println("<font color='red' size='6px'>Search Results:</font>");
            out.println("<table  width='603' height='332' border='10' align='center' bordercolor='#FFFF00' >");
            out.println("<tr bgcolor='#c1c1c1'><th><font face='sans-serif' size='2' color='black'>Rank</th><th><font face='sans-serif' size='2' color='black'>Song Name</th><th><font face='sans-serif' size='2' color='black'>Download</th><th><font face='sans-serif' size='2' color='black'>Select Result</th></tr>");

            String sname = null;
           int id=0;
            for(i=0;i<20;i++)
            {
                
                    list="select songid,songtitle from song where songid="+preference[i][0]+"";
                    ResultSet rs2=stmt.executeQuery(list);
                    while(rs2.next())
                    {
                         sname = rs2.getString(2);
                         id = rs2.getInt(1);
                         out.println("<tr><td><center><font face='sans-serif' size='2' color='black'>"+(i+1)+"</td></center>");                    
                         out.println("<td><center><font face='sans-serif' size='2' color='black'>"+sname+"</td></center>");
                         out.println("<td><center><font face='sans-serif' size='2' color='black'><a href='download.jsp?"+id+"'><font face='sans-serif' size='2' color='#c1c1c1'>Download</a></td></center></tr>");
                     }
                
          }
            out.println("</table>");
            out.println("</div>");
            
        %>
     
</body>
</html>