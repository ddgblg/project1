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
			alert("제목을 입력하세요");
			f.subject.focus();
			return;
		}
		f.submit();
	}
	function cancel(){
		if(confirm("작성을 취소하시겠습니까?") == true){
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
			<b>지역문화탐색_게시글작성</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
<form action="write.do" method="post" enctype="multipart/form-data" name="f">
	<table>
		<tr><th colspan="4">게시물 쓰기</th></tr>
			<tr>
				<th style="width:10%">지역</th>
				<td style="width:40%; text-align: left;">
				<input type="hidden" name="btype" value="2">
				<input type="hidden" name="id" value="${id}">
				<select name="area">
					<option value="">선택하세요</option>
					<option value="전국">전국</option>
					<option value="서울">서울</option><option value="인천">인천</option>
					<option value="세종">세종</option><option value="대구">대구</option>
					<option value="부산">부산</option><option value="울산">울산</option>
					<option value="대전">대전</option><option value="광주">광주</option>
					<option value="경기">경기</option><option value="강원">강원</option>
					<option value="충북">충북</option><option value="충남">충남</option>
					<option value="경북">경북</option><option value="경남">경남</option>
					<option value="전북">전북</option><option value="전남">전남</option>
					<option value="제주">제주</option>
				</select>
				</td>
				<th style="width:10%">분야</th>
				<td style="width:40%; text-align: left;">
				<select name="category">
					<option value="">선택하세요</option><option value="공연">공연</option>
					<option value="관광">관광</option><option value="문화공간">문화공간</option>
					<option value="문화재">문화재</option><option value="전시">전시</option>
					<option value="축제">축제</option><option value="행사">행사</option>
					<option value="기타">기타</option>
				</select>
				</td>
			</tr>
			<tr>
				<th style="width:10%">기간</th>
				<td style="width:40%; text-align: left;">
					<input type="date" name="period_from"> ~ <input type="date" name="period_to">
				</td>
				<th style="width:10%">작성기관</th>
				<td style="width:40%; text-align: left;">${comp}</td>
			</tr>
			<tr>
				<th>제목</th><td colspan="3"><input type="text" name="subject" style="width:100%"></td>
			</tr>
			<tr>
				<th>내용</th><td colspan="3"><textarea rows="15" name="content" id="content1" style="width:100%; height:100%;"></textarea></td>
			</tr>
			<script>CKEDITOR.replace("content1",{
				filebrowserImageUploadUrl:"imgupload.do"
			})</script>
			<tr>
				<th>장소</th>
				<td colspan="3" style="text-align: left;">
				
				<input type="text" id="address" value="주소를 입력하세요"  style="width:500px;">
				<input type="button" value="적용" onclick="javascript:add()"  style="font-size:14px; font-weight:bold; width:60px; height:26px; border:none; border-radius:5px; background-color:#415588; color:white;">
				<input type="hidden" value="" name="coordinate">
				<hr>
				
				<div id="map" style="width: 100%; height: 300px; display:flex; vertical-align: center; justify-content: center;" >*정확한 주소를 입력하시고 '적용'을 누르시면 지도가 표시됩니다.*
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
								content : '<div style="width:150px; text-align:center; padding:6px 0;"><div style="font-weight:bold;">장소</div></div>'
							});
							infowindow.open(map, marker);
							// 지도의 중심을 결과값으로 받은 위치로 이동 
							map.setCenter(coords);
						}
					});
					}
				</script>
				</div>
				</td>
			</tr>
			<tr>
				<th>썸네일<br>이미지<br>업로드</th>
				<td colspan="3" style="text-align: left;"><input type="file" name="imgfile"></td>
			</tr>
			<tr>
				<td colspan="4">
					<button type="button" onclick="inputcheck();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">게시물등록</button>
					<button type="button" onclick="cancel();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#5b5193; color:white; font-weight:bold; font-size:14px;">뒤로가기</button>
			</tr>
	</table>
</form>
</div>
</body>
</html>