<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String title = request.getParameter("title"); // form의 name="title"인 값을 구함
String text = request.getParameter("text");
String category = request.getParameter("category");
int pnum = Integer.parseInt(request.getParameter("pnum"));
//System.out.println("pnum = "+pnum);
//System.out.println("title = "+title);
//System.out.println("text = "+text);
//System.out.println("category = "+category);

	PostBean post = new PostBean(pnum,"null","null",null,title,text,category);
	PostDAO daoP = PostDAO.getInstance(); // getInstance
	Connection conn = ConnectionProvider.getConnection();
	daoP.edit(conn, post);
	conn.close();
	response.sendRedirect("index.jsp");
%>
</body>
</html>