<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>글작성</title>
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
            if(!document.makepost.title.value){
                alert("제목을 입력하세요.");
               // window.history.back();
                return false;
            }
            if(!document.makepost.text.value){
                alert("본문 내용을 입력하세요.");
               // window.history.back();
                return false;
            }
            if(!document.makepost.stlfile.value){
                alert("stl 파일을 첨부하세요.");
               // window.history.back();
                return false;
            }
            
            if(!document.makepost.imgfile.value){
                alert("img 파일을 첨부하세요.");
               // window.history.back();
                return false;
            }
            
        }
        
        
        function chk_file_type(obj) {

        	var file_kind = obj.value.lastIndexOf('.');

        	var file_name = obj.value.substring(file_kind+1,obj.length);

        	var file_type = file_name.toLowerCase();

        	var check_file_type=new Array();

        	check_file_type=['jpg','gif','png','jpeg','bmp','tif'];



        	if(check_file_type.indexOf(file_type)==-1) {

        		alert('이미지 파일만 첨부할 수 있습니다.');

        		var parent_Obj=obj.parentNode;

        		var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);



        		document.getElementById("imagefile").value = "";    //초기화를 위한 추가 코드

        		document.getElementById("imagefile").select();        //초기화를 위한 추가 코드  wfb-field-219958876

        		document.selection.clear();      
        		//일부 브라우저 미지원
        		return false;

        	}

        }
    </script>



</head>

<body>
	<%
	String userID = (String) session.getAttribute("userID");
	String userPW = (String) session.getAttribute("userPW");
		%>

	<%-- menu(TOP) --%>
	<jsp:include page="menu.jsp"/>

	<form calss="center"  action="makeProcess.jsp"  method="post" encType="multipart/form-data" name="makepost" onsubmit="return checkValue()"
		style="height: auto; max-width: 800px; margin: auto">
		<fieldset>
			<br>
			<legend>게시글 글쓰기</legend>
			<div class="form-group">
				<label for="title">제목</label> <input type="text"
					class="form-control" id="title" name="title"  placeholder="제목">
			</div>

			<div class="form-group">
				<label for="textarea">내용</label>
				<textarea class="form-control" id="textarea" name="text" rows="3"
					style="margin-top: 0px; margin-bottom: 0px; height: 512px;"
					placeholder="내용"></textarea>
			</div>
			<div class="form-group">
				<label for="imageFile">Image</label> <input type="file"  accept="image/* 
					class="form-control-file" id="imagefile"  name="imgfile"
					aria-describedby="fileHelp"  onchange='chk_file_type(this)'> <small id="fileHelp"
					class="form-text text-muted">이미지 파일을 넣어주세요.</small>
			</div>

			<div class="form-group">
				<label for="stlFile">STL file</label> <input type="file" accept=".stl, .zip, .rar, .obj, .3dm"
					class="form-control-file" id="stlFile"  name="stlfile" aria-describedby="fileHelp">
				<small id="fileHelp" class="form-text text-muted">모델링 혹은 zip 파일을
					넣어주세요.</small>
			</div>
			<fieldset class="form-group">
				<legend>유형</legend>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category1"
						value="부속품" checked=""> 부속품
					</label>
				</div>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category2" 
						value="완제품"> 완제품
					</label>
				</div>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category3" 
						value="피규어"> 피규어
					</label>
				</div>
				<div class="form-check">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="category" id="category4"
						value="기타"> 기타
					</label>
				</div>
			</fieldset>

			<button type="submit" class="btn btn-primary">확인</button>
		</fieldset>
	</form>
	<br><br><br>
</body>
</html>