<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="dto.*"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import= "java.sql.Timestamp"%>
<%@page import= "java.text.SimpleDateFormat"%>
<%@page import= "java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<%request.setCharacterEncoding("UTF-8"); %>
</head>
<body>
<%
CommentDAO daoC = CommentDAO.getInstance();
Connection conn = ConnectionProvider.getConnection();
int pnum = Integer.parseInt(request.getParameter("pnum"));
int cnum = Integer.parseInt(request.getParameter("cnum"));
daoC.delete(conn,cnum,pnum);
List<CommentBean> pList = daoC.selectList(conn, pnum);
int number =1;

CommentBean a = null;
for(int i = 0; i<pList.size();i++)
{
	a=pList.get(i);
	daoC.renew(conn, pList.get(i), number);
	number++;
}
try{
	
}catch(Exception e){
	
}finally{
	conn.close();
	%>
<jsp:forward page="viewPost.jsp" >
<jsp:param name="pnum" value="<%=pnum%>"/>
</jsp:forward>
<%
}
%>
</body>
</html>