<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%--model2/idForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="../../css/css1.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
.idform{display:flex; justify-content: center; vertical-align: middle;}
table{border:none;}
td{border:none;}
input[type=text]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input::placeholder{color: #c6c6c6; font-size:15px; font-weight:bold;}
.searchid{width:400px; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;}
.font01{font-family: 'Noto Sans KR', sans-serif;}
body{background-color:#f4f4f4;}
h2{color:#434a5d;}
</style>
</head>
<body>
<font class="font01">
<div style="display:flex; justify-content: center;">
<h2>아이디 찾기</h2>
</div>

<form action="id.do" method="post">
	
	<table>
		<tr>
			<td><input type="text" name="nickname" placeholder="닉네임 입력"></td>
		</tr>
		<tr>
			<td><input type="text" name="email" placeholder="이메일 입력"></td>
		</tr>
		<tr>
			<td>
			<br>
			<input type="submit" value="아이디찾기" class="searchid">
			
			</td>
		</tr>
	</table>
</form>
</font>
</body>
</html>