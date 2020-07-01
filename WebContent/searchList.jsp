<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dto.LikesBean"%>
<%@page import="dao.ImgDAO"%>
<%@page import="dto.ImgBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dao.StarDAO"%> 
<%@page import="dto.StarBean"%>     
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>3Dshare 탐색</title>
<style type="text/css">

.center {
	width: 90%;
	padding-right: 5px;
  	padding-left: 5px;
	height: auto;
	margin: auto;
	text-align: center;
	table-layout: fixed;
}

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
	<%-- menu(TOP) --%>
	<jsp:include page="menu.jsp" flush="true" />
	<br><br><br>
				<%
				String id = (String) session.getAttribute("userID");
				String myName = (String) session.getAttribute("userName");
				
				String word =request.getParameter("word");
				String mode =request.getParameter("mode");
				
				PostDAO daoP = PostDAO.getInstance(); // getInstance
				int pnum= daoP.nextPnum()-1; // 다음 pnum값 받기 빼기1	
				String title="";
				//String id ="";
				ImgDAO daoI=null; // getInstance
				ImgBean img=null;
				String imgName = "";
				String imgSrc = "";
				UserDAO daoU=null;
				String name = "";
				LikesDAO daoLikes = LikesDAO.getInstance();
				int likes=0;
				StarDAO daoStar = StarDAO.getInstance();
				boolean isStar;
				
				String cate = request.getParameter("category");
				String category="기타";
				List<PostBean> pList;
				List<StarBean> sList;
				Connection conn = ConnectionProvider.getConnection();
				if(mode==null|| mode.equals("null")){
					pList =  daoP.search(conn, word);
				}else if(mode.equals("mypost")){
					name = request.getParameter("name");
					//System.out.println("plist by name = "+name);
				 pList =  daoP.selectMyPostList(conn, name);
				}else if(mode.equals("cate")){
					switch(cate){
						case "part":  	category="부속품";break;
						case "fin" :	category="완제품";break;
						case "figure" :	category="피규어";break;
						default: category="기타";break;
					}
						
					
					//System.out.println("plist by name = "+name);
				 pList =  daoP.searchByCategory(conn, category);
				}else if(mode.equals("star")){
					//즐겨찾기(sList) 기반으로 pList 만들기
					sList = daoStar.select(conn, id);
					pList = daoP.searchByStar(conn, sList);
				}else if(mode.equals("user")){
					pList = daoP.searchByName(conn, word);
				}else{
				 pList = null;
				}
				
				
				if(pList==null || pList.isEmpty()){
					System.out.println("plist is null");
				%>
				<script>
					alert('검색 결과가 없습니다. <%=word %>');
					history.go(-1); //뒤로가기
				</script>
				<%			
				}else{
				%>
<div class="center">			
				<%//검색조건 보이기 %>
				<table>	<tr><td>
				<h3>
				<%if(mode!=null && !mode.equals("null")){ 
				if(mode.equals("mypost")){%>
				내 게시글
				<%}else if (mode.equals("cate")){ %>
				카테고리 : <%=category %>
				<%}else if (mode.equals("star")){ %>
				즐겨찾기
				<%}else if (mode.equals("user")){ %>
				사용자 이름으로 검색 <%=word %>
				<%}}else{ 
				if(word.equals("")){%>
				오래된 순으로 검색
				<%}else{ %>
				검색 단어 : <%=word %>
				<%}} %>
				</h3>
				</td></tr>
					</table>



<table>
	<div class="album py-5" style="background-color: transparent;">


		<div class="container-fluid">
			<%-- 범위 표현 : 전체,내 게시글, 특정 속성, 특정 키워드 --%>

			<div class="row">				
				<%
				//pList를 받으면 그대로 열거
					for (PostBean post : pList) {  
						pnum = post.getPnum();
						title = post.getTitle();
						name = post.getName();
						daoI = ImgDAO.getInstance(); // getInstance
						conn = ConnectionProvider.getConnection();
						img = daoI.select(conn, pnum);
						//imgSrc = img.getImgSrc();
						//imgName = img.getImgName();
						daoU = UserDAO.getInstance();
						conn = ConnectionProvider.getConnection();
						isStar = daoStar.checkStar(conn, pnum, id); 
						
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
					
						<img class="card-img-top"
							onclick="location.href='viewPost.jsp?pnum=<%=pnum %>'"
							style="cursor: pointer" src="./uploads/<%=img.getPnum() %>/<%=img.getImgName() %>" alt="Card image cap" onerror="this.onerror=null; this.src='3d_img/noimg.png';">
						<div class="card-body" style="background-color: transparent;">
							<p class="card-text"><%=title %></p>
							<p class="card-text"><%=name %></p>
							<div class="d-flex justify-content-between align-items-center">
								<%if(id!=null){
								if(isStar){ %>
								<button onclick="location.href='star.jsp?category=<%=cate %>&word=<%=word %>&pnum=<%=pnum %>&back=searchList.jsp?mode=<%=mode %>';" alt="즐겨찾기" type="button" class="close pull-right" data-dismiss="alert">&#9733;</button>
								<%}else{ %>
								<button onclick="location.href='star.jsp?category=<%=cate %>&word=<%=word %>&pnum=<%=pnum %>&back=searchList.jsp?mode=<%=mode %>';" alt="즐겨찾기 해제" type="button" class="close pull-right" data-dismiss="alert">&#9734;</button>
								<%}} %>
								 <small class="text-muted">추천 : <%=likes %></small>  
							</div>
						</div>
					</div>
				</div>
				<%
					}}
				conn.close();
				%>
			</div>
		</div>
	</div>
	</table>
	</div>
</body>
</html>