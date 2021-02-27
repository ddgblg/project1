<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<title><decorator:title /></title>
<decorator:head />
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
body {font-size:16px;}
.w3-half img{margin-bottom:-6px;margin-top:16px;opacity:0.8;cursor:pointer}
.w3-half img:hover{opacity:1}
a:link{text-decoration:none;}
.font01{font-family: 'Noto Sans KR', sans-serif;}
#footer{}
</style>
<body>
<font class="font01">
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-red w3-collapse w3-top w3-large w3-padding" style="z-index:3;width:300px;font-weight:bold;" id="mySidebar"><br>
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-button w3-hide-large w3-display-topleft" style="width:100%;font-size:22px">Close Menu</a>
  <div class="w3-container">
  
    <h3 class="w3-padding-64">
    	<c:if test="${empty sessionScope.login}">    	
    		<a href="${path}/culture/member/loginForm.do" ><b>로그인하세요</b></a><br>
    		<a href="${path}/culture/member/joinForm_agree.do"><p class="w3-left" style="font-size: 15px; font-weight: bold;">[회원가입]</p></a>
    	</c:if>
    	<c:if test="${!empty sessionScope.login}">
    		<b>환영합니다</b><br>
    		<b>${sessionScope.login}</b><br>
    		<p class="w3-left" style="font-size: 15px; font-weight: bold;">
    		
    		<c:if test="${sessionScope.lv ==1 }">
    			[신규회원]&nbsp;&nbsp;
    		</c:if>
    		<c:if test="${sessionScope.lv ==2 }">
    			[일반회원]&nbsp;&nbsp;
    		</c:if>
    		<c:if test="${sessionScope.lv ==3 }">
    			[기관회원]&nbsp;&nbsp;
    		</c:if>
    		<c:if test="${sessionScope.login == 'admin' }">
    			[관리자]&nbsp;&nbsp;
    		</c:if>
    		
    		
    		<a href="${path}/culture/member/logout.do" style="text-decoration : none">[로그아웃]</a>
    		</p>
    	</c:if>
    </h3>
    <hr style="width:100%; border:3px solid white" class="w3-round">
  </div>
  <div class="w3-bar-block">
  <c:if test="${!empty sessionScope.login}">
  	<c:if test="${sessionScope.login=='admin'}">
    	<a href="${path}/culture/member/adminpage.do?id=${sessionScope.login}" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-white">· 회원관리</a>
    </c:if>
    <c:if test="${sessionScope.login!='admin'}">
    	<a href="${path}/culture/member/infomember.do?id=${sessionScope.login}" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-white">· 내 정보 보기</a>
    </c:if> 
  </c:if>
     <a href="${path}/culture/main.do" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-white">· 홈</a> 
    <a href="${path}/culture/board/listN.do?btype=1" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-white">· 공지사항</a> 
    <a href="${path}/culture/board/listC.do?btype=2" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-white">· 지역문화탐색</a> 
    <a href="${path}/culture/board/listI.do?btype=3" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-white">· 정보나눔</a> 
  </div>
</nav>


<!-- Top menu on small screens -->
<header class="w3-container w3-top w3-hide-large w3-red w3-xlarge w3-padding">
  <a href="javascript:void(0)" class="w3-button w3-red w3-margin-right" onclick="w3_open()">≡</a>
  <span>Company Name</span>
</header>

<!-- Overlay effect when opening sidebar on small screens -->

<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->

<div class="w3-main" style="margin-left:340px;margin-right:40px">

  <!-- Header -->
  
  <decorator:body />
 

<!-- End page content -->
</div>

<!-- W3.CSS Container -->
<div id="footer" class="w3-light-grey w3-container w3-padding-32" style="margin-top:75px;padding-right:58px"><p class="w3-right">Goodee / 2020 project _ SSG</p></div>
 </font>
<script>
// Script to open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("myOverlay").style.display = "none";
}

// Modal Image Gallery
function onClick(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("modal01").style.display = "block";
  var captionText = document.getElementById("caption");
  captionText.innerHTML = element.alt;
}
</script>

</body>
</html>