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
	function file_delete(){
		document.f.imgfile2.value=""; //name=file2의 hidden인풋의 값을 지워버림. (파일이 삭제되는게 아닌, 데이터 베이스로 넘어갈 값을 ""로 바꿔주는 것)
		file_desc.style.display="none"; // div태그가 보이지 않도록 설정함.
	}

</script>
</head>
<body>
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>정보나눔_게시글수정</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
<form action="updateBoard.do" method="post" enctype="multipart/form-data" name="f">
	<table>
		<tr><th colspan="4">게시물 쓰기</th></tr>
			<tr>
				<th style="width:10%">지역</th>
				<td style="width:40%; text-align: left;">
				<input type="hidden" name="btype" value="3">
				<input type="hidden" name="num" value="${b.num}">
				<input type="hidden" name="period_from" value="">
				<input type="hidden" name="period_to" value="">
				<input type="hidden" name="id" value="${id}">
				<input type="hidden" name="imgfile2" value="${b.imgfile}"><%-- 원래 내용을 잠깐 저장용 EL이므로 없으면 null됨.--%>
				
				<select name="area">
					<option value="">선택하세요</option>
					<option value="전국" <c:if test="${b.area=='전국'}">selected</c:if>>전국</option>
					<option value="서울" <c:if test="${b.area=='서울'}">selected</c:if>>서울</option>
					<option value="인천" <c:if test="${b.area=='인천'}">selected</c:if>>인천</option>
					<option value="세종" <c:if test="${b.area=='세종'}">selected</c:if>>세종</option>
					<option value="대구" <c:if test="${b.area=='대구'}">selected</c:if>>대구</option>
					<option value="부산" <c:if test="${b.area=='부산'}">selected</c:if>>부산</option>
					<option value="울산" <c:if test="${b.area=='울산'}">selected</c:if>>울산</option>
					<option value="대전" <c:if test="${b.area=='대전'}">selected</c:if>>대전</option>
					<option value="광주" <c:if test="${b.area=='광주'}">selected</c:if>>광주</option>
					<option value="경기" <c:if test="${b.area=='경기'}">selected</c:if>>경기</option>
					<option value="강원" <c:if test="${b.area=='강원'}">selected</c:if>>강원</option>
					<option value="충북" <c:if test="${b.area=='충북'}">selected</c:if>>충북</option>
					<option value="충남" <c:if test="${b.area=='충남'}">selected</c:if>>충남</option>
					<option value="경북" <c:if test="${b.area=='경북'}">selected</c:if>>경북</option>
					<option value="경남" <c:if test="${b.area=='경남'}">selected</c:if>>경남</option>
					<option value="전북" <c:if test="${b.area=='전북'}">selected</c:if>>전북</option>
					<option value="전남" <c:if test="${b.area=='전남'}">selected</c:if>>전남</option>
					<option value="제주" <c:if test="${b.area=='제주'}">selected</c:if>>제주</option>
				</select>
				</td>
				<th style="width:10%">분야</th>
				<td style="width:40%; text-align: left;">
				<select name="category">
					<option value="">선택하세요</option>
					<option value="공연" <c:if test="${b.category=='공연'}">selected</c:if>>공연</option>
					<option value="관광" <c:if test="${b.category=='관광'}">selected</c:if>>관광</option>
					<option value="문화공간" <c:if test="${b.category=='문화공간'}">selected</c:if>>문화공간</option>
					<option value="문화재" <c:if test="${b.category=='문화재'}">selected</c:if>>문화재</option>
					<option value="전시" <c:if test="${b.category=='전시'}">selected</c:if>>전시</option>
					<option value="축제" <c:if test="${b.category=='축제'}">selected</c:if>>축제</option>
					<option value="행사" <c:if test="${b.category=='행사'}">selected</c:if>>행사</option>
					<option value="기타" <c:if test="${b.category=='기타'}">selected</c:if>>기타</option>
				</select>
				</td>
			</tr>
			<tr>
				<th style="width:10%">작성자</th>
				<td colspan="3" style="text-align: left;">${b.nickname}</td>
			</tr>
			<tr>
				<th>제목</th><td colspan="3"><input type="text" name="subject" style="width:100%" value="${b.subject}"></td>
			</tr>
			<tr>
				<th>내용</th><td colspan="3"><textarea rows="15" name="content" id="content1" style="width:100%; height:100%;">${b.content}</textarea></td>
			</tr>
			<script>CKEDITOR.replace("content1",{
				filebrowserImageUploadUrl:"imgupload.do"
			})</script>
			<tr>
				<th>장소</th>
				<td colspan="3" style="text-align: left;">
				
				<input type="text" id="address" value="${b.coordinate}" style="width:500px;">
				<input type="button" value="적용" onclick="javascript:add()" style="font-size:14px; font-weight:bold; width:60px; height:26px; border:none; border-radius:5px; background-color:#415588; color:white;"> 
				<br><font style="font-size:14px; font-weight:bold; color:gray;">&nbsp;&nbsp;*주소를 변경하시려면 새 주소 입력 후 적용 클릭*</font>
				<input type="hidden" value="${b.coordinate}" name="coordinate">
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
				<td colspan="3" style="text-align: left;">

					<c:if test="${!empty b.imgfile}">
						<div id="file_desc">${b.imgfile}
						<a href="javascript:file_delete()">
						<font style="font-size:14px; font-weight:bold;">[첨부파일삭제]</font>
						</a><%--실제 파일은 삭제되는게 아니다. --%>
						</div>
					</c:if>
					<input type="file" name="imgfile">
				
				
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<button type="button" onclick="inputcheck();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">게시물수정</button>
					<button type="button" onclick="cancel();" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#5b5193; color:white; font-weight:bold; font-size:14px;">뒤로가기</button>
			</tr>
	</table>
</form>
</div>
</body>
</html>