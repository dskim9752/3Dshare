<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="dao.ImgDAO"%>
<%@page import="dto.ImgBean"%>
<%@page import="dao.LikesDAO"%>
<%@page import="dto.LikesBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>	   
<%@page import="java.util.List"%>
<!DOCTYPE html>
<head>
<title>Carousel</title>



<style>
.carousel-inner img {
	margin: auto;
	max-width: auto;
}

#image {

   height: 40vh;
   width: auto;

}

img {
	display: block;
	width: 100%;
	height: auto;
	position: relative;
	padding: 0%; /* 1:1 ratio */
	overflow: hidden;
}



.text_border {
	text-shadow: 0 0 2px #f00;
}
</style>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<script>
		$('.carousel').carousel({
			interval : 2000
		//기본 5초 
		})
	</script>

</head>
<body>
	
	<%
			PostDAO daoP = PostDAO.getInstance(); // getInstance
			//System.out.println("post = "+ post.toString());
			//int pnum  = daoP.nextPnum()-1;
			//int pnum = 0;
			Connection conn = null;
			List<PostBean> post = null;
			//String[] title = new String[pnum];
			//String[] name = new String[pnum];		
			ImgDAO daoI = ImgDAO.getInstance();
			conn = ConnectionProvider.getConnection();
			ImgBean img = null;
			//String[] imgSrc = new String[pnum];
			LikesDAO daoLikes = LikesDAO.getInstance();
			List<LikesBean> likesList = daoLikes.selectTop5(conn);
			
			
	%>
	
	<% %>
	
	<div id="demo" class=" carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<!-- 슬라이드쇼 -->
		<%
			post= daoP.searchByLikes(conn, likesList);
		if(likesList != null && post !=null && likesList.size()>=5) {
			int start=0;
			for(PostBean p : post){
				img = daoI.select(conn, p.getPnum());
			if(start==0){
			%>
			<div class="carousel-item active ">
			<% }else{ %>
			<div class="carousel-item "><%} %>
				<!--가로-->
				<a
					<%-- 게시글로 이동 --%>
					href="viewPost.jsp?pnum=<%=p.getPnum()%>">
					<img class="d-block w-100 center" id="image"
					<%--게시글에서 등록한 이미지 --%>
					src="./uploads/<%=img.getPnum() %>/<%=img.getImgName() %>"
					alt="Second slide"
					onerror="this.onerror=null; this.src='3d_img/noimg.png';"
					/>

					<div class="carousel-caption d-none d-md-block">
						<h5 class="text-info text_border"><%=p.getTitle() %> (<%=p.getName() %>)</h5>
						<samll class="text-info text_border">추천 수: <%=daoLikes.likes(conn, p.getPnum()) %> </samll>
					</div>
				</a>
			</div>
<%++start;}conn.close(); %>


			<!-- / 슬라이드 쇼 끝 -->
			<!-- 왼쪽 오른쪽 화살표 버튼 -->
			<div>
				<a class="carousel-control-prev" href="#demo" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<!-- <span>Previous</span> -->
				</a> <a class="carousel-control-next" href="#demo" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<!-- <span>Next</span> -->
				</a>
			</div>
			<!-- /화살표 버튼 끝 -->
			<!-- 0부터 시작 -->
			<ul class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0" class="active"></li>
				<!--인디케이터-->
				<li data-target="#demo" data-slide-to="1"></li>
				<li data-target="#demo" data-slide-to="2"></li>
				<li data-target="#demo" data-slide-to="3"></li>
				<li data-target="#demo" data-slide-to="4"></li>
			</ul>
			<!-- 인디케이터 끝-->
		</div>
		</div>
		</div>
		<%}else{ //이미지 부재, 부족
			//System.out.println("noimage");
		%>
		
		<img class="d-block w-100 center" id="image"
					<%--게시글에서 등록한 이미지 --%>
					src="3d_img/ready.gif"
					alt="Second slide"
					onerror="this.onerror=null; this.src='3d_img/noimg.png';"
					>
		<%} %>
</body>
</html>