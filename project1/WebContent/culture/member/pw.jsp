<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="../../css/css1.css">
<style>
table{border:none; width: 400px;}
th, td{height:60px; font-size:25px; border:none; width:400px;}
.font01{font-family: 'Noto Sans KR', sans-serif;}
.searchpw{width:400px; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;}
body{background-color:#f4f4f4;}
</style>
<script>
<c:if test="${!isUsers}">
		alert("${msg}");
		location.href="${url}";
</c:if>
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
		<td>${pw}</td>
	</tr>
	<tr>
		<td><input type="button" value="닫기" onclick="javascript:self.close()" class="searchpw">	</tr>
</table>
</font>
</div>
</body>
</html>