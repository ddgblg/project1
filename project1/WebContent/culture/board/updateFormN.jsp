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
			alert("������ �Է��ϼ���");
			f.subject.focus();
			return;
		}
		f.submit();
	}
	
	function cancel(){
		if(confirm("�ۼ��� ����Ͻðڽ��ϱ�?") == true){
			history.go(-1);	
		}else {
			return;
		}
	}
	function file_delete(){
		document.f.imgfile2.value=""; //name=file2�� hidden��ǲ�� ���� ��������. (������ �����Ǵ°� �ƴ�, ������ ���̽��� �Ѿ ���� ""�� �ٲ��ִ� ��)
		file_desc.style.display="none"; // div�±װ� ������ �ʵ��� ������.
	}

</script>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>������ȭŽ��_�Խñۼ���</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================���� ��======================================== -->
<form action="updateBoard.do" method="post" enctype="multipart/form-data" name="f">
	<table>
		<tr><th colspan="2">�Խù� ����</th></tr>
			<tr>
				<th style="width:10%">����</th>
				<td style="text-align: left;">
				<input type="hidden" name="btype" value="1">
				<input type="hidden" name="num" value="${b.num}">
				<input type="hidden" name="imgfile2" value="${b.imgfile}"><%-- ���� ������ ��� ����� EL�̹Ƿ� ������ null��.--%>
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
				<th style="width:10%">�ۼ���</th>
				<td style="text-align: left;">${b.nickname}</td>
			</tr>
			<tr>
				<th>����</th><td><textarea rows="15" name="content" id="content1" style="width:100%; height:100%;">${b.content}</textarea></td>
			</tr>
			<script>CKEDITOR.replace("content1",{
				filebrowserImageUploadUrl:"imgupload.do"
			})</script>
			<tr>
				<td colspan="2">
					<button type="button" onclick="inputcheck();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">�Խù�����</button>
					<button type="button" onclick="cancel();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#5b5193; color:white; font-weight:bold; font-size:14px;">�ڷΰ���</button>
					</td>
			</tr>
	</table>
</form>
</div>
</body>
</html>