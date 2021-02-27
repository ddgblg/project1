<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%--
	model2/deleteForm.jsp
	
	1. id파라미터 저장하기
	
	2. login 여부 검증하기
		-로그아웃 상태인 경우
			로그인하세요. 메시지 출력 후 loginForm.me 페이지로 이동
			
		-관리자가 아니면서, id 파라미터 정보와 login 정보가 다른 경우
			본인만 탈퇴 가능합니다. 메시지 출력 후, main.me 페이지로 이동
	3. 현재 화면 출력하기
	의미없다 모델2에선.
	--------------------
	
 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins">
<style>
body, h1, h2, h3, h4, h5 {
	font-family: "Poppins", sans-serif
}

body {
	font-size: 16px;
}

table {
	border: none;
	border-collapse: collapse;
}

th, td {
	border:none;
	padding: 5px;
}
td{height:60px; text-align:center;}
input[type=text]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input[type=password]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input::placeholder{color: #c6c6c6; }
.dodelete{width:400px; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;}
.ti{color:#434a5d;}
</style>
<script>
	function inputcheck(f) {
		if (f.pass.value == "") {
			alert("비밀번호 입력")
			f.pass.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="w3-container" style="margin-top: 70px;" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>회원 탈퇴/삭제</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
		<div style="display: flex; justify-content: center; vertical-align: middle; height: 100%">
			<form action="delete.do" name="f" onsubmit="return inputcheck(this)">
				<table>
					<caption><h3 class="ti"><b>비밀번호 입력</b></h3></caption>
					<input type="hidden" name="id" value="${param.id}">
					<tr>
						<td><input type="text" name="pass" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<td align="center"><input type="submit"	value="탈퇴/삭제하기" class="dodelete"></td>
					</tr>
				</table>
			</form>
		</div>
</body>
</html>