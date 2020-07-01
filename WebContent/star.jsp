<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="dao.StarDAO"%>
<%@page import="dto.StarBean"%>
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
	String word = request.getParameter("word");
	String category = request.getParameter("category");
	Connection conn = ConnectionProvider.getConnection();
	StarDAO daoStar = StarDAO.getInstance();
	StarBean star = daoStar.select(conn, pnum, id);
	if(star!=null){
		//System.out.println("즐찾해제");
		daoStar.delete(conn, pnum,id);
	}else{
		//System.out.println("즐찾");
		star = new StarBean(pnum,id);
		daoStar.insert(conn, star);
	}
	if(back==null){back="main.jsp";}
	if(word!=null){back+="&word="+word;}
	if(category!=null){back+="&category="+category;}
	//System.out.println("back = "+back);
	//System.out.println("word = "+word);
	//System.out.println("category = "+category);
	conn.close();
	response.sendRedirect(back);
	}
%>
</body>
</html>