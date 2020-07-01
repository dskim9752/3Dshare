<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
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
            if(!document.userInfo.userID.value){
                alert("아이디를 입력하세요.");
               // window.history.back();
                return false;
            }
            if(!document.userInfo.name.value){
                alert("닉네임을 입력하세요.");
               // window.history.back();
                return false;
            }
            if(!document.userInfo.userPW.value){
                alert("비밀번호를 입력하세요.");
               // window.history.back();
                return false;
            }
           
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(document.userInfo.userPW.value != document.userInfo.passwordcheck.value ){
                alert("비밀번호를 동일하게 입력하세요.");
              //  window.history.back();
                return false;
            }
            if(!document.userInfo.email.value){
                alert("이메일 주소를 입력하세요.");
               // window.history.back();
                return false;
            }
            
            
        }
        
        // 취소 버튼 클릭시 처음으로 이동
        function goBack() {
            location.href="main.jsp";
        }
    </script>

</head>

<body>
	<%
		String userID = request.getParameter("userID");
		String userPW = request.getParameter("userPW");%>

<%-- menu(TOP) --%>
	<jsp:include page="menu.jsp"/>



	<form calss="center" action="registerProcess.jsp"  method="post" onsubmit="return checkValue()"  name="userInfo" 
		style="height: auto; max-width: 800px; margin: auto">
		<fieldset>
			<br>
			<legend><br><br>회원 가입</legend>
			<div class="form-group">
				<label for="ID">아이디</label> <input type="text" class="form-control"
					id="userID" name="userID" placeholder="아이디">
			</div>
			<div class="form-group">
				<label for="nickname">닉네임</label> <input type="text" class="form-control"
					id="name" name="name" placeholder="닉네임">
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label> <input type="password"
					class="form-control" id="userPW"  name="userPW" placeholder="비밀번호">
			</div>
			<div class="form-group">
				<label for="password-confirm">비밀번호 확인</label> <input type="password"
					class="form-control" id="passwordcheck" placeholder="비밀번호">
			</div>
			<div class="form-group">
				<label for="email">Email 주소</label> <input type="email"
					class="form-control" id="email"  name="email" aria-describedby="emailHelp"
					placeholder="Enter email"> <small id="emailHelp"
					class="form-text text-muted">We'll never share your email
					with anyone else.</small>
			</div>


			<button type="submit" class="btn btn-primary">확인</button>
		</fieldset>
	</form>
</body>
</html>