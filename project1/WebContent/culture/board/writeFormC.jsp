<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%--/WebContent/model2/board/writeForm.jsp --%>
    
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
input{border:1px solid #dbdbdb; font-size:14px;}
select{border:1px solid #dbdbdb; font-size:14px;}
</style>
<script>
	function inputcheck() {
		f = document.f;
		if(f.subject.value==""){
			alert("������ �Է��ϼ���");
			f.subject.focus();
			return;
		}
		f.submit();
	}
	function cancel(){
		if(confirm("�ۼ��� ����Ͻðڽ��ϱ�?") == true){
			history.go(-1);	
		}else {
			return;
		}
	}
</script>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>������ȭŽ��_�Խñ��ۼ�</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================���� ��======================================== -->
<form action="write.do" method="post" enctype="multipart/form-data" name="f">
	<table>
		<tr><th colspan="4">�Խù� ����</th></tr>
			<tr>
				<th style="width:10%">����</th>
				<td style="width:40%; text-align: left;">
				<input type="hidden" name="btype" value="2">
				<input type="hidden" name="id" value="${id}">
				<select name="area">
					<option value="">�����ϼ���</option>
					<option value="����">����</option>
					<option value="����">����</option><option value="��õ">��õ</option>
					<option value="����">����</option><option value="�뱸">�뱸</option>
					<option value="�λ�">�λ�</option><option value="���">���</option>
					<option value="����">����</option><option value="����">����</option>
					<option value="���">���</option><option value="����">����</option>
					<option value="���">���</option><option value="�泲">�泲</option>
					<option value="���">���</option><option value="�泲">�泲</option>
					<option value="����">����</option><option value="����">����</option>
					<option value="����">����</option>
				</select>
				</td>
				<th style="width:10%">�о�</th>
				<td style="width:40%; text-align: left;">
				<select name="category">
					<option value="">�����ϼ���</option><option value="����">����</option>
					<option value="����">����</option><option value="��ȭ����">��ȭ����</option>
					<option value="��ȭ��">��ȭ��</option><option value="����">����</option>
					<option value="����">����</option><option value="���">���</option>
					<option value="��Ÿ">��Ÿ</option>
				</select>
				</td>
			</tr>
			<tr>
				<th style="width:10%">�Ⱓ</th>
				<td style="width:40%; text-align: left;">
					<input type="date" name="period_from"> ~ <input type="date" name="period_to">
				</td>
				<th style="width:10%">�ۼ����</th>
				<td style="width:40%; text-align: left;">${comp}</td>
			</tr>
			<tr>
				<th>����</th><td colspan="3"><input type="text" name="subject" style="width:100%"></td>
			</tr>
			<tr>
				<th>����</th><td colspan="3"><textarea rows="15" name="content" id="content1" style="width:100%; height:100%;"></textarea></td>
			</tr>
			<script>CKEDITOR.replace("content1",{
				filebrowserImageUploadUrl:"imgupload.do"
			})</script>
			<tr>
				<th>���</th>
				<td colspan="3" style="text-align: left;">
				
				<input type="text" id="address" value="�ּҸ� �Է��ϼ���"  style="width:500px;">
				<input type="button" value="����" onclick="javascript:add()"  style="font-size:14px; font-weight:bold; width:60px; height:26px; border:none; border-radius:5px; background-color:#415588; color:white;">
				<input type="hidden" value="" name="coordinate">
				<hr>
				
				<div id="map" style="width: 100%; height: 300px; display:flex; vertical-align: center; justify-content: center;" >*��Ȯ�� �ּҸ� �Է��Ͻð� '����'�� �����ø� ������ ǥ�õ˴ϴ�.*
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=111385628731c6fc006b2ef1412fc610&libraries=services"></script>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=111385628731c6fc006b2ef1412fc610"></script>
				<script>
					function add(){
						var addr = document.getElementById("address").value;
						var coord = document.getElementsByName("coordinate")[0];
						coord.value=addr;
						
						showMap(addr);
					}	
				
					function showMap(addre){
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
					geocoder.addressSearch(addre, function(result, status) {
					
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
					}
				</script>
				</div>
				</td>
			</tr>
			<tr>
				<th>�����<br>�̹���<br>���ε�</th>
				<td colspan="3" style="text-align: left;"><input type="file" name="imgfile"></td>
			</tr>
			<tr>
				<td colspan="4">
					<button type="button" onclick="inputcheck();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">�Խù����</button>
					<button type="button" onclick="cancel();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#5b5193; color:white; font-weight:bold; font-size:14px;">�ڷΰ���</button>
			</tr>
	</table>
</form>
</div>
</body>
</html>