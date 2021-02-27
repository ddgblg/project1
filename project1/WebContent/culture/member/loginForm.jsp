<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%-- model2/ loginForm.jsp --%>
<!DOCTYPE html>
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
table {	width:650px;	border: none;	border-collapse: collapse;}
th, td {border:none;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
td{height:60px; text-align:center;}
input[type=text]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input[type=password]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input::placeholder{color: #c6c6c6; }
.dologin{width:400px; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;}
</style>
<script type="text/javascript">
	function inputcheck(f) {
		if(f.id.value == '') {
			alert("아이디를 입력하세요");
			f.id.focus();
			return false;
		}
		if(f.id.value.length < 4) {
			alert("아이디는 4자리 이상 입력하세요");
		}
		if(f.pass.value == ''){
			alert("비밀번호를 입력하세요");
			f.pass.focus();
			return false;
		}
		return true;
	}	
	
	function win_open(page) {
		var op = "width=500, height=350, left=50, top=150";
		open(page+".jsp","",op);
	}
</script>
</head>
<body>
	<div class="w3-container" style="margin-top: 70px; " id="showcase" >
		<h1 class="w3-xxxlarge w3-text-red">
			<b>MEMBER LOGIN</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
<div style=" display:flex; justify-content: center; vertical-align: middle; height:100%">
			<form action="login.do" method="post" name="f" onsubmit="return inputcheck(this)">
<br>
			<table>
				<tr>
					<td><input type="text" name="id" placeholder="아이디 입력 "></td>
				</tr>
				<tr>
					<td><br><input type="password" name="pass" placeholder="비밀번호 입력"></td>
				</tr>
				<tr>
					<td>
					<br><br>
						<input type="submit" value="로그인" class="dologin">
					</td>
				</tr>
				<tr>
					<td>
						<br>
						<a href="javascript:win_open('idForm')">아이디 찾기</a> 
						&nbsp;|&nbsp;
						<a href="javascript:win_open('pwForm')">비밀번호 찾기</a><br>
					</td>
				</tr>
			</table>
			</form>
</div>
</div>
</body>
</html>