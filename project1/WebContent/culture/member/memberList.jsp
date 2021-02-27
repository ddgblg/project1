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
	var allchk = chk.checked // 전체 선택 값 (true/ false)
	//getElementsByName(name) : name 속성의 값이 "mailchk"인 태그 '들'
	// <input name="mailchk" ...>
	document.getElementsByName("lvupchk").forEach( // 배열.
	function(item, index) {
		// item : name="mailchk"인 태그 한 개.
		if (allchk) { // 전체선택값이 true인경우(선택된경우)
			item.setAttribute("checked", true); // item의 속성중에 checked라는 속성을 true로 만들어.
		} else {
			item.removeAttribute("checked"); // item속성중 checked속성을 없애버려.
		}
	})
}
$(function(){
	$("#lvsubmit").click(function(){
		var param = [];
		$("input[name='lvupchk']:checked").each(function(index,item){//체크된 리스트 저장
             param.push($(item).val());
        });
         
		 $.ajax({
			 url:"testlvup.do",
			 type:"post",
			 data: {param : param},
			 success: function(){alert("레벨업 완료"); console.log(param)},
			 error: function(){alert("레벨업 실패")}
		 })
	})
})


</script>
</head>
<body>
	<div class="w3-container" style="margin-top: 70px" id="showcase">

		<h1 class="w3-xxxlarge w3-text-red">
			<b>회원목록보기</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->


		<div style="display: flex; justify-content: left;">
			<form action="memberList.do" method="post" name="sf">
				회원구분 : &nbsp; 
				<select name="kbn">
					<option value="" >구분전체</option>
					<option value="1">일반회원</option>
					<option value="2">기관회원</option>
				</select>
				<script>document.sf.kbn.value = "${param.kbn}";</script> 
				&nbsp;등업구분 : &nbsp; 
				<select name="apply">
					<option value="">등업전체</option>
					<option value="1">등업신청자</option>
					<option value="0">등업미신청자</option>
				</select> &nbsp;&nbsp; 
				<script>document.sf.apply.value = "${param.apply}";</script>
				<input type="submit" value="검색">
			</form>
		</div>
		<hr>
		<c:set var="mlist" value="${list}" />
		<c:if test="${memcount ==0}">
			<h3>*검색결과 없음*</h3>
		</c:if>
		<c:if test="${memcount != 0}">
			<table>
				<tr>
					<th colspan="17" align="center">검색결과 ▼</th>
				</tr>
				<tr>
					<td colspan="17" align="left">검색결과 : ${memcount}건</td>
				</tr>
				<tr>
					<th>회원구분</th><th>아이디</th><th>닉네임</th><th>이메일</th>
					<th>거주지역</th><th>생년월일</th><th>선호문화활동</th>
					<th>성명</th><th>소속기관명</th><th>회원가입날짜</th>
					<th>회원레벨</th><th>회원단계</th><th>등업신청여부</th>
					<th></th><th></th><th>레벨수정</th><th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
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
						${i.lv==1?'신규회원':i.lv==2?'일반회원':i.lv==3?'기관회원':'관리자'}
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
						<td><a href="memberUpdateForm.do?id=${i.id}">수정</a></td>
						<td><a href="deleteForm.do?id=${i.id}">삭제</a></td>
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
				<td colspan="17" style="text-align:right;"><button type="button" id="lvsubmit">선택 등업</button></td>
				</tr>
			</table>
			
		</c:if>
		
		
	</div>
</body>
</html>