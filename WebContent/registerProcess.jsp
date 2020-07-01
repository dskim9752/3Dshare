<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.UserBean"%>
<%@page import="java.sql.*"%>

<%--form 으로 받은 모든 정보 Periodic Element로 만들기 --%>
<%
	String name = request.getParameter("name");
	String userID = request.getParameter("userID");
	String userPW = request.getParameter("userPW");
	String email = request.getParameter("email");
	Connection conn = null;
	try {
		conn = ConnectionProvider.getConnection();
		UserDAO dao = UserDAO.getInstance(); // getInstance
		UserBean u1 = dao.select(conn, userID);
		UserBean u2 = dao.selectByName(conn, name);

		if (u1 != null) {
			if (u1.getId().equals(userID))
				out.println("<script>alert('회원가입 실패 (사유: 이미 사용중인 아이디입니다.)'); window.history.back();</script>");
		}
		if (u2 != null) {
			if (u2.getName().equals(name))
				out.println("<script>alert('회원가입 실패 (사유: 이미 사용중인 닉네임입니다.)'); window.history.back();</script>");
		}

		else {
			UserBean u = new UserBean(userID, userPW, email, name);
			dao.insert(conn, u); // insert
			out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='main.jsp'</script>");
			//response.sendRedirect("main.jsp");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		//finally block used to close resources
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end finally try
	} //end try
	conn.close();
%>
