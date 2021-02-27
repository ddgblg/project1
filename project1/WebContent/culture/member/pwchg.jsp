<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
	//jsp페이지라면 스크립트 영역안에서도 jstl을 쓸 수 있다. 
	alert("${msg}");
	
	<c:if test="${opener}">
		opener.location.href="${url}";
	</c:if>
	<c:if test="${closer}">
		self.close();
	</c:if>
	<c:if test="${!opener}">
		location.href="${url}";
	</c:if>
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2020/12 project1_SSG</title>
</head>
<body>

</body>
</html>


