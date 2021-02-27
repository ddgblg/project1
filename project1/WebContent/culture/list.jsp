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
<title>�Խù� ��� ����</title>
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
		f = document.sf; // form ��ü ��ü.
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
		<tr><td colspan="5">��ϵ� �Խñ��� �����ϴ�.</td></tr>
	</c:if>
	<c:if test="${boardcount!=0}">
	<tr>
			<td colspan="5" style="text-align:right">�۰���:${boardcount}</td>
		</tr>
		<tr>
			<th width="8%">��ȣ</th>
			<th width="50%">����</th>
			<th width="14%">�ۼ���</th>
			<th width="17%">�����</th>
			<th width="11%">��ȸ��</th>
		</tr>
			<c:forEach var="b" items="${list}">
			<tr>
				<%-- ��¥�۹�ȣ --%>
				<td>${boardnum} </td><c:set var="boardnum" value="${boardnum-1 }"/><%--������--%>
			
				<td style="text-align:left">
			<%--����� level��ŭ �鿩���� --%>
			
			<c:if test="${b.grplevel > 0 }">
				<c:forEach var="i" begin="1" end="${b.grplevel}">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:forEach>
				��
			</c:if>
			
			
			<a href="info.do?num=${b.num}">${b.subject}</a><%--�Խñ� �󼼺���--%>
			</td>
			
			<td>${b.name}</td>
			<td>
			
			<%--���� ��ϵ� �Խù� ��¥ format��� ����ϱ� --%>
			  <fmt:formatDate var="rdate" value="${b.regdate}" pattern="yyyy-MM-dd" /><%--���ó�¥�� ���Ϸ���--%>
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
			
		<tr><td colspan="5"><%-- ������ ó���ϱ� --%>
			<c:if test="${pageNum <= 1}">[����]</c:if>
			<c:if test="${pageNum >1 }" ><a href="javascript:listdo(${ pageNum -1})">[����]</a></c:if><!-- �˻� ���Ǳ��� �Ѱ��ְԲ� script�� ���ļ�����. -->

			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a==pageNum }">[${a}]</c:if> <%--jstl�� else�� ����.���� --%>
				<c:if test="${a!=pageNum }"><a href="javascript:listdo(${a})">[${a }]</a></c:if>
			</c:forEach>	

			<c:if test="${pageNum >= maxpage }">[����]</c:if>
			<c:if test="${pageNum < maxpage}"><a href="javascript:listdo(${pageNum + 1})">[����]</a></c:if>
			
			</td>
		</tr>
		
		
	</c:if>
</table>
</div>
</body>
</html>