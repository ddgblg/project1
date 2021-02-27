<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
table{border:1px solid #cccccc; border-collapse: collapse;}
th, td{border-collapse: collapse; border-color: #cccccc; border-width: 1px; border-style:solid; padding:5px; }
</style>
</head>
<body>
<input type="text" id="address" value="�ּҸ� �Է��ϼ���">


<input type="text" value="" name="coordinate">


<input type="button" value="����" onclick="javascript:add()">





	<div id="map" style="width: 500px; height: 400px;">��Ȯ�� �ּҸ� �Է��Ͻð� '����'�� �����ø� ������ ǥ�õ˴ϴ�.
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
							content : '<div style="width:150px; text-align:center; padding:6px 0;"><div style="font-weight:bold;">�˻��Ͻ� ���</div></div>'
						});
						infowindow.open(map, marker);
						// ������ �߽��� ��������� ���� ��ġ�� �̵� 
						map.setCenter(coords);
					}
				});
				}
			</script>
		</div>
</body>
</html>