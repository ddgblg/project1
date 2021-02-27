
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
		if(confirm("삭제하시겠습니까?") == true){
			form.submit();
		}else {
			return;
		}
	}
	
	function cancel(){
		if(confirm("작성을 취소하시겠습니까?") == true){
			document.deleteBoard.submit();	
		}else {
			return;
		}
	}
	function delcmt(){
		if(confirm("댓글을 삭제하시겠습니까?")==true){
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
			<b>정보나눔_게시글읽기</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->

<table>
		<tr>
			<th style="width:10%">지역</th>
			<td style="width:40%; text-align: left;">
				${b.area}
			</td>
			<th style="width:10%">분야</th>
			<td style="width:40%; text-align: left;">
				${b.category}
			</td>
		</tr>
		<tr>
			<th style="width:10%">작성자</th>
			<td colspan="3" style="width:40%; text-align: left;">${b.nickname}</td>
		</tr>
		
		
		<tr>
			<th>제목</th>
			<td colspan="3" style="text-align:left; padding:10px;">${b.subject}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3" style="text-align:left; vertical-align: top; boarder-width:0px; padding:10px; height:400px; overflow:auto; ">${b.content}</td>
		</tr>
		<tr>
			<th>장소</th>
			<td colspan="3" style="text-align:left; font-weight:bold;">&nbsp;* 주소 : ${b.coordinate}
			
				<input type="hidden" id="address" value="${b.coordinate}">
				<hr>
				
				<div id="map" style="width: 100%; height: 300px; display:flex; vertical-align: center; justify-content: center;" >*정확한 주소를 입력하시고 '적용'을 누르시면 지도가 표시됩니다.*
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=111385628731c6fc006b2ef1412fc610&libraries=services"></script>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=111385628731c6fc006b2ef1412fc610"></script>
				<script>
					
					var addr = document.getElementById("address").value;
						
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
					geocoder.addressSearch(addr, function(result, status) {
					
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
					
				</script>
				</div>
			
			</td>
		</tr>
		<tr>
			<th>첨부<br>이미지파일</th>
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
					<input type="submit" value="게시글 수정"  style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#28768A; color:white; font-weight:bold; font-size:14px;">
				</form>
				</td>
				<td style="border:none;">
				<form action="deleteBoard.do" method="post" name="deleteBoard" onsubmit="return confirm('삭제하시겠습니까?');">
					<input type="hidden" name="btype" value="3">
					<input type="hidden" name="num" value="${b.num}">
					<input type="submit" value="게시글 삭제" style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#151889; color:white; font-weight:bold; font-size:14px;">
				</form>
				</td>
				</c:if>
				<td style="border:none;">
				<a href="listI.do?btype=3"><button style="border: none; border-radius: 20px; width:120px; height:30px; background-color:#6b3255; color:white; font-weight:bold; font-size:14px;">목록보기</button></a>
				</td>
				</tr>
				
				</table>
			</div>
			</td>
		</tr>
		<tr>
			<th colspan="4">Comment ▼</th>
		</tr>
		<tr>
			<form action="writeComment.do" name="comment" method="post" onsubmit="return confirm('댓글을 등록하시겠습니까?')">
			<th style="background-color:gray; color:white;">${mem.nickname}</th>
			<td colspan="3">
			<div style="display:flex; justify-content:right;">
					<input type="hidden" name="nickname" value="${mem.nickname}">
				<textarea rows="4" name="content" style="width:100%; height:100%; border:1px solid #dbdbdb"></textarea>
					<input type="hidden" name="id" value="${mem.id}">
					<input type="hidden" name="userLv" value="${mem.lv}">
					<input type="hidden" name="num" value="${b.num}">
					<input type="hidden" name="btype" value="${b.btype}">
				<input type="submit" value="댓글등록" style="border: none; background-color:#b87ba0; color:white; font-weight:bold; font-size:14px;">
			</div>
			</td>
			
			</form>		
		</tr>
		<c:if test="${commentcnt==0}">  
			<tr><td colspan="6" style="font-size:14px; "><br>*등록된 댓글이 없습니다.*<br> </td></tr>
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
								<form action="deletecmt.do" name="deletecmt" onsubmit="return confirm('댓글을 삭제하시겠습니까?')">
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