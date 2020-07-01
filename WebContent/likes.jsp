<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dto.LikesBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>I like it</title>
</head>
<body>
	<%
	Object idCheck =  session.getAttribute("userID");
	String id="";
	if(idCheck == null){
		//System.out.println("비로그인 감지");
		String msg = ""; 
		msg += "<script type='text/javascript'>"; 
		msg += "alert('로그인 후 이용해주세요.'); history.go(-1); ";	
		msg += "</script>"; 
		out.print(msg); 	
	}else{
	id = (String)idCheck;
	int pnum = Integer.parseInt(request.getParameter("pnum")); //get pnum
	String back = request.getParameter("back");
	Connection conn = ConnectionProvider.getConnection();
	LikesDAO daoLike = LikesDAO.getInstance();
	LikesBean likes = daoLike.select(conn, pnum, id);
	if(likes!=null){
		//System.out.println("중복추천감지");
		out.println("<script>alert('이미 추천한 게시물입니다.'); history.go(-1); </script>");
	}else{
		//System.out.println("추천");
		likes = new LikesBean(pnum,id);
		daoLike.insert(conn, likes);

	if(back==null){back="main.jsp";}
	conn.close();
	response.sendRedirect(back);
	}
	}
%>
</body>
</html>