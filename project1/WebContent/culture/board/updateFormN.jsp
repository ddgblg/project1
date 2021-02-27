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
	function file_delete(){
		document.f.imgfile2.value=""; //name=file2의 hidden인풋의 값을 지워버림. (파일이 삭제되는게 아닌, 데이터 베이스로 넘어갈 값을 ""로 바꿔주는 것)
		file_desc.style.display="none"; // div태그가 보이지 않도록 설정함.
	}

</script>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>지역문화탐색_게시글수정</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
<form action="updateBoard.do" method="post" enctype="multipart/form-data" name="f">
	<table>
		<tr><th colspan="2">게시물 쓰기</th></tr>
			<tr>
				<th style="width:10%">제목</th>
				<td style="text-align: left;">
				<input type="hidden" name="btype" value="1">
				<input type="hidden" name="num" value="${b.num}">
				<input type="hidden" name="imgfile2" value="${b.imgfile}"><%-- 원래 내용을 잠깐 저장용 EL이므로 없으면 null됨.--%>
				<input type="hidden" name="area" value="${b.area}">
				<input type="hidden" name="category" value="${b.category}">
				<input type="hidden" name="period_from" value="${b.period_from}">
				<input type="hidden" name="period_to" value="${b.period_to}">
				<input type="hidden" name="coordinate" value="${b.coordinate}">
				<input type="hidden" name="imgfile" value="${b.imgfile}">

				<input type="text" name="subject" style="width:100%" value="${b.subject}">
				</td>
			</tr>
			<tr>
				<th style="width:10%">작성자</th>
				<td style="text-align: left;">${b.nickname}</td>
			</tr>
			<tr>
				<th>내용</th><td><textarea rows="15" name="content" id="content1" style="width:100%; height:100%;">${b.content}</textarea></td>
			</tr>
			<script>CKEDITOR.replace("content1",{
				filebrowserImageUploadUrl:"imgupload.do"
			})</script>
			<tr>
				<td colspan="2">
					<button type="button" onclick="inputcheck();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">게시물수정</button>
					<button type="button" onclick="cancel();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#5b5193; color:white; font-weight:bold; font-size:14px;">뒤로가기</button>
					</td>
			</tr>
	</table>
</form>
</div>
</body>
</html>