=<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
else
	out.println(" <ul><li><a href='Search.jsp'>Home</a></li>");
%>

<li><a href="#news">User</a></li>
  <li><a href="#about">About</a></li>
<li><a href="Login.html">Logout</a></li>
</ul>
 <%
                int [][]storeid=new int[50][2];
                Database db=new Database();
                Connection con=db.dataConnection();
                Statement stmt=con.createStatement();
                editdistance e=new editdistance();             
                
          %>
   <%
        try
            {
                
                String [][]getcontent=new String[50][2];              
                String []similar=new String[20];
                int []flag=new int[20];
                String []user=new String[20];
                
            String uid = usern;
            String query = (String)session.getAttribute("query");
            System.out.println(""+uid);
            String gender=null,profession=null;
            String gen1=null,prof1=null,userid=null,temp1=null,temp2=null;
            int age=0,age1=0,tempid=0,w1=0,w;
            String str="select gender,age,profession from cust_data where emailid='"+uid+"'";
            ResultSet rs=stmt.executeQuery(str);
               while(rs.next())
               {
                   gender=rs.getString(1);    
                   age=rs.getInt(2);
                   profession=rs.getString(3);
                   
               }
               System.out.println("Gender:"+gender+"\tAge:"+age+"\tprofession:"+profession);
               rs.close();
               
               String str2="select * from cust_data";
               ResultSet rs1=stmt.executeQuery(str2);
               int i=0,f,diff=0,j;
               while(rs1.next())
               {
                       f=0;
                        similar[i]=rs1.getString("emailid");
                        gen1=rs1.getString("gender");
                        age1=rs1.getInt("age");
                        prof1=rs1.getString("profession");
                        diff=age-age1;
                        if(diff<0)
                        {
                            diff=age1-age;
                        }
                        //System.out.print("Male match:"+gen1);
                        System.out.print("diff:"+diff);
                        //System.out.print("prof"+prof1);
                        //if(gen1.equals(gender))
                        //{
                           System.out.println("gender:"+gen1);
                           if(diff>=0 && diff<3)
                           {
                             System.out.println("Diff:"+diff);
                              if(prof1.equals(profession))
                             {
                                  if(similar[i].equals(uid))
                                   {
                                        flag[i]=0;
                                   }
                                  else
                                  {
                                       System.out.println("profession:"+prof1);
                                       f=1;
                                       flag[i]=f;
                                  }
                            }
                          //}
                       }
                       
                    flag[i]=f;
                    i++;
                   }
                   for(j=0;j<i;j++)
                  {
                       System.out.println("id:"+similar[j]+"\tflag"+flag[j]); 
                  }
               
                 i=0;
                 int cnt=0;
                  while(similar[i]!=null)
                  {
                      
                        if(flag[i]==1)
                        {
                            user[cnt]=similar[i];
                            cnt++;
                        }
                      i++;
                  }
                 for(j=0;j<cnt;j++)
                  {
                       System.out.println("user id:"+user[j]); 
                  }
                  System.out.println(""+query+"\t"+j);
                  i=0;
                  for(cnt=0;user[cnt]!=null;cnt++)
                  {
                       String str23="select songid,query from qbsh_searchhistory where user_id='"+user[i]+"'";
                       ResultSet rs3=stmt.executeQuery(str23);
                      while(rs3.next())
                      {
                        getcontent[i][0]=rs3.getString(1);
                        storeid[i][0]=100;
                        storeid[i][1]=100;
                        getcontent[i][1]=rs3.getString(2);
                        i++;
                      }
                  }
                  
                  for(i=0;getcontent[i][1]!=null;i++)
                  {
                      System.out.println("id:"+getcontent[i][0]+"\tstring:"+getcontent[i][1]);
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
                System.out.println("Before");
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
            
            
            
            
            System.out.println("after");
            System.out.println("id\tweight");
            for(i=0;i<50;i++)
            {
                    //System.out.println("\t"+g.weight[i][j]+"\t"+g.weight[i][j+1]);
                    System.out.println("\t"+storeid[i][0]+"\t"+storeid[i][1]);
                //System.out.println("\t");
            }
             
           }
              
               catch(Exception e1)
               {
                   System.out.println(""+e1);
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