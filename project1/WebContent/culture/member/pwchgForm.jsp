<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��й�ȣ ����</title>
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
			alert("���� ��й�ȣ�� �����й�ȣ ���Է��� �ٸ��ϴ�.");
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
		<caption><h3>��й�ȣ ����</h3></caption>
		<tr>
			<td><input type="password" name="pass" placeholder="���� �����ȣ �Է�"></td>
		</tr>
		<tr>
			<td><input type="password" name="chgpass" placeholder="�����Ͻ� �����ȣ �Է�"></td>
		</tr>
		<tr>
			<td><input type="password" name="chgpass2" placeholder="���� �����ȣ ���Է�"></td>
		</tr>
		<tr>
			<td><br><input type="submit" value="��й�ȣ ����" class="dochg"></td>
		</tr>
	</table>
</body>
</html>