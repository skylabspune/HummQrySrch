/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.63
 * Generated at: 2016-04-11 09:50:03 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import model.Database;
import process.matchingcode;
import matching.editdistance;
import primaryrank.globalvar;
import java.io.*;

public final class primarylist1_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("    \r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("<link href=\"backgrounds.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("@import url(\"table\");\r\n");
      out.write(".style1 {font-size: 24px}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write(".style2 {\r\n");
      out.write("\tfont-family: \"Comic Sans MS\";\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body style=\"background-image:url(Images/finalb.jpg); background-repeat:no-repeat; \">\r\n");
      out.write(" <img src=\"Images/head1.jpg\"  width=\"100%\" height=\"124\">\r\n");
      out.write(" ");
 
//HttpSession sess=request.getSession(false);
String usern=session.getAttribute("name").toString();
if(usern!=null)
{
 out.println("<p style='float:right; margin:0; font-weight:bold; color:brown;font-size:20px;background-color:#33CCCC ;border: 2px solid black; opacity: 0.9;'> Welcome: "+usern+"</p>");	
 out.println(" <ul><li><a href='SearchAfterLogin.jsp'>Home</a></li>");
}

      out.write("\r\n");
      out.write("<li><a href=\"Search.jsp\">Home</a></li>  \r\n");
      out.write("  <li><a href=\"#news\">User</a></li>\r\n");
      out.write("  <li><a href=\"#about\">About</a></li>\r\n");
      out.write("<li><a href=\"login.html\">Logout</a></li>\r\n");
      out.write("\r\n");
      out.write("</ul>\r\n");
 
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
                g.weight[i][j]=50;
                g.weight[i][j+1]=50;
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
                         System.out.println("In if query:");
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
            out.println("<form method='post' action='Save.jsp'><p>&nbsp;</p> ");
            out.println("<div class='background' height='332px' width='603'>");
            out.println("<font color='red' size='6px'>Search Results:</font>");
            out.println("<table  width='603' height='332' border='10' align='center' bordercolor='#FFFF00' >");

            out.println("<tr bgcolor='#c1c1c1'><th><font face='sans-serif' size='2' color='black'>Rank</th><th><font face='sans-serif' size='2' color='black'>Song Name</th><th><font face='sans-serif' size='2' color='black'>Download</th><th><font face='sans-serif' size='2' color='black'>Select Result</th></tr>");

            String sname = null;
            int id=0;
            for(i=0;i<13;i++)
            {
                if(g.weight[i][1]<4)
                {
                    list="select songid,songtitle from song where songid="+g.weight[i][0]+"";
                    ResultSet rs2=stmt.executeQuery(list);
                    while(rs2.next())
                    {
                        id = rs2.getInt(1);
                        sname = rs2.getString(2);
                        out.println("<tr><td><center><font face='sans-serif' size='2' color='black'>"+(i+1)+"</td></center>");                    
                        out.println("<td><center><font face='sans-serif' size='2' color='black'>"+sname+"</td></center>");
                       
                        out.println("<td><center><font face='sans-serif' size='2' color='black'><a href='download.jsp?"+id+"'><font face='sans-serif' size='2' color='#c1c1c1'>Download</a></td></center>");                  
                        out.println("<td><center><font face='sans-serif' size='2' color='black'><a href=maintain_hist.jsp?song="+sname+"'\'><font face='sans-serif' size='2' color='#c1c1c1'>Select</a></td></center></tr>");
                       }
                    flag=1;
               }
            }
            out.println("</table>");
            out.println("</div>");
            out.println("</form>");
            if(flag==0)
                {
                    response.sendRedirect("songerror.jsp?sucess");
                }
        }
        catch(Exception e) 
        {            
            System.out.println("primarylist"+e);
        }
           


      out.write("\r\n");
      out.write("       \r\n");
      out.write("\r\n");
      out.write(" <table>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td>\r\n");
      out.write("                    <form method=\"get\" action=\"rankbyhistory.jsp\">\r\n");
      out.write("                        <center>\r\n");
      out.write("                            <input type=\"submit\" id=\"id20050626201038\" value=\"Ranking By History\" class=\"rankhist-btn\" onclick = \"id20050626201038.style.backgroundColor='#ff0000'\"/>\r\n");
      out.write("                        </center>\r\n");
      out.write("                     </form>\r\n");
      out.write("                 </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("                 <td>\r\n");
      out.write("                    <form method=\"get\" action=\"rankbypref.jsp\">\r\n");
      out.write("                        <center>\r\n");
      out.write("                        <input type=\"submit\" id=\"id20050626201039\" value=\"Ranking By Preference\" class=\"rankpref-btn\" onclick = \"id20050626201039.style.backgroundColor='#ff0000'\"/>\r\n");
      out.write("                        </center>\r\n");
      out.write("                    </form>\r\n");
      out.write("                 </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>   \r\n");
      out.write("                 <td>\r\n");
      out.write("                    <form method=\"get\" action=\"rankbysimilar.jsp\">\r\n");
      out.write("                    <center>\r\n");
      out.write("                    <input type=\"submit\" id=\"id20050626201040\" value=\"Ranking By Similar User History\" class=\"Rerank-btn\" onclick = \"id20050626201040.style.backgroundColor='#ff0000'\"/>\r\n");
      out.write("                    </center>\r\n");
      out.write("                    </form>\r\n");
      out.write("                 </td>\r\n");
      out.write("            </tr> \r\n");
      out.write("        </table>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
