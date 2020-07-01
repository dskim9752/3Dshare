<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style type="text/css">
body {
	background-color: #f8f9fa !important;
	padding-top: 3rem !important;
}
</style>

</head>
<body class="pt-5">

	<%--userBar(BOTTOM) --%>
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-primary fixed-bottom">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#userNav" aria-controls="userNav" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<%
		
	    Object userID = session.getAttribute("userID");
		Object userPW = session.getAttribute("userPW");
		Object userName = session.getAttribute("userName");
			if (userID == null || userPW == null) {
		%>
		<div class="collapse navbar-collapse" id="userNav">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="#"></a></li>

				<li><form class="form-inline my-2 my-lg-0"
						action="loginProcess.jsp" method="post">
						<div class="form-group mx-sm-2">
							<label for="inputID" class="sr-only">ID</label> <input
								type="text" class="form-control" id="inputID" name="inputID"
								placeholder="ID">
						</div>
						<div class="form-group mx-sm-2  ml-auto">
							<label for="inputPassword" class="sr-only">Password</label> <input
								type="password" class="form-control" id="inputPassword"
								name="inputPassword" placeholder="Password">
						</div>
						<button class="btn btn-secondary my-2 my-sm-0" type="submit">로그인</button>
					</form></li>
				<li class="nav-item"><a class="nav-link" href="register.jsp">회원가입</a></li>
			</ul>
		</div>
		<%
			} else {
				String id = userID.toString();
				String password = userPW.toString();
				String name = userName.toString();
		%>
		<div class="collapse navbar-collapse" id="userNav">
			<li class="nav-item"><a class="navbar-brand" href="#"><%=name%>
					님 안녕하세요</a></li>
			<ul class="navbar-nav mr-auto">

				<li class="nav-item"><a class="nav-link" href="makePost.jsp">글쓰기
				</a></li>
				<li class="nav-item"><a class="nav-link" href="searchList.jsp?mode=mypost&name=<%=name%>">내글 보기 </a></li>
				<li class="nav-item"><a class="nav-link" href="searchList.jsp?mode=star">즐겨찾기 </a></li>
				<li class="nav-item"><a class="nav-link"
					href="logoutProcess.jsp
				">로그아웃 </a></li>
			</ul>
		</div>
		<%
			}
		%>
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a class="nav-link" href="#top">맨위로 </a></li>
		</ul>
		<%-- 다른 방법 찾아볼 것 --%>
	</nav>
</body>
</html>