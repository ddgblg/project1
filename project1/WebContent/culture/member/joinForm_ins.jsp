<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%--WebContent/model 2/member/joinForm.jsp --%>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins">
<style>
body, h1, h2, h3, h4, h5 {	font-family: "Poppins", sans-serif}
body {	font-size: 16px;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px;	border-style: solid;	padding: 5px;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
table{width:750px; border-left:none; border-right:none; border-bottom:none;border-collapse: collapse;}
td{height:50px; padding-left: 15px;}
input[type=text]{border:1px solid #dbdbdb; font-size:14px; width:300px; height:40px;}
input[type=password]{border:1px solid #dbdbdb; font-size:14px; width:300px; height:40px;}
select{border:1px solid #dbdbdb; font-size:14px; height:40px;}
th{border-left:none;border-right: none; text-align:left;}
td{border-left:none;border-right: none; }
</style>

<script type="text/javascript">
function inputcheck(f) {
	if(f.id.value == '' || f.id.value == null){
		alert("���̵� �Է��ϼ���");
		f.id.focus();
		return false;
	}
	if(f.id.value.length < 4){
		alert("���̵�� 4�ڸ� �̻� �Է��ϼ���");
		f.id.focus();
		return false;
	}
	if(f.pass.value==''||f.pass.value==null){
		alert("��й�ȣ�� �Է��ϼ���");
		f.pass.focus();
		return false;
	}
	if(f.pass2.value==''||f.pass2.value==null){
		alert("��й�ȣ�� �ѹ� �� �Է��ϼ���");
		f.pass2.focus();
		return false;
	}
	if(f.nickname.value==''||f.nickname.value==null){
		alert("�г����� �Է��ϼ���");
		f.nickname.focus();
		return false;
	}
	if(f.email.value==''||f.email.value==null){
		alert("�̸����� �Է��ϼ���");
		f.email.focus();
		return false;
	}
	if(f.name.value==''||f.name.value==null){
		alert("�̸����� �Է��ϼ���");
		f.name.focus();
		return false;
	}
	if(f.comp.value==''||f.comp.value==null){
		alert("�̸����� �Է��ϼ���");
		f.comp.focus();
		return false;
	}
	if(f.pass.value != f.pass2.value) {
		alert("���� ��й�ȣ�� �Է��ϼ���");
		f.pass.value="";
		f.pass2.value="";
		f.pass.focus();
			
		return false;
	}
		
	return true;
}
</script>

</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>ȸ������_���ȸ��</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================���� ��======================================== -->
<div style=" display:flex; justify-content: center;">
<form action="joinIns.do" name="f" method="post" onsubmit="return inputcheck(this)">
	
	<table>
		<tr>
			<th>ȸ������</th>
			<td>
				<img src="../icon/icn_ins.png">
			</td>
		</tr>
		<tr>
			<th>���̵�</th>
			<td><input type="text" name="id"></td>
		</tr>
		<tr>
			<th>��й�ȣ</th>
			<td><input type="password" name="pass"></td>
		</tr>
		<tr>
			<th>��й�ȣ��Ȯ��</th>
			<td><input type="password" name="pass2"></td>
		</tr>
		<tr>
			<th>�г���</th>
			<td><input type="text" name="nickname"></td>
		</tr>
		<tr>
			<th>�̸���</th>
			<td><input type="text" name="email"></td>
		</tr>
		<tr>
			<th>����</th>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<th>�Ҽӱ����</th>
			<td><input type="text" name="comp"></td>
		</tr>
		
		<tr>
			<td colspan="2" align="center" style="height:80px; border-bottom: none;">
			<br>
			<input type="submit" value="ȸ������" style="width:90%; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;">
			</td>
		</tr>
	</table>
</form>
</div>
</div>
</body>
</html>