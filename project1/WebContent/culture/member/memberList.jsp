<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="../../css/css1.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins">
<style>
.w3-half img {
	margin-bottom: -6px;
	margin-top: 16px;
	opacity: 0.8;
	cursor: pointer
}

.w3-half img:hover {
	opacity: 1
}
.listb:hover{background-color:#f8f8f8;}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script>
function allchkbox(chk) {
	var allchk = chk.checked // ��ü ���� �� (true/ false)
	//getElementsByName(name) : name �Ӽ��� ���� "mailchk"�� �±� '��'
	// <input name="mailchk" ...>
	document.getElementsByName("lvupchk").forEach( // �迭.
	function(item, index) {
		// item : name="mailchk"�� �±� �� ��.
		if (allchk) { // ��ü���ð��� true�ΰ��(���õȰ��)
			item.setAttribute("checked", true); // item�� �Ӽ��߿� checked��� �Ӽ��� true�� �����.
		} else {
			item.removeAttribute("checked"); // item�Ӽ��� checked�Ӽ��� ���ֹ���.
		}
	})
}
$(function(){
	$("#lvsubmit").click(function(){
		var param = [];
		$("input[name='lvupchk']:checked").each(function(index,item){//üũ�� ����Ʈ ����
             param.push($(item).val());
        });
         
		 $.ajax({
			 url:"testlvup.do",
			 type:"post",
			 data: {param : param},
			 success: function(){alert("������ �Ϸ�"); console.log(param)},
			 error: function(){alert("������ ����")}
		 })
	})
})


</script>
</head>
<body>
	<div class="w3-container" style="margin-top: 70px" id="showcase">

		<h1 class="w3-xxxlarge w3-text-red">
			<b>ȸ����Ϻ���</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================���� ��======================================== -->


		<div style="display: flex; justify-content: left;">
			<form action="memberList.do" method="post" name="sf">
				ȸ������ : &nbsp; 
				<select name="kbn">
					<option value="" >������ü</option>
					<option value="1">�Ϲ�ȸ��</option>
					<option value="2">���ȸ��</option>
				</select>
				<script>document.sf.kbn.value = "${param.kbn}";</script> 
				&nbsp;������� : &nbsp; 
				<select name="apply">
					<option value="">�����ü</option>
					<option value="1">�����û��</option>
					<option value="0">����̽�û��</option>
				</select> &nbsp;&nbsp; 
				<script>document.sf.apply.value = "${param.apply}";</script>
				<input type="submit" value="�˻�">
			</form>
		</div>
		<hr>
		<c:set var="mlist" value="${list}" />
		<c:if test="${memcount ==0}">
			<h3>*�˻���� ����*</h3>
		</c:if>
		<c:if test="${memcount != 0}">
			<table>
				<tr>
					<th colspan="17" align="center">�˻���� ��</th>
				</tr>
				<tr>
					<td colspan="17" align="left">�˻���� : ${memcount}��</td>
				</tr>
				<tr>
					<th>ȸ������</th><th>���̵�</th><th>�г���</th><th>�̸���</th>
					<th>��������</th><th>�������</th><th>��ȣ��ȭȰ��</th>
					<th>����</th><th>�Ҽӱ����</th><th>ȸ�����Գ�¥</th>
					<th>ȸ������</th><th>ȸ���ܰ�</th><th>�����û����</th>
					<th></th><th></th><th>��������</th><th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
				</tr>
				
				<c:forEach var="i" items="${mlist}">
					<tr class="listb">
						<td>
							<c:if test="${i.kbn==1}">
								<img src="../icon/icn_gen.png">
							</c:if>
							<c:if test="${i.kbn==2}">
								<img src="../icon/icn_ins.png">
							</c:if>
							<c:if test="${i.kbn==3}">
								<img src="../icon/icn_admin.png">
							</c:if>
						</td>
						<td>${i.id}</td>
						<td>${i.nickname}</td>
						<td>${i.email}</td>
						<td
							<c:if test="${i.kbn==2}">style="background-color:#d3d3d3;"</c:if>>${i.area}</td>
						<td
							<c:if test="${i.kbn==2}">style="background-color:#d3d3d3;"</c:if>>${i.birth}</td>
						<td
							<c:if test="${i.kbn==2}">style="background-color:#d3d3d3;"</c:if>>${i.hobby}</td>
						<td
							<c:if test="${i.kbn==1}">style="background-color:#d3d3d3;"</c:if>>${i.name}</td>
						<td
							<c:if test="${i.kbn==1}">style="background-color:#d3d3d3;"</c:if>>${i.comp}</td>
						<c:set var="reg" value="${i.regdate }" />
						<td><fmt:formatDate value="${reg}" type="date" /></td>
						<td>${i.lv}</td>
						<td>
						${i.lv==1?'�ű�ȸ��':i.lv==2?'�Ϲ�ȸ��':i.lv==3?'���ȸ��':'������'}
						</td>
						<td>
							<c:if test="${i.apply==0}">
								<img src="../icon/icn_nonapply.png">
							</c:if>
							<c:if test="${i.apply==1}">
								<img src="../icon/icn_applied.png">
							</c:if>
							<c:if test="${i.apply==2}">
								<img src="../icon/icn_comp_apply.png">
							</c:if>
						
						
						</td>
						<td><a href="memberUpdateForm.do?id=${i.id}">����</a></td>
						<td><a href="deleteForm.do?id=${i.id}">����</a></td>
						<td>
						<table style="border:none;">
							<tr>
							<td style="border:none;">
							<form action="memberList.do" method="post" name="lvup">
								<input type="hidden" name="kbn" value="">
								<input type="hidden" name="apply" value="">
								<script>document.lvup.kbn.value = "${param.kbn}";
								document.lvup.apply.value = "${param.apply}";</script> 
								<input type="hidden" name="updnid" value="${i.id}">
								<input type="hidden" name="lvupsign" value="1">
							<input	type="submit" value="+">
							</form>
							</td>
							<td style="border:none;">
							<form action="memberList.do" method="post" name="lvdn">
								<input type="hidden" name="kbn" value="">
								<input type="hidden" name="apply" value="">
								<script>document.lvdn.kbn.value = "${param.kbn}";
								document.lvdn.apply.value = "${param.apply}";</script> 
								<input type="hidden" name="updnid" value="${i.id}">
								<input type="hidden" name="lvdnsign" value="1">
							<input	type="submit" value="-">
							</form>
							</td>
							</tr>
						</table>
						</td>
						<td>
							
							<input type="checkbox" name="lvupchk" value="${i.id}">
							
						</td>
					<tr>
				</c:forEach>
				<tr>
				<td colspan="17" style="text-align:right;"><button type="button" id="lvsubmit">���� ���</button></td>
				</tr>
			</table>
			
		</c:if>
		
		
	</div>
</body>
</html>