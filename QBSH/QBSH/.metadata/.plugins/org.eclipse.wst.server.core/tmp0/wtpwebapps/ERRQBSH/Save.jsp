<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*, model.Database"%>
<%@ page import="java.io.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


</body>
</html>
<%
try{
	/*String s=(String)application.getAttribute("abc");*/
	String path=request.getParameter("download");
	System.out.println("Save"+path);
	InputStream is=null;
	byte[] vi=new byte [1024*1024*2];
	int size=0;
	Database db=new Database();
	Connection con=db.dataConnection();
	Statement stmt=con.createStatement();
	Blob file1= null;

	String str="Select * from song where songtitle like '%"+path+"%' ";
	ResultSet rs=stmt.executeQuery(str);
	response.reset();
	String s=null;
	while(rs.next())
	{
	s= rs.getString(2); 
	
	file1=rs.getBlob(3);
	response.reset();
	 is=(rs.getBinaryStream(3));
	//int filelength=inputstream.available();
	//	out.println(s);

	
	//response.reset();
	/*	while((size=is.read(vi))!=-1)
		{
			System.out.println("Read");
			String name=path;
			response.setHeader("Content-Type", "audio/mp3");	
			response.setContentType("audio/mp3");
			response.addHeader("Content-Disposition", "attachment;filename='"+name+"'");
			response.getOutputStream().write(vi,0,size);
	 		
			out.println("</audio>");
		}*/
		
	 byte[] ba = file1.getBytes(1, (int)file1.length());
		String filename=path;
		
			response.setContentType("application/mp3");
			response.setHeader("Content-Disposition","attachment; filename=\""+path+".mp3"+"\"");
			OutputStream os = response.getOutputStream();
			
			
			os.write(ba);
			

			os.close();
			
			
	}
	/*	*/
	
}catch(Exception e)
{
	//out.println("<script type='text/javascript'>function myFunction() {alert('Dear user, your Query has been loaded.');}" +	"window.onload=myFunction();</script>");
out.println("msg"+e.getMessage());
}

%>

