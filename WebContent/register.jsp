<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
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
    
        // �ʼ� �Է������� ���̵�, ��й�ȣ�� �ԷµǾ����� Ȯ���ϴ� �Լ�
        function checkValue()
        {
            if(!document.userInfo.userID.value){
                alert("���̵� �Է��ϼ���.");
               // window.history.back();
                return false;
            }
            if(!document.userInfo.name.value){
                alert("�г����� �Է��ϼ���.");
               // window.history.back();
                return false;
            }
            if(!document.userInfo.userPW.value){
                alert("��й�ȣ�� �Է��ϼ���.");
               // window.history.back();
                return false;
            }
           
            // ��й�ȣ�� ��й�ȣ Ȯ�ο� �Էµ� ���� �������� Ȯ��
            if(document.userInfo.userPW.value != document.userInfo.passwordcheck.value ){
                alert("��й�ȣ�� �����ϰ� �Է��ϼ���.");
              //  window.history.back();
                return false;
            }
            if(!document.userInfo.email.value){
                alert("�̸��� �ּҸ� �Է��ϼ���.");
               // window.history.back();
                return false;
            }
            
            
        }
        
        // ��� ��ư Ŭ���� ó������ �̵�
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
			<legend><br><br>ȸ�� ����</legend>
			<div class="form-group">
				<label for="ID">���̵�</label> <input type="text" class="form-control"
					id="userID" name="userID" placeholder="���̵�">
			</div>
			<div class="form-group">
				<label for="nickname">�г���</label> <input type="text" class="form-control"
					id="name" name="name" placeholder="�г���">
			</div>
			<div class="form-group">
				<label for="password">��й�ȣ</label> <input type="password"
					class="form-control" id="userPW"  name="userPW" placeholder="��й�ȣ">
			</div>
			<div class="form-group">
				<label for="password-confirm">��й�ȣ Ȯ��</label> <input type="password"
					class="form-control" id="passwordcheck" placeholder="��й�ȣ">
			</div>
			<div class="form-group">
				<label for="email">Email �ּ�</label> <input type="email"
					class="form-control" id="email"  name="email" aria-describedby="emailHelp"
					placeholder="Enter email"> <small id="emailHelp"
					class="form-text text-muted">We'll never share your email
					with anyone else.</small>
			</div>


			<button type="submit" class="btn btn-primary">Ȯ��</button>
		</fieldset>
	</form>
</body>
</html>