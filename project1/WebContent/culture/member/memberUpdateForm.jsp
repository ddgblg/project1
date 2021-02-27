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
			alert("비밀번호를 입력하세요");
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
			<b>회원정보수정</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->
	<form action="update.do" name="f" method="post" onsubmit="return inputcheck(this)">
		<table>
		<tr>
			<th colspan="2" align="center">회원정보수정</th>
		</tr>
		<!--          회원공통정보                       -->
		<tr>
			<th>회원구분</th>
			<td>
				<c:if test="${mem.kbn ==1 }"><!-- 일반회원 -->
    				<img src="../icon/icn_gen.png">
    			</c:if>
    			<c:if test="${mem.kbn ==2 }"><!-- 기관회원 -->
    				<img src="../icon/icn_ins.png">
    			</c:if>
    			<c:if test="${mem.kbn ==3 }"><!-- 관리자 -->
    				<img src="../icon/icn_admin.png">
    			</c:if>
			</td>
		</tr>
		
		<tr>
			<th>
				레벨
			</th>
			<td>
				<c:if test="${mem.lv ==1 }">
    				Lv 1 (신규회원)
    			</c:if>
    			<c:if test="${mem.lv ==2 }">
    				Lv 2 (일반회원)
    			</c:if>
    			<c:if test="${mem.lv ==3 }">
    				Lv 3 (기관회원)
    			</c:if>
    			<c:if test="${mem.lv ==4 }">
    				Lv 4 (관리자)
    			</c:if>
			</td>
		</tr>
		
		<tr>
			<th width="20%">아이디</th>
			<td>
				${mem.id }
				<input type="hidden" name="id" value="${mem.id}">
			</td>
		</tr>
		
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nickname" value="${mem.nickname}"></td> 
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" value="${mem.email}"></td>
		</tr>
		
		<!--          일반 / 기관                       -->
		<tr>
			<c:if test="${mem.kbn ==1 || mem.kbn ==3}">
				<th>거주지역</th>
				<td>
				<select name="area">
					<option value="서울" <c:if test="${mem.area =='서울' }">selected</c:if>>서울</option>
					<option value="인천" <c:if test="${mem.area =='인천' }">selected</c:if>>인천</option>
					<option value="세종" <c:if test="${mem.area =='세종' }">selected</c:if>>세종</option>
					<option value="대구" <c:if test="${mem.area =='대구' }">selected</c:if>>대구</option>
					<option value="부산" <c:if test="${mem.area =='부산' }">selected</c:if>>부산</option>
					<option value="울산" <c:if test="${mem.area =='울산' }">selected</c:if>>울산</option>
					<option value="대전" <c:if test="${mem.area =='대전' }">selected</c:if>>대전</option>
					<option value="광주" <c:if test="${mem.area =='광주' }">selected</c:if>>광주</option>
					<option value="경기" <c:if test="${mem.area =='경기' }">selected</c:if>>경기</option>
					<option value="강원" <c:if test="${mem.area =='강원' }">selected</c:if>>강원</option>
					<option value="충북" <c:if test="${mem.area =='충북' }">selected</c:if>>충북</option>
					<option value="충남" <c:if test="${mem.area =='충남' }">selected</c:if>>충남</option>
					<option value="경북" <c:if test="${mem.area =='경북' }">selected</c:if>>경북</option>
					<option value="경남" <c:if test="${mem.area =='경남' }">selected</c:if>>경남</option>
					<option value="전북" <c:if test="${mem.area =='전북' }">selected</c:if>>전북</option>
					<option value="전남" <c:if test="${mem.area =='전남' }">selected</c:if>>전남</option>
					<option value="제주" <c:if test="${mem.area =='제주' }">selected</c:if>>제주</option>
				</select>
				</td>
			</c:if>
			<c:if test="${mem.kbn ==2 || mem.kbn==3}">
				<c:if test="${mem.kbn==3}"><tr></c:if>
				<th>성명</th>
				<td><input type="text" name="name" value="${mem.name}"></td>
				<c:if test="${mem.kbn==3}"></tr></c:if>
			</c:if>
		</tr>
		<tr>
			<c:if test="${mem.kbn ==1 || mem.kbn==3 }">
				<th>생년월일</th>
				<td>
					<c:set var="birth" value="${mem.birth} }"/>
					<c:set var="arr" value="${fn:split(birth, '/')}"/>
					<select name="birth_yyyy">
						<c:forEach var="year" begin="1900" end="2020" step="1">
							<option <c:if test="${year == arr[0]}">selected</c:if>>${year}</option>
						</c:forEach>
					</select>년
					
					<select name="birth_mm">
						<c:forEach var="month" begin="1" end="12" step="1">
							<option <c:if test="${month == arr[1]}">selected</c:if>>${month}</option>
						</c:forEach>
					</select>월
			<!-- ============================== 오류가능성 있음 ↓=================================-->
					<c:set var="d1" value="${fn:substring(arr[2],0,2)}"/>
					<c:set var="d2" value="${fn:trim(d1)}"/> 
					<select name="birth_dd">
						<c:forEach var="day" begin="1" end="31" step="1">
							<option <c:if test="${day == d2}">selected</c:if>>${day}</option>
						</c:forEach>
					</select>일
			<!-- ===============================오류가능성 있음 ↑=================================--> 
				</td>
			</c:if>
			<c:if test="${mem.kbn ==2 || mem.kbn==3}">
				<c:if test="${mem.kbn==3}"><tr></c:if>
				<th>소속기관</th>
				<td><input type="text" name="comp" value="${mem.comp}"></td>
				<c:if test="${mem.kbn==3}"></tr></c:if>
			</c:if>
		</tr>
	<c:if test="${mem.kbn ==1|| mem.kbn==3 }">
		<tr>
			<th>선호하는 문화활동</th>
			<td><input type="text" name="hobby" value="${mem.hobby}"></td>
		</tr>
	</c:if>
		<tr>
			<th>비밀번호입력</th><td><input type="password" name="pass"></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				
				<c:if test="${sessionScope.login != 'admin' || param.id == 'admin'}">
					<input type="hidden" name="updatepage" value="" >
				</c:if>
				<c:if test="${sessionScope.login == 'admin' || param.id != 'admin'}">
					<input type="hidden" name="updatepage" value="1" >
				</c:if>
				
				<input type="submit" value="수정완료" style="border:none; border-radius:15px; color:white; background-color:#4b8593; font-size:14px; font-weight:bold; width:130px; height:30px;">
				<c:if test="${sessionScope.login != 'admin' || param.id == 'admin'}">
					<input type="button" value="비밀번호수정" onclick="win_passchg()"  style="border:none; border-radius:15px; color:white; background-color:#aa8923; font-size:14px; font-weight:bold; width:130px; height:30px;">
				</c:if>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
