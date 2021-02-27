<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins">
<style>
body, h1, h2, h3, h4, h5 {font-family: "Poppins", sans-serif}
body {	font-size: 16px;}
table {	width:100%;	border: 1px solid #cccccc;	border-collapse: collapse;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px;	border-style: solid;	padding: 5px;}
th{background-color:#eaeaea;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
button{
	border-radius: 10px;
	border:1px none #917CA7;
	font-size:15px;
	color:white;
	width:150px;
	height:30px;
}
td{height:50px; padding-left: 15px;}
</style>
</head>
<body>

<div class="w3-container" style="margin-top: 70px" id="showcase">
	<h1 class="w3-xxxlarge w3-text-red">
		<b>ȸ������</b>
	</h1>
	<hr style="width: 50px; border: 5px solid red" class="w3-round">
	<!-- ===========================���� ��======================================== -->
	<table>
		<tr>
			<th colspan="2" align="center" style="background-color: #4c4c4c; color: white; width:50%">������ ���� ����</th>
			<th colspan="2" align="center" style="background-color: #4c4c4c; color: white; width:50%">ȸ�����</th>
		</tr>
		<!--          ȸ����������                       -->
		<tr>
			<th>ȸ������</th>
			<td><img src="../icon/icn_admin.png"></td>
			
			<th>��ü</th>
			<td>${totalMember} ��</td>
		</tr>
		
		<tr>
			<th>����</th>
			<td>Lv 4 (������)</td>
			
			<th><img src="../icon/icn_gen.png"></th><!-- �Ϲ�ȸ�� -->
			<td>${genMember} ��</td>
		</tr>
		
		<tr>
			<th width="20%">���̵�</th>
			<td>${mem.id }</td>
			
			<th><img src="../icon/icn_ins.png"></th><!-- ���ȸ�� -->
			<td>${insMember} ��</td>
		</tr>
		
		<tr>
			<th>�г���</th>
			<td>${mem.nickname}</td> 
			
			<th><img src="../icon/icn_applied.png"></th><!-- �����û�Ϸ��� -->
			<td>${appliedMember} ��</td>
		</tr>
		
		<tr>
			<th>�̸���</th>
			<td>${mem.email}</td>
			
			<th><img src="../icon/icn_nonapply.png"></th><!-- ����̽�û�� -->
			<td>${nonAppliedMember} ��</td>
		</tr>
		
		<!--          �Ϲ� / ���                       -->
		<tr>
			<th>��������</th>
			<td>${mem.area }</td>
			
			<td colspan="2" rowspan="5"></td>
		</tr>
		
		<tr>
			<th>�������</th>
			<td>${mem.birth }</td>
		</tr>
		
		<tr>
			<th>��ȣ�ϴ� ��ȭȰ��</th>
			<td>${mem.hobby }</td>
		</tr>

		<tr>	
			<th>����</th>
			<td>${mem.name }</td>
		</tr>
		
		<tr>
			<th>�Ҽӱ��</th>
			<td>${mem.comp }</td>
		</tr>
		

		
		<tr align="center">
			<td colspan="4">
			<a href="memberUpdateForm.do?id=${mem.id}">
			<button type="button" class="w3-container w3-purple" style="font-weight: bold; font-size: 15px;">��������������</button></a>

			<a href="memberList.do">
			<button type="button" class="w3-container w3-dark-gray" style="font-weight: bold; font-size: 15px;">ȸ����Ϻ���</button></a>
		</tr>
	</table>

</div>
</body>
</html>