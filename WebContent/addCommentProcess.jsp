<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="dto.*"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import= "java.sql.Timestamp"%>
<%@page import= "java.text.SimpleDateFormat"%>
<%@page import= "java.util.Calendar"%>

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
UserDAO daoU = UserDAO.getInstance();
String userID = (String) session.getAttribute("userID");
int pnum = Integer.parseInt(request.getParameter("pnum"));
int cnum = daoC.nextCnum(pnum);
int depth = Integer.parseInt(request.getParameter("depth"));
String text = request.getParameter("text");
SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
Calendar cal = Calendar.getInstance();
String today = null;
today = formatter.format(cal.getTime());
Timestamp time = Timestamp.valueOf(today);
Connection conn = ConnectionProvider.getConnection();
UserBean bean = daoU.select(conn, userID);
String name= bean.getName();
CommentBean comment = new CommentBean (cnum,pnum,userID,time,text,depth, name);
try{
daoC.insert(conn, comment);
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