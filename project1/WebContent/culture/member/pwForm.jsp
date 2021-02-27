<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%--'
    pwForm.jsp
     --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>
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
<script>
	function inputcheck(f){
		if(f.id.value==''||f.id.value==null){
			alert("아이디를 입력하세요");
			f.id.focus();
			return false;
		}
		if(f.nickname.value==''||f.nickname.value==null){
			alert("닉네임을 입력하세요");
			f.nickname.focus();
			return false;
		}
		if(f.email.value==''||f.email.value==null){
			alert("이메일을 입력하세요");
			f.email.focus();
			return false;
		}
		return true;
	}
</script>
<form action="pw.do" method="post" onsubmit="return inputcheck(this)">
	<table>
		<tr>
			<td><input type="text" name="id" placeholder="아이디 입력"></td>
		</tr>
		<tr>
			<td><input type="text" name="nickname" placeholder="닉네임 입력"></td>
		</tr>
		<tr>
			<td><input type="text" name="email" placeholder="이메일 입력"></td>
		</tr>
		<tr>
			<td><input type="submit" value="비밀번호찾기" class="searchid">
		</tr>
	</table>
</form>

</body>
</html>