<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>글수정</title>
<style type="text/css">
.center {
	width: 80%;
	height: auto;
	margin: auto;
	text-align: center;
	table-layout: fixed;
}
</style>


<script type="text/javascript">
    
        // 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
        function checkValue()
        {
            if(!document.editpost.title.value){
                alert("제목을 입력하세요.");
               // window.history.back();
                return false;
            }
            if(!document.editpost.text.value){
                alert("본문 내용을 입력하세요.");
               // window.history.back();
                return false;
            }
            if(!document.editpost.stlfile.value){
                alert("stl 파일을 첨부하세요.");
               // window.history.back();
                return false;
            }
            
            if(!document.editpost.imgfile.value){
                alert("img 파일을 첨부하세요.");
               // window.history.back();
                return false;
            }
            
        }
    </script>



</head>

<body>
	<%
	String userID = (String) session.getAttribute("userID");
	String userPW = (String) session.getAttribute("userPW");
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	PostDAO daoP = PostDAO.getInstance(); // getInstance 
	Connection conn = ConnectionProvider.getConnection();
	PostBean post = daoP.select(conn, pnum);
	conn.close();
		%>

	<%-- menu(TOP) --%>
	<jsp:include page="menu.jsp"/>

	<form calss="center"  action="editProcess.jsp"  method="post" name="editpost" onsubmit="return checkValue()"
		style="height: auto; max-width: 800px; margin: auto">
		<fieldset>
		<input type="hidden" name="pnum" value=<%=pnum %>>
			<br>
			<legend>게시글 수정</legend>
			<div class="form-group">
				<label for="title">제목</label> <input type="text"
					class="form-control" id="title" name="title"  placeholder="제목" value='<%=post.getTitle()%>'>
			</div>

			<div class="form-group">
				<label for="textarea">내용</label>
				<textarea class="form-control" id="textarea" name="text" rows="3"
					style="margin-top: 0px; margin-bottom: 0px; height: 512px;"
					placeholder="내용"><%=post.getText() %></textarea>
			</div>
			
			<fieldset class="form-group">
				<legend>유형</legend>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category1"
						value="부속품" <%if(post.getCategory().equals("부속품")){ %>checked=""<%} %>> 부속품
					</label>
				</div>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category2" 
						value="완제품" <%if(post.getCategory().equals("완제품")){ %>checked=""<%} %>> 완제품
					</label>
				</div>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category3" 
						value="피규어" <%if(post.getCategory().equals("피규어")){ %>checked=""<%} %>> 피규어
					</label>
				</div>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category4"
						value="기타" <%if(post.getCategory().equals("기타")){ %>checked=""<%} %>> 기타
					</label>
				</div>
			</fieldset>

			<button type="submit" class="btn btn-primary">확인</button>
		</fieldset>
		<br>
				<samll class="small">제목, 본문, 카테고리 수정만 가능합니다.</samll>
	</form>

	<br><br><br>
</body>
</html>