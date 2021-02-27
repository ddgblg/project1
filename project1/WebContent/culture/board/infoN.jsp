
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
</style>

</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>공지사항_게시글읽기</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->

<table>
		<tr>
			<th style="width:10%">제목</th>
			<td style="text-align:left; padding:10px;">${b.subject}</td>
		</tr>
		<tr>		
			<th style="width:10%">작성자</th>
			<td style="text-align: left;">${b.nickname}</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td style="text-align:left; vertical-align: top; boarder-width:0px; padding:10px; height:400px; overflow:auto; ">${b.content}</td>
		</tr>
		
		<tr>
			<td colspan="2">
			<div style="display:flex; justify-content:center;">
			<table style="width:400px; border:none;">
				<tr style="border:none;">
					
					<c:if test="${updateSign==1}">
					<td style="border:none;">
					<form action="updateFormN.do" method="post" name="updateN">
						<input type="hidden" name="btype" value="1">
						<input type="hidden" name="num" value="${b.num}">
						<input type="submit" value="게시글 수정" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#28768A; color:white; font-weight:bold; font-size:14px;">
					</form>
					
					</td>
					<td style="border:none;">
					<form action="deleteBoard.do" method="post" name="deleteBoard" onsubmit="return confirm('삭제하시겠습니까?');">
						<input type="hidden" name="btype" value="1">
						<input type="hidden" name="num" value="${b.num}">
						<input type="submit" value="게시글 삭제" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#151889; color:white; font-weight:bold; font-size:14px;">
					</form>
					</td>
					</c:if>
					<td style="border:none;">
					<a href="listN.do?btype=1"><button style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">목록보기</button></a>
					</td>
				</tr>
				</table>
			</div>
			</td>
		</tr>
</table>
</div>
</body>
</html>