<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="path" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
table {	width: 100%;	border: 1px solid #cccccc;	border-collapse: collapse;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px;	border-style: solid;	padding: 5px;}
th {	background-color: #5e5e5e;	color: white;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
input{border:1px solid #dbdbdb; font-size:14px;}
select{border:1px solid #dbdbdb; font-size:14px;}
td{padding-left: 15px; height:50px;}
</style>
<script>
	function inputcheck(f){
		if(f.pass.value == ''){
			alert("��й�ȣ�� �Է��ϼ���");
			f.pass.focus();
			return false;
		}
	}
	function win_passchg(){
		var op = "width=500, height=450, left=50, top=150";
		open("pwchgForm.do","",op);
	}
	

</script>
</head>
<body>


 <div class="w3-container" style="margin-top: 70px" id="showcase">

		<h1 class="w3-xxxlarge w3-text-red">
			<b>ȸ����������</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================���� ��======================================== -->
	<form action="update.do" name="f" method="post" onsubmit="return inputcheck(this)">
		<table>
		<tr>
			<th colspan="2" align="center">ȸ����������</th>
		</tr>
		<!--          ȸ����������                       -->
		<tr>
			<th>ȸ������</th>
			<td>
				<c:if test="${mem.kbn ==1 }"><!-- �Ϲ�ȸ�� -->
    				<img src="../icon/icn_gen.png">
    			</c:if>
    			<c:if test="${mem.kbn ==2 }"><!-- ���ȸ�� -->
    				<img src="../icon/icn_ins.png">
    			</c:if>
    			<c:if test="${mem.kbn ==3 }"><!-- ������ -->
    				<img src="../icon/icn_admin.png">
    			</c:if>
			</td>
		</tr>
		
		<tr>
			<th>
				����
			</th>
			<td>
				<c:if test="${mem.lv ==1 }">
    				Lv 1 (�ű�ȸ��)
    			</c:if>
    			<c:if test="${mem.lv ==2 }">
    				Lv 2 (�Ϲ�ȸ��)
    			</c:if>
    			<c:if test="${mem.lv ==3 }">
    				Lv 3 (���ȸ��)
    			</c:if>
    			<c:if test="${mem.lv ==4 }">
    				Lv 4 (������)
    			</c:if>
			</td>
		</tr>
		
		<tr>
			<th width="20%">���̵�</th>
			<td>
				${mem.id }
				<input type="hidden" name="id" value="${mem.id}">
			</td>
		</tr>
		
		<tr>
			<th>�г���</th>
			<td><input type="text" name="nickname" value="${mem.nickname}"></td> 
		</tr>
		<tr>
			<th>�̸���</th>
			<td><input type="text" name="email" value="${mem.email}"></td>
		</tr>
		
		<!--          �Ϲ� / ���                       -->
		<tr>
			<c:if test="${mem.kbn ==1 || mem.kbn ==3}">
				<th>��������</th>
				<td>
				<select name="area">
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="��õ" <c:if test="${mem.area =='��õ' }">selected</c:if>>��õ</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="�뱸" <c:if test="${mem.area =='�뱸' }">selected</c:if>>�뱸</option>
					<option value="�λ�" <c:if test="${mem.area =='�λ�' }">selected</c:if>>�λ�</option>
					<option value="���" <c:if test="${mem.area =='���' }">selected</c:if>>���</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="���" <c:if test="${mem.area =='���' }">selected</c:if>>���</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="���" <c:if test="${mem.area =='���' }">selected</c:if>>���</option>
					<option value="�泲" <c:if test="${mem.area =='�泲' }">selected</c:if>>�泲</option>
					<option value="���" <c:if test="${mem.area =='���' }">selected</c:if>>���</option>
					<option value="�泲" <c:if test="${mem.area =='�泲' }">selected</c:if>>�泲</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
					<option value="����" <c:if test="${mem.area =='����' }">selected</c:if>>����</option>
				</select>
				</td>
			</c:if>
			<c:if test="${mem.kbn ==2 || mem.kbn==3}">
				<c:if test="${mem.kbn==3}"><tr></c:if>
				<th>����</th>
				<td><input type="text" name="name" value="${mem.name}"></td>
				<c:if test="${mem.kbn==3}"></tr></c:if>
			</c:if>
		</tr>
		<tr>
			<c:if test="${mem.kbn ==1 || mem.kbn==3 }">
				<th>�������</th>
				<td>
					<c:set var="birth" value="${mem.birth} }"/>
					<c:set var="arr" value="${fn:split(birth, '/')}"/>
					<select name="birth_yyyy">
						<c:forEach var="year" begin="1900" end="2020" step="1">
							<option <c:if test="${year == arr[0]}">selected</c:if>>${year}</option>
						</c:forEach>
					</select>��
					
					<select name="birth_mm">
						<c:forEach var="month" begin="1" end="12" step="1">
							<option <c:if test="${month == arr[1]}">selected</c:if>>${month}</option>
						</c:forEach>
					</select>��
			<!-- ============================== �������ɼ� ���� ��=================================-->
					<c:set var="d1" value="${fn:substring(arr[2],0,2)}"/>
					<c:set var="d2" value="${fn:trim(d1)}"/> 
					<select name="birth_dd">
						<c:forEach var="day" begin="1" end="31" step="1">
							<option <c:if test="${day == d2}">selected</c:if>>${day}</option>
						</c:forEach>
					</select>��
			<!-- ===============================�������ɼ� ���� ��=================================--> 
				</td>
			</c:if>
			<c:if test="${mem.kbn ==2 || mem.kbn==3}">
				<c:if test="${mem.kbn==3}"><tr></c:if>
				<th>�Ҽӱ��</th>
				<td><input type="text" name="comp" value="${mem.comp}"></td>
				<c:if test="${mem.kbn==3}"></tr></c:if>
			</c:if>
		</tr>
	<c:if test="${mem.kbn ==1|| mem.kbn==3 }">
		<tr>
			<th>��ȣ�ϴ� ��ȭȰ��</th>
			<td><input type="text" name="hobby" value="${mem.hobby}"></td>
		</tr>
	</c:if>
		<tr>
			<th>��й�ȣ�Է�</th><td><input type="password" name="pass"></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				
				<c:if test="${sessionScope.login != 'admin' || param.id == 'admin'}">
					<input type="hidden" name="updatepage" value="" >
				</c:if>
				<c:if test="${sessionScope.login == 'admin' || param.id != 'admin'}">
					<input type="hidden" name="updatepage" value="1" >
				</c:if>
				
				<input type="submit" value="�����Ϸ�" style="border:none; border-radius:15px; color:white; background-color:#4b8593; font-size:14px; font-weight:bold; width:130px; height:30px;">
				<c:if test="${sessionScope.login != 'admin' || param.id == 'admin'}">
					<input type="button" value="��й�ȣ����" onclick="win_passchg()"  style="border:none; border-radius:15px; color:white; background-color:#aa8923; font-size:14px; font-weight:bold; width:130px; height:30px;">
				</c:if>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
