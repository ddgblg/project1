<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%--/WebContent/model2/board/writeForm.jsp --%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="../../css/css1.css">
<style>
body, h1, h2, h3, h4, h5 {	font-family: "Poppins", sans-serif}
body {	font-size: 16px;}
table {	width:100%;	border: 1px solid #cccccc;	border-collapse: collapse;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px; border-style: solid;	padding: 5px;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
input{border:1px solid #dbdbdb; font-size:14px;}
select{border:1px solid #dbdbdb; font-size:14px;}
</style>
<script>
	function inputcheck() {
		f = document.f;
		if(f.subject.value==""){
			alert("제목을 입력하세요");
			f.subject.focus();
			return;
		}
		f.submit();
	}
	function cancel(){
		if(confirm("작성을 취소하시겠습니까?") == true){
			history.go(-1);	
		}else {
			return;
		}
	}
</script>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>공지사항_게시글작성</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
		
		<!-- 지역문화탐색_게시물작성 페이지 : 레벨3이상만 접근 가능 
		
		지역문화탐색 Set
		layout -> lv return해서 input hidden+form action -> listC.jsp (글쓰기 표출 여부 lv로 form action)-> 로그인검증, lv검증 -> writeFormC.jsp
		                    			                                                          -> 로그인검증, lv검증 -> infoC.jsp
			
		페이지 들어올 때 Action 메소드에서 레벨 검증 후 접근 제한으로 한다.
		  
		예전에
		추상클래스 만들어서
		유저로그인
		어드민로그인
		
		gen login?
		ins login?
		레벨 3에 해당하는 정보면 레벨 3만 ㅏㄹ할 수 있도록
		
		-->
<form action="write.do" method="post" enctype="multipart/form-data" name="f">
	<table>
		<tr><th colspan="2">게시물 쓰기</th></tr>
			<tr>
				<th style="width:10%">작성자</th>
				<td style="width:90%; text-align: left;">
					${nickname}
					<input type="hidden" name="btype" value="1">
					<input type="hidden" name="id" value="${id}">
					<input type="hidden" name="area" value="">
					<input type="hidden" name="category" value="">
					<input type="hidden" name="period_from" value="">
					<input type="hidden" name="period_to" value="">
					<input type="hidden" name="coordinate" value="">
					<input type="hidden" name="imgfile" value="">
				</td>
			</tr>
			<tr>
				<th>제목</th><td><input type="text" name="subject" style="width:100%"></td>
			</tr>
			<tr>
				<th>내용</th><td><textarea rows="15" name="content" id="content1" style="width:100%; height:100%;"></textarea></td>
			</tr>
			<script>CKEDITOR.replace("content1",{
				filebrowserImageUploadUrl:"imgupload.do"
			})</script>
		
			<tr>
				<td colspan="2">
					<button type="button" onclick="inputcheck();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">게시물등록</button>
					<button type="button" onclick="cancel();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#5b5193; color:white; font-weight:bold; font-size:14px;">뒤로가기</button>
				
				</td>
			</tr>
	</table>
</form>
</div>
</body>
</html>