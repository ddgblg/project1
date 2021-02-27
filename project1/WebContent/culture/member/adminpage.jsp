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
		<b>회원관리</b>
	</h1>
	<hr style="width: 50px; border: 5px solid red" class="w3-round">
	<!-- ===========================내용 ↓======================================== -->
	<table>
		<tr>
			<th colspan="2" align="center" style="background-color: #4c4c4c; color: white; width:50%">관리자 정보 보기</th>
			<th colspan="2" align="center" style="background-color: #4c4c4c; color: white; width:50%">회원통계</th>
		</tr>
		<!--          회원공통정보                       -->
		<tr>
			<th>회원구분</th>
			<td><img src="../icon/icn_admin.png"></td>
			
			<th>전체</th>
			<td>${totalMember} 명</td>
		</tr>
		
		<tr>
			<th>레벨</th>
			<td>Lv 4 (관리자)</td>
			
			<th><img src="../icon/icn_gen.png"></th><!-- 일반회원 -->
			<td>${genMember} 명</td>
		</tr>
		
		<tr>
			<th width="20%">아이디</th>
			<td>${mem.id }</td>
			
			<th><img src="../icon/icn_ins.png"></th><!-- 기관회원 -->
			<td>${insMember} 명</td>
		</tr>
		
		<tr>
			<th>닉네임</th>
			<td>${mem.nickname}</td> 
			
			<th><img src="../icon/icn_applied.png"></th><!-- 등업신청완료자 -->
			<td>${appliedMember} 명</td>
		</tr>
		
		<tr>
			<th>이메일</th>
			<td>${mem.email}</td>
			
			<th><img src="../icon/icn_nonapply.png"></th><!-- 등업미신청자 -->
			<td>${nonAppliedMember} 명</td>
		</tr>
		
		<!--          일반 / 기관                       -->
		<tr>
			<th>거주지역</th>
			<td>${mem.area }</td>
			
			<td colspan="2" rowspan="5"></td>
		</tr>
		
		<tr>
			<th>생년월일</th>
			<td>${mem.birth }</td>
		</tr>
		
		<tr>
			<th>선호하는 문화활동</th>
			<td>${mem.hobby }</td>
		</tr>

		<tr>	
			<th>성명</th>
			<td>${mem.name }</td>
		</tr>
		
		<tr>
			<th>소속기관</th>
			<td>${mem.comp }</td>
		</tr>
		

		
		<tr align="center">
			<td colspan="4">
			<a href="memberUpdateForm.do?id=${mem.id}">
			<button type="button" class="w3-container w3-purple" style="font-weight: bold; font-size: 15px;">관리자정보수정</button></a>

			<a href="memberList.do">
			<button type="button" class="w3-container w3-dark-gray" style="font-weight: bold; font-size: 15px;">회원목록보기</button></a>
		</tr>
	</table>

</div>
</body>
</html>