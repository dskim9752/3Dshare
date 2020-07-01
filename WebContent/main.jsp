<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>3Dshare 메인 페이지</title>
<style type="text/css">
.center1 {
	width: 100%;
	height: auto;
	margin: auto;
	text-align: center;
	table-layout: fixed;
}

.center2 {
	width: 90%;
	height: auto;
	text-align: center;
	margin: auto;
	table-layout: fixed;
}

<%--
table, tr, td {
	border: 1px solid #444444;
}
--%>



</style>



</head>



<body>

	<%
	    Object userID = session.getAttribute("userID");
		Object userPW = session.getAttribute("userPW");
		Object userName = session.getAttribute("userName");
	%>
	<%-- menu(TOP) --%>
	<jsp:include page="menu.jsp"/>
	<div class="bg-light">
		<table class="center1 bg-default">
		
			<tr>
			<td style="width:10% "></td>
				<td>
					<div style="width:80% ">
						<jsp:include page="top5View.jsp"></jsp:include>
					</div>
				</td>
				<td>
					<div>
						<h1>
							여러분의 모델링 파일을<br> 공유해 주세요
						</h1>
						<ul class="navbar-nav">

							<li class="nav-item"><a class="nav-link"
								<%if (userID == null || userPW == null) {%>
								href="javascript:alert('로그인 후 이용해주세요');" onfocus="this.blur()"
								<%} else {%> href="makePost.jsp" <%}%>
								style="font-size: x-large;"><br>모델링 파일 업로드하기 </a></li>

						</ul>
					</div>
				</td>
				<td style="width:6% "></td>
			</tr>

			<br>
		</table>
	</div>
	<table class="center2">
		<tr>
			<td><jsp:include page="listView.jsp"/></td>
		</tr>
	</table>


</body>
</html>