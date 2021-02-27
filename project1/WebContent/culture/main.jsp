<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins">

<style>
body, h1, h2, h3, h4, h5 {font-family: "Poppins", sans-serif}
body {	font-size: 16px;}
table {	width: 100%;	border: 1px solid #cccccc;	border-collapse: collapse;}
th, td {	border-collapse: collapse;	border-color: #cccccc;	border-width: 1px;	border-style: solid;	padding: 5px;}
.w3-half img {	margin-bottom: -6px;	margin-top: 16px;	opacity: 0.8;	cursor: pointer}
.w3-half img:hover {	opacity: 1}
.bimg{width: 100%; border-radius: 8px;}
li:hover{background-color:#dddddd;}
.noticel:hover{background-color:#f9f9f9;}
</style>
</head>
<body>
	<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>NOTICE</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->

		<table style="width: 100%; border-left: none; border-right: none;">
			<tr>
				<th style="width: 80%; color:#333333; background-color:#ECF0F1; border-left: none; border-right:none;">제목</th>
				<th style="width: 10%; color:#333333; background-color:#ECF0F1; border-left: none; border-right:none;">작성자</th>
				<th style="width: 10%; color:#333333; background-color:#ECF0F1;  border-left: none; border-right: none;">조회수</th>
			</tr>
			</tr>

			<c:forEach var="notice" items="${notice}">
				<tr class="noticel">
					<c:set var="boardnum" value="${boardnum-1 }" />

					<%--게시글 상세보기--%>
					<td style="text-align: left; border-left: none; border-right: none;">
					 
					<a href="board/infoN.do?num=${notice.num}&btype=1" style="text-decoration: none; font-size: 15px; font-weight:bold;">
					&nbsp;<img src="icon/board_list.png">&nbsp;${notice.subject} </a>
					<fmt:formatDate var="ndate" value="${notice.regdate}" pattern="yyyy-MM-dd" />
					<c:if test="${today == ndate}">
						<img src="icn_new.png">
					</c:if> 
					</td>
					<td align="center" style=" border-left: none; border-right: none;">${notice.nickname}</td>
					<td align="center" style=" border-left: none; border-right: none;">${notice.readcnt}</td>
				</tr>
			</c:forEach>
		</table>
		<!-- //공지사항 끝 -->

		<!-- 최근게시물 시작 -->
		<br> <br>
		<h1 class="w3-xxxlarge w3-text-red">
			<b>RECENT</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">

		<div class="w3-row-padding">
			<div class="w3-half w3-margin-bottom">
				<ul class="w3-ul w3-light-grey w3-center">
					<li class="w3-dark-grey w3-xlarge w3-padding-32" style="font-weight: bold;">지역문화탐색</li>
					<c:forEach var="culture" items="${culture}">
						<li class="w3-padding-5" style="text-align: left; padding: 1px;">
							<table style="width: 100%; height: 100px; border:none; font-size: 15px;">
								<tr>
									<td style="width: 20%; height: 100; border:none; font-size: 15px; text-align: center; vertical-align: top;">
									
										<c:if test="${culture.imgfile!=null}">
			  								<a href="board/file/${culture.imgfile}"><img src="board/file/${culture.imgfile}" class="bimg"></a>
			  							</c:if>
										<c:if test="${culture.imgfile==null}">
			  								<img src="icon/noimage.jpg" class="bimg">
			  							</c:if>
			  							
									</td>
									
									<td style="width: 60%; height: 100; border: none; font-size: 15px; font-weight: bold; text-align: left;">
										<c:if test="${culture.area != ''}">[${culture.area}] </c:if>
			  							<c:if test="${culture.category != ''}">[${culture.category}] </c:if>
										<a href="board/infoC.do?num=${culture.num}&btype=2" style="text-decoration: none;">
										 &nbsp;${culture.subject} 
										</a>
										<fmt:formatDate var="cdate" value="${culture.regdate}" pattern="yyyy-MM-dd" /> 
										<c:if test="${today == cdate}">
											&nbsp;&nbsp;<img src="icon/icn_new.png">
										</c:if>
									</td>
									<td style="width: 20%; height: 100; border: none; text-align: center; font-size: 15px; text-align: center;">
										${culture.comp}</td>
								</tr>
							</table>
						</li>
					</c:forEach>
				</ul>
			</div>

			<div class="w3-half">
				<ul class="w3-ul w3-light-grey w3-center">
					<li class="w3-red w3-xlarge w3-padding-32"
						style="font-weight: bold;">정보나눔</li>
					<c:forEach var="information" items="${information}">
						<li class="w3-padding-5" style="text-align: left; padding: 1px;">
							<table style="width: 100%; height: 100px; border: none; font-size: 15px;">
								<tr>
									<td style="width: 20%; height: 100; border: none; font-size: 15px; text-align: center;">
										<c:if test="${information.imgfile!=null}">
			  								<a href="board/file/${information.imgfile}"><img src="board/file/${information.imgfile}"  class="bimg"></a>
			  							</c:if>
										<c:if test="${information.imgfile==null}">
			  								<img src="icon/noimage.jpg"  class="bimg">
			  							</c:if>
									</td>
									<td style="width: 60%; height: 100; border: none; font-size: 15px; font-weight: bold; text-align: left;">
										<c:if test="${information.area != ''}">[${information.area}] </c:if>
			  							<c:if test="${information.category != ''}">[${information.category}] </c:if>
										<a href="board/infoI.do?num=${information.num}&btype=3"
										style="text-decoration: none;">
											&nbsp;${information.subject} </a> 
											<fmt:formatDate var="idate"	value="${information.regdate}" pattern="yyyy-MM-dd" />
											 <c:if test="${today == idate}">
												&nbsp;&nbsp;<img src="icon/icn_new.png">
											</c:if>
									</td>
									<td style="width: 20%; height: 100; border: none; text-align: center; font-size: 15px; text-align: center;">
										${information.nickname}</td>
								</tr>
							</table>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<br> <br>
		<!-- ============================내용 끝======================================= -->
	</div>
</body>
</html>