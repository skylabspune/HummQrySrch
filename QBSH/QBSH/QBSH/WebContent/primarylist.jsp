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
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+"</p>");	
 out.println(" <ul><li><a href='SearchAfterLogin.jsp'>Home</a></li>");
}
%>
<li><a href="Search.jsp">Home</a></li>  
  <li><a href="#news">User</a></li>
  <li><a href="#about">About</a></li>
<li><a href="login.html">Logout</a></li>

</ul>

<%

try 
{
    String query=null;
    String str2=null,temp1=null,temp2=null; 
    String [][]temp=new String[50][2];
     int [][]weight=new int[50][2];
     int i=0,j=0,k=0,w,cnt=0,w1,tempid=0;
     editdistance e1=new editdistance();
    Database db=new Database();
    Connection con=db.dataConnection();
	
    Statement stmt=con.createStatement();
    String str3="select contour from query";
     ResultSet rs1=stmt.executeQuery(str3);
    while(rs1.next())
    {
        query=rs1.getString(1);
    }
     session.setAttribute("query",query);
     System.out.println(query);
    //query=query.substring();
    //out.println(""+query);
     //session.setAttribute("query",query);
    rs1.close();
    String str="select songid,contour from song";
    ResultSet rs=stmt.executeQuery(str);
    
    while(rs.next())
    {
        temp[i][j]=rs.getString(1);
        weight[i][j]=100;
        weight[i][j+1]=100;
        temp[i][j+1]=rs.getString(2);
        j=0;
        i++;
     }
    rs.close();
   i=0;
    while(temp[i][1]!=null)
    {
        str2=null;
        str2=temp[i][1];
        
        weight[i][0]=Integer.parseInt(temp[i][0]);
        temp1=null;
        temp2=null;
        j=0;
        w1=100;
        while((query.length()-6)>j)
        {
            cnt=0;
            w=0;
           while((str2.length()-6)>cnt)
            {
              if(query.charAt(j)==str2.charAt(cnt) && query.charAt(j+1)==str2.charAt(cnt+1)&& query.charAt(j+2)==str2.charAt(cnt+2)&& query.charAt(j+3)==str2.charAt(cnt+3))
              {
                  if(j<10 && cnt<10)
                  {
                    temp1=query.substring(j,j+9);
                    temp2=str2.substring(cnt,cnt+9);
                    w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                    System.out.println("Matched:"+str2.charAt(cnt)+"\tt1:"+temp1+"\tt2:"+temp2+"\tweight"+w+"\tarraywt:"+weight[i][1]+"\t"+w1+"\tcnt<10:"+cnt+"\tj<10:"+j);
                    
                        if(w==0)
                        {
                            weight[i][1]=w;
                            j=query.length()-6;
                        }
                         if(w1<w)
                            {
                                weight[i][1]=w1;
                            }
                         else
                         {
                           weight[i][1]=w;
                           w1=w;
                         }
                        
                  }
                  if(j<10 && cnt>10)
                  {
                      temp1=query.substring(j,j+9);
                      temp2=str2.substring(cnt-5,cnt+5);
                      w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                      System.out.println("Matched:"+str2.charAt(cnt)+"\tt1:"+temp1+"\tt2:"+temp2+"\tweight:"+w+"\tarraywt:"+weight[i][1]+"\t"+w1+"\tcnt>10:"+cnt+"\tj<10:"+j);
                    
                        if(w==0)
                        {
                            weight[i][1]=w;
                            j=query.length()-6;
                        }
                         if(w1<w)
                            {
                                weight[i][1]=w1;
                            }
                         else
                         {
                           weight[i][1]=w;
                           w1=w;
                         }
                  }
                  else if(j>10 && cnt<10)//&& j<query.length() && cnt >5)
                  {
                    temp1=query.substring(j-3,query.length()-5);
                    temp2=str2.substring(cnt,cnt+9);
                    w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                    System.out.println("Matched:"+str2.charAt(cnt)+"\tt1"+temp1+"\tt2"+temp2+"\tweight"+weight[i][1]+"j>5"+w1);
                    if (w<=3)
                    {
                        if(w==0)
                        {
                            weight[i][1]=w;
                            j=query.length()-6;
                        }
                        w1=w;
                    }
                    if(w1<w)
                        {
                            weight[i][1]=w1;
                        }
                        else
                        {
                            weight[i][1]=w;
                             w1=w; 
                        }
                        
                  }
                  else if(j>10 && cnt>10)//&& j<query.length() && cnt >5)
                  {
                    temp1=query.substring(j,query.length()-5);
                    temp2=str2.substring(cnt,cnt+5);
                    w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                    System.out.println("Matched:"+str2.charAt(cnt)+"\tt1"+temp1+"\tt2"+temp2+"\tweight"+weight[i][1]+"j>5"+w1);
                    if (w<3)
                    {
                        if(w==0)
                        {
                            weight[i][1]=w;
                            j=query.length()-6;
                        }
                        w1=w;
                    }
                    if(w1<w)
                        {
                            weight[i][1]=w1;
                        }
                        else
                        {
                            weight[i][1]=w;
                             w1=w; 
                        }
                        
                  }
              }
              cnt++;
            }
            j++;
        }    
        //out.println("<br>"+str2);
        System.out.println("Id:"+weight[i][0]);
        i++;
    }
    w=i;
    System.out.println("Before");
    System.out.println("id\tweight");
    for(i=0;i<50;i++)
    {
            j=0;
            System.out.println("\t"+weight[i][j]+"\t"+weight[i][j+1]);
        //System.out.println("\t");
    }
    i=0;
    while(i<w)
    {
        for(j=0;j<w;j++)
        {
            if(weight[i][1]<weight[j][1])
            {
                w1=weight[i][1];
                tempid=weight[i][0];
                weight[i][1]=weight[j][1];
                weight[i][0]=weight[j][0];;
                weight[j][1]=w1;
                weight[j][0]=tempid;
            }
        }
        i++;
    }
    System.out.println("after");
    System.out.println("id\tweight");
    for(i=0;i<50;i++)
    {
            j=0;
            //out.println("\t"+weight[i][j]+"\t"+weight[i][j+1]+"<br>");
            System.out.println("\t"+weight[i][j]+"\t"+weight[i][j+1]);
        //System.out.println("\t");
    }
   
   String song=null;
    String midi=null;
    String list;
    out.println("<html>");
    out.println("<head>");
    out.println("</head>");
    out.println("<body>");
    out.println("<form method='post' action='Save.jsp'><p>&nbsp;</p> ");
    out.println("<div class='background' height='332px' width='603'>");
    out.println("<font color='red' size='6px'>Search Results:</font>");
    out.println("<table  width='603' height='332' border='10' align='center' bordercolor='#FFFF00' >");

    out.println("<tr bgcolor='#c1c1c1'><th><font face='sans-serif' size='2' color='black'>Rank</th><th><font face='sans-serif' size='2' color='black'>Song Name</th><th><font face='sans-serif' size='2' color='black'>Download</th><th><font face='sans-serif' size='2' color='black'>Select Result</th></tr>");
    String sname = null;
    for(i=0;i<5;i++)
    {
        list="select songtitle,contour from song where songid="+weight[i][0]+"";
        ResultSet rs2=stmt.executeQuery(list);
        while(rs2.next())
        {
            sname = rs2.getString(1);
            midi=rs2.getString(2);
             out.println("<tr><td><center><font face='sans-serif' size='2' color='black'>"+(i+1)+"</td></center>");                    
             out.println("<td><center><font face='sans-serif' size='2' color='black'>"+sname+"</td></center>");
              out.println("<td><center><font face='sans-serif' size='2' color='black'><a href=''><font face='sans-serif' size='2' color='white'>Download</a></td></center>");
             out.println("<td><center><font face='sans-serif' size='2' color='black'><a href=maintain_hist.jsp?song="+sname+" '\'><font face='sans-serif' size='2' color='white'>Select</a></td></center></tr>");
        }
    }
    
    session.setAttribute("songid",weight[i][0]);
    
    out.println("</table>");
    out.println("</div>");
    out.println("</form>");
   
    //rs.close();
}
catch(Exception e) 
{            
    System.out.println(""+e);
}
%>
  <%
  /*
  try 
        {
            String query=null;
            String str2=null,temp1=null,temp2=null; 
            String [][]temp=new String[50][2];//Used to store songid and midicontour
            //int [][]weight=new int[50][2];
            globalvar g=new globalvar();
            int i=0,j=0,k=0,w,cnt=0,w1,tempid=0,flag=0;
            //g.weight[i][j]=0;
            editdistance e1=new editdistance();
            Database db=new Database();
            Connection con=db.dataConnection();
            Statement stmt=con.createStatement();
            String str3="select contour from query";
            ResultSet rs1=stmt.executeQuery(str3);
           while(rs1.next())
           {
               query=rs1.getString(1);
           }
             session.setAttribute("query",query);
            rs1.close();
            String str="select songid,contour from song";
            ResultSet rs=stmt.executeQuery(str);
            //Gets 
            while(rs.next())
            {
                temp[i][j]=rs.getString(1);
                g.weight[i][j]=100;
                g.weight[i][j+1]=100;
                temp[i][j+1]=rs.getString(2);
                j=0;
                i++;
             }
            rs.close();
            i=0;
            while(temp[i][1]!=null)
            {
                str2=null;
                str2=temp[i][1];
                g.weight[i][0]=Integer.parseInt(temp[i][0]);
                temp1=null;
                temp2=null;
                j=0;
                w1=100;//temparary variable
                while((query.length()-6)>j)
                {
                    cnt=0;
                    w=0;
                   while((str2.length()-6)>cnt)
                    {
                      if(query.charAt(j)==str2.charAt(cnt) && query.charAt(j+1)==str2.charAt(cnt+1)&& query.charAt(j+2)==str2.charAt(cnt+2)&& query.charAt(j+3)==str2.charAt(cnt+3))//&& query.charAt(j+4)==str2.charAt(cnt+4)&& query.charAt(j+5)==str2.charAt(cnt+5))
                      {
                          if(j<10 && cnt<10)
                          {
                            temp1=query.substring(j,j+9);
                            temp2=str2.substring(cnt,cnt+9);
                            w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                            System.out.println("Matched:"+str2.charAt(cnt)+"\tt1:"+temp1+"\tt2:"+temp2+"\tweight"+w+"\tarraywt:"+g.weight[i][1]+"\t"+w1+"\tcnt<10:"+cnt+"\tj<10:"+j);
                                if(w==0)
                                {
                                    g.weight[i][1]=w;
                                    j=query.length()-6;
                                }
                                 if(w1<w)
                                    {
                                        g.weight[i][1]=w1;
                                    }
                                 else
                                 {
                                   g.weight[i][1]=w;
                                   w1=w;
                                 }
                          }
                          if(j<10 && cnt>10)
                          {
                              temp1=query.substring(j,j+9);
                              temp2=str2.substring(cnt-4,cnt+5);
                              w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                              System.out.println("Matched:"+str2.charAt(cnt)+"\tt1:"+temp1+"\tt2:"+temp2+"\tweight:"+w+"\tarraywt:"+g.weight[i][1]+"\t"+w1+"\tj>10:"+cnt+"\tcnt<10:"+j);
                            
                                if(w==0)
                                {
                                    g.weight[i][1]=w;
                                    j=query.length()-6;
                                }
                                 if(w1<w)
                                    {
                                        g.weight[i][1]=w1;
                                    }
                                 else
                                 {
                                   g.weight[i][1]=w;
                                   w1=w;
                                 }
                          }
                          else if(j>10 && cnt<10)//&& j<query.length() && cnt >5)
                          {
                            temp1=query.substring(j-5,query.length()-5);
                            temp2=str2.substring(cnt,cnt+9);
                            w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                            System.out.println("Matched:"+str2.charAt(cnt)+"\tt1"+temp1+"\tt2"+temp2+"\tweight"+g.weight[i][1]+"j>10 && cnt<10"+w1);
                            //if (w<3)
                            //{
                                if(w==0)
                                {
                                    g.weight[i][1]=w;
                                    j=query.length()-6;
                                }
                                //w1=w;
                            //}
                            if(w1<w)
                                {
                                    g.weight[i][1]=w1;
                                }
                                else
                                {
                                    g.weight[i][1]=w;
                                     w1=w; 
                                }
                          }
                          else if(j>10 && cnt>10)//&& j<query.length() && cnt >5)
                          {
                            temp1=query.substring(j-5,query.length()-5);
                            temp2=str2.substring(cnt-5,cnt+5);
                            w=e1.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                            System.out.println("Matched:"+str2.charAt(cnt)+"\tt1"+temp1+"\tt2"+temp2+"\tweight"+g.weight[i][1]+"j>10 && cnt>10"+w1);
                            //if (w<3)
                            //{
                                if(w==0)
                                {
                                    g.weight[i][1]=w;
                                    j=query.length()-6;
                                }
                              //  w1=w;
                            //}
                            if(w1<w)
                                {
                                    g.weight[i][1]=w1;
                                }
                                else
                                {
                                    g.weight[i][1]=w;
                                     w1=w; 
                                }
                          }
                      }
                      cnt++;
                    }
                    j++;
                }    
                //out.println("<br>"+str2);
                System.out.println("Id:"+g.weight[i][0]);
                i++;
            }
            w=i;
            System.out.println("Before");
            System.out.println("id\tweight");
            for(i=0;i<50;i++)
            {
                    System.out.println("\t"+g.weight[i][0]+"\t"+g.weight[i][1]);
                //System.out.println("\t");
            }
            //It sort the array in accending order by their editdistance
            i=0;
            while(i<w)
            {
                for(j=0;j<w;j++)
                {
                    if(g.weight[i][1]<g.weight[j][1])
                    {
                        w1=g.weight[i][1];
                        tempid=g.weight[i][0];
                        g.weight[i][1]=g.weight[j][1];
                        g.weight[i][0]=g.weight[j][0];;
                        g.weight[j][1]=w1;
                        g.weight[j][0]=tempid;
                    }
                }
                i++;
            }
            System.out.println("after");
            System.out.println("id\tweight");
            for(i=0;i<50;i++)
            {
                System.out.println("\t"+g.weight[i][0]+"\t"+g.weight[i][1]);
            }
            
            
            String list;
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            out.println("<table border='0' width='550'>");
            out.println("<tr bgcolor='#c1c1c1'><th><font face='sans-serif' size='2' color='black'>Rank</th><th><font face='sans-serif' size='2' color='black'>Song Name</th><th><font face='sans-serif' size='2' color='black'>Play</th><th><font face='sans-serif' size='2' color='black'>Download</th><th><font face='sans-serif' size='2' color='black'>Select Result if Accurate</th></tr>");
            String sname = null;
            int id=0;
            for(i=0;i<5;i++)
            {
                if(g.weight[i][1]<4)
                {
                    list="select songid,songtitle from song where songid="+g.weight[i][0]+"";
                    ResultSet rs2=stmt.executeQuery(list);
                    while(rs2.next())
                    {
                        id = rs2.getInt(1);
                        sname = rs2.getString(2);
                        out.println("<tr><td><center><font face='sans-serif' size='2' color='#c1c1c1'>"+(i+1)+"</td></center>");                    
                        out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'>"+sname+"</td></center>");
                        out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'><a target='_blank' href=playsong.jsp?song="+sname+"'><font face='sans-serif' size='2' color='#c1c1c1'>Play</a></td></center>"); 
                        out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'><a href='download.jsp?"+id+"'><font face='sans-serif' size='2' color='#c1c1c1'>Download</a></td></center>");                  
                        out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'><a href=maintain_hist.jsp?song="+sname+"'\'><font face='sans-serif' size='2' color='#c1c1c1'>Select</a></td></center></tr>");
                       }
                    flag=1;
               }
            }
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
            if(flag==0)
                {
                    response.sendRedirect("songerror.jsp?sucess");
                }
        }
        catch(Exception e) 
        {            
            System.out.println(""+e);
        }
        */
        %>
     

 <table>
            <tr>
                <td>
                    <form method="get" action="rankbyhistory.jsp">
                        <center>
                            <input type="submit" id="id20050626201038" value="Ranking By History" class="rankhist-btn" onclick = "id20050626201038.style.backgroundColor='#ff0000'"/>
                        </center>
                     </form>
                 </td>
            </tr>
			<tr>
                 <td>
                    <form method="get" action="rankbypref.jsp">
                        <center>
                        <input type="submit" id="id20050626201039" value="Ranking By Preference" class="rankpref-btn" onclick = "id20050626201039.style.backgroundColor='#ff0000'"/>
                        </center>
                    </form>
                 </td>
            </tr>
            <tr>   
                 <td>
                    <form method="get" action="rankbysimilar.jsp">
                    <center>
                    <input type="submit" id="id20050626201040" value="Ranking By Similar User History" class="Rerank-btn" onclick = "id20050626201040.style.backgroundColor='#ff0000'"/>
                    </center>
                    </form>
                 </td>
            </tr> 
        </table>

</body>
</html>