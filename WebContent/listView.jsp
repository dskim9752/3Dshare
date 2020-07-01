<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.UserDAO"%> 
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="dao.ImgDAO"%>
<%@page import="dto.ImgBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dao.StarDAO"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
</style>
<script type="text/javascript">
function removeCheck(p) {
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		 location.href = "deleteProcess.jsp?pnum=" + p;
	 }else{   //취소
	     return false;
	 }
	}
</script>
</head>
<body>
	<div class="album py-5" style="background-color: transparent;">
	
	
		<div class="container-fluid">
	<%-- 범위 표현 : 전체,내 게시글, 특정 속성, 특정 키워드 --%>
	
			<div class="row">
				<%
				String myName = (String) session.getAttribute("userName");
				String id = (String) session.getAttribute("userID");
				Connection conn = null;
				PostDAO daoP = PostDAO.getInstance(); // getInstance
				int maxPnum= daoP.nextPnum()-1; // 다음 pnum값 받기 빼기1
				PostBean post=null;
				String title="";
				//String id ="";
				ImgDAO daoI = ImgDAO.getInstance(); // getInstance
				ImgBean img=null;
				String imgName = "";
				String imgSrc = "";
				
				UserDAO daoU = UserDAO.getInstance();
				String name = "";
				LikesDAO daoLikes = LikesDAO.getInstance();
				int likes=0;
				StarDAO daoStar = StarDAO.getInstance();
				boolean isStar;
				
					for (int pnum = maxPnum; pnum >= 1; pnum--) {  
						conn = ConnectionProvider.getConnection();
						post = daoP.select(conn, pnum);
						title = post.getTitle();
						name = post.getName();
						img = daoI.select(conn, pnum);
						//imgSrc = img.getImgSrc();
						//imgName = img.getImgName();
						likes = daoLikes.likes(conn, pnum);
						isStar = daoStar.checkStar(conn, pnum, id);
						conn.close();
						//System.out.println("./uploads"+"/"+img.getPnum()+"/"+img.getImgName());
				%>
				<div class="col-md-3">
					<div class="card mb-4 shadow-sm">
					<%if(myName!=null && myName.equals(name)){ //삭제와 수정%>
							<div>
							<%--삭제 --%>
							<button onclick="removeCheck('<%=pnum%>')" alt="게시글 삭제" type="button" class="close pull-right" data-dismiss="alert">&times;&nbsp;</button>
							<%--수정 --%>
							<button onclick="location.href='editPost.jsp?pnum=<%=pnum %>';" alt="게시글 수정" type="button" class="close pull-right"><div style="text-align:center;"><img src="3d_img/edit.png" style=" margin:0.7vh; width:16px;height:16px;"><div></button>
							&nbsp;
							</div>
							<%} %>
							
						<img class="card-img"  onclick="location.href='viewPost.jsp?pnum=<%=pnum %>'" style="cursor:pointer" 
							src="./uploads/<%=img.getPnum()%>/<%=img.getImgName()%>"
							alt="Card image cap"
							onerror="this.onerror=null; this.src='3d_img/noimg.png';"
							>
						<div class="card-body" style="background-color: transparent;">
							<p class="card-text"><%=title %></p>
							<p class="card-text"><%=name %></p>
							<div class="d-flex justify-content-between align-items-center">
								<%if(id!=null){
								if(isStar){ %>
								<button onclick="location.href='star.jsp?pnum=<%=pnum %>';" alt="즐겨찾기" type="button" class="close pull-right" data-dismiss="alert">&#9733;</button>
								<%}else{ %>
								<button onclick="location.href='star.jsp?pnum=<%=pnum %>';" alt="즐겨찾기 해제" type="button" class="close pull-right" data-dismiss="alert">&#9734;</button>
								<%}} %>
								 <small class="text-muted">추천 : <%=likes %></small>  
							</div>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>


