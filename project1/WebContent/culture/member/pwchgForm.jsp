<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="../../css/css1.css">
<style>
table, tr, td{border:none;}
td{height:60px; text-align:center;}
input[type=text]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input[type=password]{border:1px solid #dbdbdb; font-size:14px; font-weight:bold; width:400px; height:60px; padding-left: 30px;}
input::placeholder{color: #c6c6c6; }
.dochg{width:400px; height:70px; font-weight:bold; font-size:20px; background-color:#434a5d; color:white; border:none;}

</style>


<script>

	function inchk(f){
		if(f.chgpass.value != f.chgpass2.value){
			alert("변경 비밀번호와 변경비밀번호 재입력이 다릅니다.");
			f.chgpass2.value="";
			f.chgpass2.focus();
			return false;
		}
		return true;
	}

</script>
</head>
<body>
<form action="pwchg.do" method="post" name="f" onsubmit="return inchk(this)">
	<table>
		<caption><h3>비밀번호 변경</h3></caption>
		<tr>
			<td><input type="password" name="pass" placeholder="현재 비빌번호 입력"></td>
		</tr>
		<tr>
			<td><input type="password" name="chgpass" placeholder="변경하실 비빌번호 입력"></td>
		</tr>
		<tr>
			<td><input type="password" name="chgpass2" placeholder="변경 비빌번호 재입력"></td>
		</tr>
		<tr>
			<td><br><input type="submit" value="비밀번호 변경" class="dochg"></td>
		</tr>
	</table>
</body>
</html>