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
<input type="text" id="address" value="주소를 입력하세요">


<input type="text" value="" name="coordinate">


<input type="button" value="적용" onclick="javascript:add()">





	<div id="map" style="width: 500px; height: 400px;">정확한 주소를 입력하시고 '적용'을 누르시면 지도가 표시됩니다.
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
				var options = {// 지도를 생성할 때 필요한 기본 옵션
					center : new kakao.maps.LatLng(37.56633094172112, 126.97792912074678), // 지도의 중심좌표
					level : 3 // 지도의 레벨(확대, 축소 정도)
				};
				
				//지도를 생성합니다
				var map = new kakao.maps.Map(container, options);
				
				//주소-좌표 변환 객체를 생ㅇ성합니다.
				var geocoder = new kakao.maps.services.Geocoder();
				
				//주소로 좌표를 검색합니다.
				geocoder.addressSearch(addre, function(result, status) {
				
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						
						// 결과값으로 받은 위치를 마커로 표시 
						var marker = new kakao.maps.Marker({
							map : map,
							position : coords
						});
						
						// 인포윈도우로 장소에 대한 설명을 표시 
						var infowindow = new kakao.maps.InfoWindow({
							content : '<div style="width:150px; text-align:center; padding:6px 0;"><div style="font-weight:bold;">검색하신 장소</div></div>'
						});
						infowindow.open(map, marker);
						// 지도의 중심을 결과값으로 받은 위치로 이동 
						map.setCenter(coords);
					}
				});
				}
			</script>
		</div>
</body>
</html>