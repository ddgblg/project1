
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="../../css/css1.css">
<style>
body, h1, h2, h3, h4, h5 {	font-family: "Poppins", sans-serif}
body {	font-size: 16px;}
table {	width:100%;	border: 1px solid #cccccc;	border-collapse: collapse;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px; border-style: solid;	padding: 5px;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
</style>
<script>
	function deleteBoard(form){
		if(confirm("�����Ͻðڽ��ϱ�?") == true){
			form.submit();
		}else {
			return;
		}
	}
	
	function cancel(){
		if(confirm("�ۼ��� ����Ͻðڽ��ϱ�?") == true){
			document.deleteBoard.submit();	
		}else {
			return;
		}
	}
	function delcmt(){
		if(confirm("����� �����Ͻðڽ��ϱ�?")==true){
			document.deletecmt.submit();
		}else{
			return;
		}
	}
</script>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>��������_�Խñ��б�</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================���� ��======================================== -->

<table>
		<tr>
			<th style="width:10%">����</th>
			<td style="width:40%; text-align: left;">
				${b.area}
			</td>
			<th style="width:10%">�о�</th>
			<td style="width:40%; text-align: left;">
				${b.category}
			</td>
		</tr>
		<tr>
			<th style="width:10%">�ۼ���</th>
			<td colspan="3" style="width:40%; text-align: left;">${b.nickname}</td>
		</tr>
		
		
		<tr>
			<th>����</th>
			<td colspan="3" style="text-align:left; padding:10px;">${b.subject}</td>
		</tr>
		<tr>
			<th>����</th>
			<td colspan="3" style="text-align:left; vertical-align: top; boarder-width:0px; padding:10px; height:400px; overflow:auto; ">${b.content}</td>
		</tr>
		<tr>
			<th>���</th>
			<td colspan="3" style="text-align:left; font-weight:bold;">&nbsp;* �ּ� : ${b.coordinate}
			
				<input type="hidden" id="address" value="${b.coordinate}">
				<hr>
				
				<div id="map" style="width: 100%; height: 300px; display:flex; vertical-align: center; justify-content: center;" >*��Ȯ�� �ּҸ� �Է��Ͻð� '����'�� �����ø� ������ ǥ�õ˴ϴ�.*
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=111385628731c6fc006b2ef1412fc610&libraries=services"></script>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=111385628731c6fc006b2ef1412fc610"></script>
				<script>
					
					var addr = document.getElementById("address").value;
						
					var container = document.getElementById('map');
					var options = {// ������ ������ �� �ʿ��� �⺻ �ɼ�
						center : new kakao.maps.LatLng(37.56633094172112, 126.97792912074678), // ������ �߽���ǥ
						level : 3 // ������ ����(Ȯ��, ��� ����)
					};
					
					//������ �����մϴ�
					var map = new kakao.maps.Map(container, options);
					
					//�ּ�-��ǥ ��ȯ ��ü�� �������մϴ�.
					var geocoder = new kakao.maps.services.Geocoder();
					
					//�ּҷ� ��ǥ�� �˻��մϴ�.
					geocoder.addressSearch(addr, function(result, status) {
					
						// ���������� �˻��� �Ϸ������ 
						if (status === kakao.maps.services.Status.OK) {
							
							var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							
							// ��������� ���� ��ġ�� ��Ŀ�� ǥ�� 
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							});
							
							// ����������� ��ҿ� ���� ������ ǥ�� 
							var infowindow = new kakao.maps.InfoWindow({
								content : '<div style="width:150px; text-align:center; padding:6px 0;"><div style="font-weight:bold;">���</div></div>'
							});
							infowindow.open(map, marker);
							// ������ �߽��� ��������� ���� ��ġ�� �̵� 
							map.setCenter(coords);
						}
					});
					
				</script>
				</div>
			
			</td>
		</tr>
		<tr>
			<th>÷��<br>�̹�������</th>
			<td colspan="3" style="text-align:left">
				<c:if test="${empty b.imgfile}">
					&nbsp;
				</c:if>
				<c:if test="${!empty b.imgfile}"> 
					<a href="file/${b.imgfile}">${b.imgfile }</a>
				</c:if> 
			</td>
		</tr>
		<tr>
			<td colspan="4">
			<div style="display:flex; justify-content:center;">
			<table style="width:400px; height:100px; border:none;">
				<tr style="border:none;">
				<c:if test="${updateSign==1}">
				<td style="border:none;">
				<form action="updateFormI.do" method="post" name="updateI">
					<input type="hidden" name="btype" value="3">
					<input type="hidden" name="num" value="${b.num}">
					<input type="submit" value="�Խñ� ����"  style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#28768A; color:white; font-weight:bold; font-size:14px;">
				</form>
				</td>
				<td style="border:none;">
				<form action="deleteBoard.do" method="post" name="deleteBoard" onsubmit="return confirm('�����Ͻðڽ��ϱ�?');">
					<input type="hidden" name="btype" value="3">
					<input type="hidden" name="num" value="${b.num}">
					<input type="submit" value="�Խñ� ����" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#151889; color:white; font-weight:bold; font-size:14px;">
				</form>
				</td>
				</c:if>
				<td style="border:none;">
				<a href="listI.do?btype=3"><button style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">��Ϻ���</button></a>
				</td>
				</tr>
				
				</table>
			</div>
			</td>
		</tr>
		<tr>
			<th colspan="4">Comment ��</th>
		</tr>
		<tr>
			<form action="writeComment.do" name="comment" method="post" onsubmit="return confirm('����� ����Ͻðڽ��ϱ�?')">
			<th style="background-color:gray; color:white;">${mem.nickname}</th>
			<td colspan="3">
			<div style="display:flex; justify-content:right;">
					<input type="hidden" name="nickname" value="${mem.nickname}">
				<textarea rows="4" name="content" style="width:100%; height:100%; border:1px solid #dbdbdb"></textarea>
					<input type="hidden" name="id" value="${mem.id}">
					<input type="hidden" name="userLv" value="${mem.lv}">
					<input type="hidden" name="num" value="${b.num}">
					<input type="hidden" name="btype" value="${b.btype}">
				<input type="submit" value="��۵��" style="border: none; background-color:#b87ba0; color:white; font-weight:bold; font-size:14px;">
			</div>
			</td>
			
			</form>		
		</tr>
		<c:if test="${commentcnt==0}">  
			<tr><td colspan="6" style="font-size:14px; "><br>*��ϵ� ����� �����ϴ�.*<br> </td></tr>
		</c:if>
		<c:if test="${commentcnt!=0}">
		
			<c:forEach var="comm" items="${comm}">
				<tr>
					<th style="background-color:gray; color:white; font-size:14px;">${comm.nickname }</th>
					<td colspan="3">
						<table style="border: none;"">
							<tr style="border: none; ">
								<td style="width:80%; text-align:left; font-size: 14px; padding: 3px; border: none;">${comm.content}</td>
								<td style="width:20%; text-align:right; font-size: 14px; padding: 3px; border: none;">
								<c:if test="${login==comm.id || login=='admin'}">
								<form action="deletecmt.do" name="deletecmt" onsubmit="return confirm('����� �����Ͻðڽ��ϱ�?')">
									<input type="hidden" value="${comm.cnum}" name="cnum">
									<input type="hidden" value="${b.num}" name="num">
									<input type="image" name="submit" src="../icon/del_cmt.png" border="0">
								</form></td>
								<td style="width:20%; text-align:right; font-size: 14px; padding: 3px; border: none;"></c:if>
								
								<fmt:formatDate value="${comm.regdate}" pattern="yyyy/MM/dd"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</c:forEach>
		</c:if>
</table>
</div>
</body>
</html>