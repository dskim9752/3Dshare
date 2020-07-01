<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>	
<%@page import="java.io.File"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script type="text/javascript">


</script>
</head>
<body>

<%
	PostDAO daoP = PostDAO.getInstance(); // getInstance
	int pnum = Integer.parseInt(request.getParameter("pnum")); 
	
	
	String uploadsDir = "/uploads/"+pnum+"/";  
	String uploadPath = request.getSession().getServletContext().getRealPath(uploadsDir); 
	
	File deleteFolder = new File(uploadPath);
	
	if (deleteFolder.exists()) { 			//���� ������ ���� - ������ġ
		File[] deleteFolderList = deleteFolder.listFiles();
	
		for (int j = 0; j < deleteFolderList.length; j++) {
			deleteFolderList[j].delete();
		}
		deleteFolder.delete();  //���� ���� ����
	}
	
	
	Connection conn = ConnectionProvider.getConnection();
	daoP.delete(conn, pnum);
	response.sendRedirect("index.jsp");
%>
</body>
</html>