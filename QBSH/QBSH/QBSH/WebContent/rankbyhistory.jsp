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
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+"</p>");	
 out.println(" <ul><li><a href='SearchAfterLogin.jsp'>Home</a></li>");
}
%>

<li><a href="Search.jsp">Home</a></li>
<li><a href="#news">User</a></li>
  <li><a href="#about">About</a></li>
<li><a href="Login.html">Logout</a></li>
</ul>
 <%
                int [][]storeid=new int[50][2];
                Database db=new Database();
                Connection con=db.dataConnection();
                Statement stmt=con.createStatement();
                
                
          %>
       <%
            try
            {
                
                String query = (String)session.getAttribute("query");
                String uid = (String)session.getAttribute("userid");
                System.out.println("Rankbyhist"+uid);
                //String query=null;
                String str2=null,temp1=null,temp2=null; 
                //int weight[][]=new int[50][2];
                int i=0,j=0,k=0,w=0,cnt=0,w1=0,tempid=0;
                storeid[i][j]=0;
                String [][]getcontent=new String[50][2];//stores songid and contour string in history.
                //stores songid and edit distance of querycontour and query from search history.
                editdistance e=new editdistance();
                String str23="select songid,query from qbsh_searchhistory where user_id like '%"+uid+"%'";
                ResultSet rs=stmt.executeQuery(str23);
                while(rs.next())
                {
                    getcontent[i][j]=rs.getString(1);
                    storeid[i][j]=100;
                    storeid[i][j+1]=100;
                    getcontent[i][j+1]=rs.getString(2);
                    j=0;
                    i++;
                }
                
                i=0;
                while(getcontent[i][1]!=null)
                {
                    str2=null;
                    str2=getcontent[i][1];
                    storeid[i][0]=Integer.parseInt(getcontent[i][0]);
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
                            if(query.charAt(j)==str2.charAt(cnt) && query.charAt(j+1)==str2.charAt(cnt+1)&& query.charAt(j+2)==str2.charAt(cnt+2)&& query.charAt(j+3)==str2.charAt(cnt+3))
                            {
                                if(j<10 && cnt<10)
                                {
                                     temp1=query.substring(j,j+9);
                                     temp2=str2.substring(cnt,cnt+9);
                                     w=e.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                                     System.out.println("Matched:"+str2.charAt(cnt)+"\tt1:"+temp1+"\tt2:"+temp2+"\tweight"+w+"\tarraywt:"+storeid[i][1]+"\t"+w1+"\tcnt<10:"+cnt+"\tj<10:"+j);
                            
                                     if(w==0)
                                     {
                                         storeid[i][1]=w;
                                         j=query.length()-6;
                                     }
                                     if(w1<w)
                                     {
                                        storeid[i][1]=w1;
                                     }
                                    else
                                    {
                                        storeid[i][1]=w;
                                       w1=w;
                                    }
                                
                                }
                              if(j<10 && cnt>10)
                               {
                                   temp1=query.substring(j,j+9);
                                   temp2=str2.substring(cnt-3,cnt+5);
                                   w=e.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                                   System.out.println("Matched:"+str2.charAt(cnt)+"\tt1:"+temp1+"\tt2:"+temp2+"\tweight:"+w+"\tarraywt:"+storeid[i][1]+"\t"+w1+"\tcnt>10:"+cnt+"\tj<10:"+j);
                            
                                     if(w==0)
                                     {
                                         storeid[i][1]=w;
                                         j=query.length()-6;
                                     }
                                     if(w1<w)
                                    {
                                       storeid[i][1]=w1;
                                    }
                                    else
                                    {
                                      storeid[i][1]=w;
                                        w1=w;
                                    }
                             }
                             else if(j>10 && cnt<10)//&& j<query.length() && cnt >5)
                             {
                                    temp1=query.substring(j-3,query.length()-5);
                                    temp2=str2.substring(cnt,cnt+9);
                                    w=e.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                                    System.out.println("Matched:"+str2.charAt(cnt)+"\tt1"+temp1+"\tt2"+temp2+"\tweight"+storeid[i][1]+"j>5"+w1);
                                    if (w<3)
                                    {
                                        if(w==0)
                                        {
                                             storeid[i][1]=w;
                                             j=query.length()-6;
                                        }
                                        w1=w;
                                     }
                                        if(w1<w)
                                         {
                                              storeid[i][1]=w1;
                                         }
                                    else
                                    {
                                             storeid[i][1]=w;
                                              w1=w; 
                                     }
                                
                                 }
                          else if(j>10 && cnt>10)//&& j<query.length() && cnt >5)
                          {
                            temp1=query.substring(j,query.length()-5);
                            temp2=str2.substring(cnt,cnt+5);
                            w=e.EditDistance(temp1,temp2, temp1.length(),temp2.length());
                            System.out.println("Matched:"+str2.charAt(cnt)+"\tt1"+temp1+"\tt2"+temp2+"\tweight"+storeid[i][1]+"j>5"+w1);
                            if (w<3)
                            {
                                if(w==0)
                                {
                                    storeid[i][1]=w;
                                    j=query.length()-6;
                                }
                                w1=w;
                            }
                            if(w1<w)
                                {
                                   storeid[i][1]=w1;
                                }
                                else
                                {
                                    storeid[i][1]=w;
                                     w1=w; 
                                }
                          }
                      }
                      cnt++;
                   }
                  j++;
               }    
                //out.println("<br>"+str2);
               System.out.println("Id:"+storeid[i][0]);
               i++;
            }
              
                
                w=i; 
                System.out.println("BeforeR");
                System.out.println("id\tweight");
                for(i=0;i<50;i++)
                {
                    System.out.println("\t"+storeid[i][0]+"\t"+storeid[i][1]);
                //System.out.println("\t");
                }
            
                /*It sort the array in accending order by their editdistance*/
               i=0;
              while(i<w)
              {
                for(j=0;j<w;j++)
                {
                    if(storeid[i][1]<storeid[j][1])
                    {
                        w1=storeid[i][1];
                        tempid=storeid[i][0];
                        storeid[i][1]=storeid[j][1];
                        storeid[i][0]=storeid[j][0];;
                        storeid[j][1]=w1;
                        storeid[j][0]=tempid;
                    }
                }
                i++;
             }     
            
            
            
            
            System.out.println("afterR");
            System.out.println("id\tweight");
            for(i=0;i<50;i++)
            {
                    //System.out.println("\t"+g.weight[i][j]+"\t"+g.weight[i][j+1]);
                    System.out.println("\t"+storeid[i][0]+"\t"+storeid[i][1]);
                //System.out.println("\t");
            }
          }
            catch(Exception e)
            {
                out.println(""+e);
            }
        %>
        
        <%
         if(storeid[0][0]>0)
           {
            String song=null;
            String midi=null;
            String list;
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            out.println("<table border='0' width='450'>");
            out.println("<tr bgcolor='#c1c1c1'><th><font face='sans-serif' size='2' color='black'>Rank</th><th><font face='sans-serif' size='2' color='black'>Song Name</th><th><font face='sans-serif' size='2' color='black'>Play</th><th><font face='sans-serif' size='2' color='black'>Download</th></tr>");
            String sname = null;
           int id=0;
            for(int i=0;i<10;i++)
            {
                if(storeid[i][0]>0)
                {
                    list="select songid,songtitle from song where songid="+storeid[i][0]+"";
                    ResultSet rs2=stmt.executeQuery(list);
                    while(rs2.next())
                    {
                         sname = rs2.getString(2);
                         id = rs2.getInt(1);
                         System.out.println("Slect"+id+sname);
                        out.println("<tr><td><center><font face='sans-serif' size='2' color='#c1c1c1'>"+(i+1)+"</td></center>");                    
                        out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'>"+sname+"</td></center>");
                        out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'><a target='_blank' href=playsong.jsp?song="+sname+"'><font face='sans-serif' size='2' color='#c1c1c1'>Play</a></td></center>"); 
                       out.println("<td><center><font face='sans-serif' size='2' color='#c1c1c1'><a href='download.jsp?"+id+"'><font face='sans-serif' size='2' color='#c1c1c1'>Download</a></td></center></tr>");
                     }
                }
          }
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");   
        } 
         else
        {
                out.println("<html>");
                out.println("<body>");
                out.println("</body>");
                out.println("<div class='background'>");
                
                 out.println("<h2>History is not Maintained!</h2>");  
                 out.println("</div>");
                 out.println("</body>");
                 out.println("</html>");  
        }    
        %>
        
</body>
</html>