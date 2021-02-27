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

#bar {
justify-content:center;
width: 300px; 
height:30px; 
background-color:#604660; 
color:white; 
text-align:center; 
font-weight:bold; 
font-size:15px; 
vertical-align: center; 
line-height: 30px;
border-radius: 20px;
}
#bar_out{display:flex; height:80px; align-items:center;}
input{border:1px solid #dbdbdb; font-size:14px;}
select{border:1px solid #dbdbdb; font-size:14px;}
td{height:50px;}
.listb:hover{background-color:#f8f8f8;}
.tdbottom{border:none;}
table{border:none;}
.favth{background-color:#3E6D42; border:none;}
td{border-top:none; border-left:none;border-right:none;}
.listth{background-color:#604660; border:none;}
.bimg{width: 150px; border-radius: 8px;}
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
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>정보나눔</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<!-- ===========================내용 ↓======================================== -->

<div id="bar_out">
	<div id="bar" style="background-color:#3E6D42">
		<c:set var="today1" value="<%=new java.util.Date() %>"/>
		<fmt:formatDate value="${today1}" pattern="MM월"/>의 인기게시물
	</div>
</div>
<table>
<c:if test="${boardcount==0}">  
	<tr><td colspan="6">등록된 게시글이 없습니다.</td></tr>
</c:if>
<c:if test="${boardcount!=0}">

	<tr>
		<th width="5%" class="favth" style=" border-bottom-left-radius: 20px;border-top-left-radius: 20px;">번호</th>
		<th width="15%" class="favth">이미지</th>
		<th width="50%" class="favth">제목</th>
		<th width="10%" class="favth">작성자</th>
		<th width="10%" class="favth">작성일</th>
		<th width="5%" class="favth">조회수</th>
		<th width="5%" class="favth" style=" border-bottom-right-radius: 20px;border-top-right-radius: 20px;">댓글 수</th>
	</tr>
	<%int i = 2; %>
	<c:forEach var="fav" items="${favlist}">
	<tr class="listb">
		<td><%=i-- %></td>
		<td>
			<c:if test="${fav.imgfile!=null}">
				<a href="file/${fav.imgfile}"><img src="file/${fav.imgfile}" class="bimg"></a>
			</c:if>
			<c:if test="${fav.imgfile==null}">
				<img src="../icon/noimage.jpg" class="bimg">
			</c:if>
		
		</td>
		<td style="text-align:left;">[${fav.area}][${fav.category}]&nbsp;<a href="infoI.do?num=${fav.num}&btype=3">${fav.subject}</a>
		
		<fmt:formatDate var="fdate"	value="${fav.regdate}" pattern="yyyy-MM-dd" />
			<c:if test="${today == fdate}">
				&nbsp;&nbsp;<img src="../icon/icn_new.png">
			</c:if>
		</td>
		<td>${fav.nickname}</td>
		<td>
		<c:if test="${today == rdate}">
			<fmt:formatDate value="${fav.regdate}" pattern="HH:mm:ss"/>
		</c:if>
		<c:if test="${today != rdate }">
			<fmt:formatDate value="${fav.regdate}" pattern="yyyy-MM-dd HH:mm"/>
		</c:if>
		</td>
		<td>${fav.readcnt}</td>
		<td>${fav.commentcnt}</td>
	</tr>
	</c:forEach>
</c:if>
</table>
<br><br>
<div id="bar_out">
	<div id="bar">
		게시물 목록
	</div>
</div>
<table>
	<c:if test="${boardcount==0}">  
		<tr><td colspan="6">등록된 게시글이 없습니다.</td></tr>
	</c:if>
	<c:if test="${boardcount!=0}">
		
		<tr>
			<th width="5%" class="listth" style=" border-bottom-left-radius: 20px;border-top-left-radius: 20px;">번호</th>
			<th width="15%" class="listth" >이미지</th>
			<th width="50%" class="listth" >제목</th>
			<th width="10%" class="listth" >작성자</th>
			<th width="10%" class="listth" >작성일</th>
			<th width="5%" class="listth" >조회수</th>
			<th width="5%" class="listth" style=" border-bottom-right-radius: 20px;border-top-right-radius: 20px;">댓글 수</th>
		</tr>
			<c:forEach var="b" items="${list}">
			<tr class="listb">
				<%-- 가짜글번호 --%>
				<td>${boardnum} </td><c:set var="boardnum" value="${boardnum-1 }"/><%--빼고빼고--%>
			
				<td>
			  	<%--첨부파일 표시 --%>
				<c:if test="${b.imgfile!=null}">
			  		<a href="file/${b.imgfile}"><img src="file/${b.imgfile}" class="bimg"></a>
			  	</c:if>
			  	<c:if test="${b.imgfile==null}">
			  		<img src="../icon/noimage.jpg" class="bimg">
			  	</c:if>
				</td>
				
				<td style="text-align:left;">
				<%--게시글 상세보기 --%>
				<c:if test="${b.area != ''}">[${b.area}] </c:if>
			  	<c:if test="${b.category != ''}">[${b.category}] </c:if>
			  	&nbsp;<a href="infoI.do?num=${b.num}&btype=3">${b.subject}</a>
				<fmt:formatDate var="bdate"	value="${b.regdate}" pattern="yyyy-MM-dd" />
					<c:if test="${today == bdate}">
						&nbsp;&nbsp;<img src="../icon/icn_new.png">
					</c:if>
				</td>
				<td>${b.nickname}</td>
				<td>
			
			<%--오늘 등록된 게시물 날짜 format대로 출력하기 --%>
				<fmt:formatDate var="rdate" value="${b.regdate}" pattern="yyyy-MM-dd" />
			<c:if test="${today == rdate}">
				<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss"/>
			</c:if>
			<c:if test="${today != rdate }">
				<fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd HH:mm"/>
			</c:if>
			
			</td>
			<td>${b.readcnt}</td>
			<td>${b.commentcnt}</td>
		</tr>
			</c:forEach>
			
		<tr><td colspan="7"><%-- 페이지 처리하기 --%>
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
			<tr>
				<td colspan="7" style="text-align:right" class="tdbottom">
					<c:if test="${loginLv>=2}">
						<form action="writeFormI.do" method="post" name="writeaction">
							<input type="hidden" name="btype" value="3">
							<input type="submit" value="글쓰기"
							style="border:none; width:100px; height:30px; font-size:14px; font-weight:bold; border-radius:5px; background-color:#415a72; color:white;"> 
						</form>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="7" style="valign:center" class="tdbottom">
					<!--  검색기 -->
<form action="listI.do" method="post" name="sf">
	<div style="display : flex; justify-content: center;">
		<input type="hidden" name="btype" value="3">
		<input type="hidden" name="pageNum" value="1">
			<select name="column" style="font-size:14px;"><!-- 컬럼의 이름들 -->
				<option value="">선택하세요</option>
				<option value="b.subject">제목</option>
				<option value="m.nickname">작성자</option>
				<option value="b.content">내용</option>
				<option value="b.subject,m.nickname">제목+작성자</option>
				<option value="b.subject,b.content">제목+내용</option>
				<option value="m.nickname,b.content">작성자+내용</option>
				<option value="b.subject,m.nickname,b.content">제목+작성자+내용</option>
			</select>
		<script>document.sf.column.value = "${param.column}";</script>
		<input type="text" name="find" value="${param.find}" style="width:50%;">
		<input type="submit" value="검색" style="width:100px; font-size:14px; font-weight:bold;">
	</div>
</form>
				</td>
			</tr>
</table>


</div>
</body>
</html>