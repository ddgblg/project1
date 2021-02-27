<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%--
   
    culture/list.jsp
     
      --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 목록 보기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<style>
body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
body {font-size:16px;}
table{border:1px solid #cccccc; border-collapse: collapse;}
th, td{border-collapse: collapse; border-color: #cccccc; border-width: 1px; border-style:solid; padding:5px; }
.w3-half img{margin-bottom:-6px;margin-top:16px;opacity:0.8;cursor:pointer}
.w3-half img:hover{opacity:1}

</style>
<script type="text/javascript">
	function listdo(page){
		f = document.sf; // form 객체 자체.
		f.pageNum.value = page;
		f.submit();
	}
</script>
</head>
<body>
<div class="w3-container" style="margin-top:70px" id="showcase">
    <h1 class="w3-xxxlarge w3-text-red"><b>NOTICE</b></h1>
    <hr style="width:50px;border:5px solid red" class="w3-round">

<table>
	<c:if test="${boardcount==0}">  
		<tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
	</c:if>
	<c:if test="${boardcount!=0}">
	<tr>
			<td colspan="5" style="text-align:right">글개수:${boardcount}</td>
		</tr>
		<tr>
			<th width="8%">번호</th>
			<th width="50%">제목</th>
			<th width="14%">작성자</th>
			<th width="17%">등록일</th>
			<th width="11%">조회수</th>
		</tr>
			<c:forEach var="b" items="${list}">
			<tr>
				<%-- 가짜글번호 --%>
				<td>${boardnum} </td><c:set var="boardnum" value="${boardnum-1 }"/><%--빼고빼고--%>
			
				<td style="text-align:left">
			<%--답글의 level만큼 들여쓰기 --%>
			
			<c:if test="${b.grplevel > 0 }">
				<c:forEach var="i" begin="1" end="${b.grplevel}">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:forEach>
				└
			</c:if>
			
			
			<a href="info.do?num=${b.num}">${b.subject}</a><%--게시글 상세보기--%>
			</td>
			
			<td>${b.name}</td>
			<td>
			
			<%--오늘 등록된 게시물 날짜 format대로 출력하기 --%>
			  <fmt:formatDate var="rdate" value="${b.regdate}" pattern="yyyy-MM-dd" /><%--오늘날짜랑 비교하려고--%>
			<c:if test="${today == rdate}">
				<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss"/>
			</c:if>
			<c:if test="${today != rdate }">
				<fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd HH:mm"/>
			</c:if>
			
			</td>
			<td>${b.readcnt}</td>
		</tr>
			</c:forEach>
			
		<tr><td colspan="5"><%-- 페이지 처리하기 --%>
			<c:if test="${pageNum <= 1}">[이전]</c:if>
			<c:if test="${pageNum >1 }" ><a href="javascript:listdo(${ pageNum -1})">[이전]</a></c:if><!-- 검색 조건까지 넘겨주게끔 script를 거쳐서보냄. -->

			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a==pageNum }">[${a}]</c:if> <%--jstl은 else가 없다.ㅎㅎ --%>
				<c:if test="${a!=pageNum }"><a href="javascript:listdo(${a})">[${a }]</a></c:if>
			</c:forEach>	

			<c:if test="${pageNum >= maxpage }">[다음]</c:if>
			<c:if test="${pageNum < maxpage}"><a href="javascript:listdo(${pageNum + 1})">[다음]</a></c:if>
			
			</td>
		</tr>
		
		
	</c:if>
</table>
</div>
</body>
</html>