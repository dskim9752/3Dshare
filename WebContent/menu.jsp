<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<% request.setCharacterEncoding("UTF-8"); %>
<title>Menu</title>
<style type="text/css">
body {
	background-color: #f8f9fa !important;
	padding-top: 3rem !important;
}
</style>
<link rel="stylesheet" href="minty.css">


<%
	String userID = (String) session.getAttribute("userID");
	String userPW = (String) session.getAttribute("userPW");
%>

</head>
<body class="pt-5">




	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
		<a class="navbar-brand" href="main.jsp">3Dshare</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#menuNav" aria-controls="menuNav" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="menuNav">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="searchList.jsp?mode=cate&category=part">부속품 </a></li>
				<li class="nav-item"><a class="nav-link" href="searchList.jsp?mode=cate&category=fin">완제품</a></li>
				<li class="nav-item"><a class="nav-link" href="searchList.jsp?mode=cate&category=figure">피규어</a></li>
				<li class="nav-item"><a class="nav-link" href="searchList.jsp?mode=cate&category=etc">기타</a></li>
				<li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
			</ul>
			<form class="form-inline my-2 my-lg-0"  action="searchList.jsp" method="get">
			<div class ="custom-radio">
				<input type="radio" name="mode" value="user"><small class="small">닉네임(id)검색 &nbsp;</small><br>
				<input type="radio" name="mode" value="null" checked="checked"><small class="small">단어 검색</small>
			</div>	
				<input class="form-control mr-sm-2" type="text" style="width:500px" placeholder="Search" name="word">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	
	
	
	
	<jsp:include page="userBar.jsp"></jsp:include>
</body>
</html>


<%--
 <script type="text/javascript">
	history.replaceState({}, null, location.pathname);
	//파라미터 지워주는 스크립트
</script>

--%>