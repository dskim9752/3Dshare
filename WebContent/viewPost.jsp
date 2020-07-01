<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="dao.ImgDAO"%>
<%@page import="dto.ImgBean"%>
<%@page import="dao.StlDAO"%>
<%@page import="dto.StlBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dao.StarDAO"%>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>

<head>
<script type="text/javascript">
function removeCheck(p) {
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		 location.href = "deleteProcess.jsp?pnum=" + p;
	 }else{   //취소
	     return false;
	 }
	}
</script>

<style type="text/css">
.box {
	width: 100%;
	margin: auto;
	table-layout: fixed;
}

img {
	display: block;
	width: 100%;
	height: auto;
	position: relative;
	padding: 0%; /* 1:1 ratio */
	overflow: hidden;
}
<%--
table, tr, td {
	border: 1px solid #444444;
}
--%>
</style>
<%
	String myName = (String) session.getAttribute("userName");

	PostDAO daoP = PostDAO.getInstance(); // getInstance
	//System.out.println("post = "+ post.toString());
	int pnum = Integer.parseInt(request.getParameter("pnum")); //get pnum
	Connection conn = ConnectionProvider.getConnection();
	PostBean post = daoP.select(conn, pnum);
	String title = post.getTitle();
	String text = post.getText();
	String date = post.getTimeStamp().toString();
	String id = post.getId();
	String name = post.getName();
	String category = post.getCategory();
	ImgDAO daoI = ImgDAO.getInstance(); // getInstance
	conn = ConnectionProvider.getConnection();
	ImgBean img = daoI.select(conn, pnum);
	//String imgName = img.getImgName();
	//String imgSrc = img.getImgSrc();

	StlDAO daoS = StlDAO.getInstance(); // getInstance
	conn = ConnectionProvider.getConnection();
	StlBean stl = daoS.select(conn, pnum);
	//String stlSrc = stl.getStlSrc();
	//String stlName = stl.getStlName();
	
	LikesDAO daoLike = LikesDAO.getInstance();
	int likes = daoLike.likes(conn, pnum);
	StarDAO daoStar = StarDAO.getInstance();
	int star = daoStar.star(conn, pnum);
	conn.close();
%>
<title><%=title%></title>
</head>
<body>
	<%-- menu(TOP) --%>
	<jsp:include page="menu.jsp" />
	<br>
	<br>
	<br>
<div class="box">
		<%--게시물 제목 --%>
		<div class="card" style="width: 80%; margin: auto; padding: 0%;">
			<table class="table box" style="text-align: center;">
				<tr>
					<td colspan="4" rowspan="3"
						style="text-align: left; display: table-cell; vertical-align: middle;">
						<h1>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=title %></h1>
					</td>
					<td class="small" style="text-align: right;" colspan="1">작성자:
					</td>
					<td class="small" style="text-align: left;" colspan="1"><%=name %>(<%=id %>)</td>
				</tr>
				<tr>
					<td class="small" style="text-align: right;" colspan="1">작성일자:
					</td>
					<td class="small" style="text-align: left;" colspan="1"><%=date %></td>
				</tr>
				<tr>
					<td class="small" style="text-align: right;" colspan="1">카테고리:
					</td>
					<td class="small" style="text-align: left;" colspan="1"><%=category %></td>
				</tr>
			</table>
		</div>

		<br>
	<%--게시물 본문 --%>
		<div class="card" style="width: 80%; margin: auto; overflow: hidden;">
		<div class="card-body overflowAuto">
			<table class="table" style="text-align: center; position: relative; padding: 0%;">
				<tr>
					<td colspan="6" height="50px"></td>
				</tr>
				<tr>
					<td style="width:48%; text-align: center;" colspan="2">
							<img src="./uploads/<%=img.getPnum() %>/<%=img.getImgName() %>" align="center" onerror="this.onerror=null; this.src='3d_img/noimg.png';"></td>
					<td style="width:2%;"></td>
					<td style="width:2%;"></td>			
					<td style="width:48%; text-align: left;" colspan="2"><pre>
							<br><%=text %><pre></td>
				</tr>
			</table></div>
	</div>
	</div>
	
	
	<%--게시물 메뉴 --%>
	<br>
	<br>
	<%if(myName!=null && myName.equals(name))	{//삭제와 수정권한이 있다면%>
	<div class="card" style="width: 50%; margin: auto;">
		<table class="table"
			style="margin: auto; table-layout: fixed; text-align: center; vertical-align: middle;">
			<tr>
				<td style="width: 23%;">
					<button
						onclick="location.href='downloadProcess.jsp?pnum=<%=pnum %>';"
						alt="다운로드" type="button" class="btn btn-success">다운로드</button>
				</td>

				<td style="width: 24%;">
					<button onclick="location.href='likes.jsp?pnum=<%=pnum %>&back=viewPost.jsp?pnum=<%=pnum %>';" alt="추천" type="button"
						class="btn btn-info">추천 [+<%=likes %>]</button>
				</td>

				<td style="width: 30%;">
					<button onclick="location.href='star.jsp?pnum=<%=pnum %>&back=viewPost.jsp?pnum=<%=pnum %>';" alt="즐겨찾기" type="button"
						class="btn btn-secondary">즐겨찾기 [+<%=star %>]</button>
				</td>

				<td style="width: 24%;">
					<button onclick="location.href='editPost.jsp?pnum=<%=pnum %>';"
						alt="게시글 수정" type="button" class="btn btn-warning">수정</button>
				</td>

				<td style="width: 24%;">
					<button onclick="removeCheck('<%=pnum%>')" alt="게시글 삭제"
						type="button" class="btn btn-danger" data-dismiss="alert">삭제</button>
				</td>
			</tr>
		</table>
	</div>
	<%}else{ //비로그인 or 아이디 매치x%>
	<div class="card" style="width: 50%; margin: auto;">
		<table class="table"
			style="margin: auto; table-layout: fixed; text-align: center; vertical-align: middle;">
			<tr>
				<td style="width: 33%;">
					<button
						onclick="location.href='downloadProcess.jsp?pnum=<%=pnum %>';"
						alt="다운로드" type="button" class="btn btn-success">다운로드</button>
				</td>
				<td style="width: 1%;"></td>
				<td style="width: 33%;">
					<button onclick="location.href='likes.jsp?pnum=<%=pnum %>&back=viewPost.jsp?pnum=<%=pnum %>';" alt="추천" type="button"
						class="btn btn-info">추천 [+<%=likes %>]</button>
				</td>
				<td style="width: 33%;">
					<button onclick="location.href='star.jsp?pnum=<%=pnum %>&back=viewPost.jsp?pnum=<%=pnum %>';" alt="즐겨찾기" type="button"
						class="btn btn-secondary">즐겨찾기 [+<%=star %>]</button>
				</td>
			</tr>
		</table>
	</div>
	<%} %>
	<div style="width: 80%; margin: auto; padding-top: 5%;"><strong>댓글</strong></div>
	<div style="width: 80%; margin: auto; padding-top: 1%;">	
	<jsp:include page="userComment.jsp" >
	<jsp:param name="pnum" value="<%=pnum%>"/>
	</jsp:include>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	
</body>
</html>