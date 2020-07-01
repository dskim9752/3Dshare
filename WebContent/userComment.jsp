<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@page import="dao.*"%>
<%@page import="dto.*"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>댓글 기능</title>
<%
Object userID =  session.getAttribute("userID");
CommentDAO daoC = CommentDAO.getInstance(); // getInstance
Connection conn = ConnectionProvider.getConnection();
int pnum = Integer.parseInt(request.getParameter("pnum")); 
List<CommentBean> pList = daoC.selectList(conn, pnum);
int cnum=0;
int depth = 1;
%>

<script type="text/javascript">
    
        // 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
        function checkValue()
        {
            if(!document.addcomment.text.value){
                alert("댓글 내용을 입력하세요.");
               // window.history.back();
                return false;
            }
        }
</script>
</head>
<body>
<% if(pList.size()>0){ %>
 <div class="container">
	<%for(int i =0;i<pList.size();i++) {cnum++;%>
			<tr>
			    <form calss="center"  action="deleteCommentProcess.jsp"  encType="multipart/form-data" name="deletecomment">
			    <p style = "font-size: small;">작성자 : <%=pList.get(i).getName()%>  날짜 : <%=pList.get(i).getDate() %><p>
			    <p><textarea name="text" class="form-control col-sm-5" rows="3" readonly><%=pList.get(i).getText() %></textarea>
			    <% if(userID != null && userID.equals(pList.get(i).getId())) {  %>
			    <input type="hidden" name ="depth" value="<%=depth%>"/>
			    <input type="hidden" name ="cnum" value="<%=cnum%>"/>
			    <input type="hidden" name ="pnum" value="<%=pnum%>"/>
			    <input type="submit" value="삭제" class="btn btn-primary"/></p>
			    <% } %>
			    </form>
			</tr>
	 <%} %>
<% 	}	%>
<% if(userID != null) {  %>

<form calss="center"  action="addCommentProcess.jsp"  encType="multipart/form-data" name="addcomment" onsubmit="return checkValue()">
	  <textarea name="text" class="form-control col-sm-5" rows="3"></textarea>
	   <input type="hidden" name ="depth" value="<%=depth%>"/>
	  <input type="hidden" name ="pnum" value="<%=pnum%>"/>
      <input type="submit" value="댓글달기" class="btn btn-primary"/>
</form>
<%} %>

</div>
</body>
</html>