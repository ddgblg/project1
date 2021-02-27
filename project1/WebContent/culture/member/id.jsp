<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="../../css/css1.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
table{border:none; width: 400px;}
th, td{height:60px; font-size:25px; border:none; width:400px;}
.font01{font-family: 'Noto Sans KR', sans-serif;}
.searchid{width:400px; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;}
body{background-color:#f4f4f4;}
</style>
<script>
<c:if test="${!isUsers}">
		alert("${msg}");
		location.href="${url}";
</c:if>
</script>
<script type="text/javascript">
	function idsend(id){
		opener.document.f.id.value=id;
		self.close();
	}
</script>
</head>
<body>
<div style="display:flex; justify-content: center; vertical-align: middle;">
<font class="font01">
<table>
	<tr>
		<th>검색결과▼</th>
	</tr>
	<tr>
		<td style="background-color:white;">${id }</td>
	</tr>
	<tr>
		<td><br><input type="button" value="아이디 전송하기" onclick="idsend('${id}')" class="searchid">	</tr>
</table>
</font>
</div>
</body>
</html>


