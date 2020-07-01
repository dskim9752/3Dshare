<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
 	session.invalidate();
 	//out.println("<script>alert('로그아웃되었습니다'); location.href='index.jsp'</script>");
 	response.sendRedirect("index.jsp");
 %>
</body>
</html>