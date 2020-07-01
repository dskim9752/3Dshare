<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>


<%!
String n = "test";
public String returnN(){
	return n;
}
%>
<% 
response.sendRedirect("main.jsp");
%>
</body>
</html>