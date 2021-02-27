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
<link rel="stylesheet" href="../../css/css1.css">
<style>
body, h1, h2, h3, h4, h5 {	font-family: "Poppins", sans-serif}
body {	font-size: 16px;}
table {	width:100%;	border: 1px solid #cccccc;	border-collapse: collapse;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px;	border-style: solid;	padding: 5px;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
button{	border-radius: 10px;	border:1px none #917CA7;	font-size:15px;	color:white;	width:150px;	height:30px;}
td{text-align:left; padding-left: 15px; height:50px;}
</style>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>내 정보 보기</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->

	<table>
		<tr>
			<th colspan="2" align="center">회원정보보기</th>
		</tr>
		<!--          회원공통정보                       -->
		<tr>
			<th>회원구분</th>
			<td>
				<c:if test="${mem.kbn ==1 }">
    				<img src="../icon/icn_gen.png"><!-- 일반회원 -->
    			</c:if>
    			<c:if test="${mem.kbn ==2 }">
    				<img src="../icon/icn_ins.png"><!-- 기관회원 -->
    			</c:if>
    			<c:if test="${mem.kbn ==3 }">
    				<img src="../icon/icn_admin.png"><!-- 관리자 -->
    			</c:if>
			</td>
		</tr>
		
		<tr>
			<th>
				레벨
			</th>
			<td>
				<c:if test="${mem.lv ==1 }">
    				Lv 1 (신규회원)
    				<c:if test="${mem.apply == 1}">
    					<b>&nbsp;&nbsp;<img src="../icon/icn_applied.png"></b>
    				</c:if>
    				<c:if test="${mem.apply == 0}">
	    				&nbsp;&nbsp;
	    				<a href="${path}/culture/member/apply.do" ><input type="button" value="등업신청하기" style="border:none; background-color:red; color:white; border-radius:20px; width:100px; height:30px; font-size:14px; font-weight:bold;"></a>
    				</c:if>
    			</c:if>
    			<c:if test="${mem.lv ==2 }">
    				Lv 2 (일반회원)
    			</c:if>
    			<c:if test="${mem.lv ==3 }">
    				Lv 3 (기관회원)
    			</c:if>
			</td>
		</tr>
		
		<tr>
			<th width="20%">아이디</th>
			<td>${mem.id }</td>
		</tr>
		
		<tr>
			<th>닉네임</th>
			<td>${mem.nickname}</td> 
		</tr>
		<tr>
			<th>이메일</th>
			<td>${mem.email}</td>
		</tr>
		
		<!--          일반 / 기관                       -->
		<tr>
			<c:if test="${mem.kbn ==1 }">
				<th>거주지역</th>
				<td>${mem.area }</td>
			</c:if>
			<c:if test="${mem.kbn ==2 }">
				<th>성명</th>
				<td>${mem.name }</td>
			</c:if>
		</tr>
		<tr>
			<c:if test="${mem.kbn ==1 }">
				<th>생년월일</th>
				<td>${mem.birth }</td>
			</c:if>
			<c:if test="${mem.kbn ==2 }">
				<th>소속기관</th>
				<td>${mem.comp }</td>
			</c:if>
		</tr>
	<c:if test="${mem.kbn ==1 }">
		<tr>
			<th>선호하는 문화활동</th>
			<td>${mem.hobby }</td>
		</tr>
	</c:if>
		<tr align="center">
			<td colspan="2" style="text-align:center;">
			<a href="memberUpdateForm.do?id=${mem.id}">
			<button type="button" class="w3-container w3-purple" style="font-weight: bold; font-size: 15px;">회원정보수정</button></a>
			
		<c:if test="${param.id != 'admin' && sessionScope.login != 'admin'}">
			<a href="deleteForm.do?id=${mem.id}">
			<button type="button" class="w3-container w3-dark-gray" style="font-weight: bold; font-size: 15px;">회원탈퇴</button></a> <%--관리자 아닐때만 탈퇴 뜨게끔. --%>
		</c:if>
			</td>
		</tr>
	</table>
	
	
</div>
</body>
</html>