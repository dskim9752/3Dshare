<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.UserBean"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = request.getParameter("inputID");
		String userPW = request.getParameter("inputPassword");
		if ("".equals(userID) || "".equals(userPW)) {
			out.println("<script>alert('아이디 또는 비밀번호를 제대로 입력해주세요'); location.href='main.jsp'</script>");
		}
		UserBean u = null;
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			UserDAO dao = UserDAO.getInstance(); // getInstance
			u = dao.select(conn, userID);

			if (u == null) {
				out.println("<script>alert('존재하지 않는 아이디입니다.'); location.href='main.jsp'</script>");
			} else if (!(u.getPassword().equals(userPW))) {
				out.println("<script>alert('비밀번호가 올바르지 않습니다.'); location.href='main.jsp'</script>");
			} else {
				session.setAttribute("userID", u.getId());
				session.setAttribute("userPW", u.getPassword());
				session.setAttribute("userName", u.getName());
				response.sendRedirect("main.jsp");
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
</body>
</html>