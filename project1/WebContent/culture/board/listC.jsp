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
th{background-color:#604660; border:none;}
input{border:1px solid #dbdbdb; font-size:14px;}
select{border:1px solid #dbdbdb; font-size:14px;}
td{height:50px;}
.listb:hover{background-color:#f8f8f8;}
.td{border-left:none;border-right:none;border-top:none;}
.tdbottom{border:none;}
.bimg{width: 150px; border-radius: 8px;}
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
<div class="w3-container" style="margin-top: 70px" id="showcase">
		<h1 class="w3-xxxlarge w3-text-red">
			<b>������ȭŽ��</b>
		</h1>
		<hr style="width: 50px; border: 5px solid red" class="w3-round">
		<br>
		<div id="bar">
			�Խù� ���
		</div>
	
		<br>
		<!-- ===========================���� ��======================================== -->

<table style="border:none;">
	<c:if test="${boardcount==0}">  
		<tr><td colspan="6">��ϵ� �Խñ��� �����ϴ�.</td></tr>
	</c:if>
	<c:if test="${boardcount!=0}">
		
		<tr>
			<th width="5%" style=" border-bottom-left-radius: 20px;border-top-left-radius: 20px;">��ȣ</th>
			<th width="15%" >�̹���</th>
			<th width="50%">����</th>
			<th width="11%">�ۼ����</th>
			<th width="11%">�ۼ���</th>
			<th width="8%" style="border-bottom-right-radius: 20px;border-top-right-radius: 20px;">��ȸ��</th>
		</tr>
			<c:forEach var="b" items="${list}">
			<tr class="listb">
				<%-- ��¥�۹�ȣ --%>
				<td class="td">${boardnum} </td><c:set var="boardnum" value="${boardnum-1 }"/><%--������--%>
			
				<td class="td">
			  	<%--÷������ ǥ�� --%>
			  	<c:if test="${b.imgfile!=null}">
			  		<a href="file/${b.imgfile}"><img src="file/${b.imgfile}" class="bimg"></a>
			  	</c:if>
			  	<c:if test="${b.imgfile==null}">
			  		<img src="../icon/noimage.jpg" class="bimg">
			  	</c:if>
				</td>
				
				<td style="text-align:left;"  class="td">
				<%--�Խñ� �󼼺��� --%>
			  <fmt:formatDate var="rdate" value="${b.regdate}" pattern="yyyy-MM-dd" /><%--���ó�¥�� ���Ϸ���--%>
			  	<c:if test="${b.area != ''}">[${b.area}] </c:if>
			  	<c:if test="${b.category != ''}">[${b.category}] </c:if>
				&nbsp;<a href="infoC.do?num=${b.num}&btype=2">${b.subject}</a>
				<c:if test="${today == rdate}">
					<img src="../icon/icn_new.png">
				</c:if>
				</td>
				<td  class="td">${b.comp}</td>
				<td  class="td">
			
			<%--���� ��ϵ� �Խù� ��¥ format��� ����ϱ� --%>
			<c:if test="${today == rdate}">
				<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss"/>
			</c:if>
			<c:if test="${today != rdate }">
				<fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd HH:mm"/>
			</c:if>
			
			</td>
			<td class="td">${b.readcnt}</td>
		</tr>
			</c:forEach>
			
		<tr><td colspan="6" class="td"><%-- ������ ó���ϱ� --%>
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
			<tr>
				<td colspan="6" style="text-align:right;" class="tdbottom">
					<c:if test="${loginLv>=3}">
						<form action="writeFormC.do" method="post" name="writeaction">
							<input type="hidden" name="btype" value="2">
							<input type="submit" value="�۾���"
							style="border:none; width:100px; height:30px; font-size:14px; font-weight:bold; border-radius:5px; background-color:#415a72; color:white;"> 
						</form>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="6" style="valign:center;" class="tdbottom">
					<!--  �˻��� -->
<form action="listC.do" method="post" name="sf">
	<div style="display : flex; justify-content: center;">
		<input type="hidden" name="btype" value="2">
		<input type="hidden" name="pageNum" value="1">
			<select name="column" style="font-size:14px;"><!-- �÷��� �̸��� -->
				<option value="">�����ϼ���</option>
				<option value="b.subject">����</option>
				<option value="m.comp">�ۼ����</option>
				<option value="b.content">����</option>
				<option value="b.subject,m.comp">����+�ۼ����</option>
				<option value="b.subject,b.content">����+����</option>
				<option value="m.comp,b.content">�ۼ����+����</option>
				<option value="b.subject,m.comp,b.content">����+�ۼ����+����</option>
			</select>
		<script>document.sf.column.value = "${param.column}";</script>
		<input type="text" name="find" value="${param.find}" style="width:50%;">
		<input type="submit" value="�˻�" style="width:100px; font-size:14px; font-weight:bold;">
	</div>
</form>
				</td>
			</tr>
</table>


</div>
</body>
</html>