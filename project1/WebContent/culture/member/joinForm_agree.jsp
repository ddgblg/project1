<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%--WebContent/model 2/member/joinForm.jsp --%>
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
	width:100%;
	border: 1px solid #cccccc;
	border-collapse: collapse;
}

th, td {
	border-collapse: collapse;
	border-color: #cccccc;
	border-width: 1px;
	border-style: solid;
	padding: 5px;
}

.w3-half img {
	margin-bottom: -6px;
	margin-top: 16px;
	opacity: 0.8;
	cursor: pointer
}

.w3-half img:hover {
	opacity: 1
}
input[type=button]{
border:none;
border-radius:10px;
color:white;
width:120px;
height:30px;
}
td{height:50px;}
</style>

<script type="text/javascript">
function inputcheck() {
	if(document.f.agree.value!=1) {
		alert("미동의는 회원가입 불가");
		return false;
	}
	location.href="joinForm_gen.do";
}
function inputcheck2() {
	if(document.f.agree.value!=1) {
		alert("미동의는 회원가입 불가");
		return false;
	}
	location.href="joinForm_ins.do";
}
</script>

</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>회원가입</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
<form name="f">
	<table>
		<tr>
			<td align="center">
				&lt;개인정보 수집·이용에 대한 동의&gt;<br>
				<table>
				<tr>
					<td style="background-color:#f1f1f1; text-align:center;">본 웹사이트에서는 원활한 커뮤니티 서비스 제공을 위해 아래와 같이 귀하의 개인정보를 수집·이용하고자 합니다.
					</td>
				</tr>
				</table>
						<br>
				<table>
				<tr>
					<th align="center">항목</th><th align="center">수집목적</th><th align="center">보유기간</th>
				</tr>
				<tr>
					<td align="center">성명, 이메일, 생년월일, 소속기관 등</td><td align="center">커뮤니티 서비스 제공 등</td><td align="center">1년</td>
				</tr>
				</table>
				<br>
				※ 위 개인정보 수집에 대한 동의를 거부할 권리가 있으며, 동의 거부 시 회원가입이 제한될 수 있습니다.
			</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="agree" value="1">동의
				<input type="radio" name="agree" value="2">미동의</td>
		</tr>
		<tr>
			<td align="center">
				<input type="button" value="일반회원가입" onclick="inputcheck()" style="background-color:#59bf2b">
			&nbsp;
			<input type="button" value="기관회원가입" onclick="inputcheck2()" style="background-color:#8575a1">
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>