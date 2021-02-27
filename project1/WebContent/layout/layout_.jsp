<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<%-- ↑커스텀 태그. 사용자가 태그 만들어서 씀. 그게 바로 taglib임.  --%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<%--pageContext : EL에 있는 내장객체(JSP의 pageContext객체과 같은 객체임). 그 안의 request객체를 가지고 오고, 또 그 안에 있는 contextPath를 가지고 옴.
contextPath : /jspstudy2   

레이아웃안에서는 절대경로로 넣어주는게 좋다. 

 --%>


<html>
<head>
    <title><decorator:title /></title>
    <decorator:head /> <%--타이틀을 제외한 헤드부분 소스들이 이 안으로 쏙. --%>
    <link rel="stylesheet" href="${path}/css/main.css">
    <%--path : pageContext.request.contextPath : 현재 실행중인 웹어플리케이션의 이름. 절대경로로 바꾼 것이다.
    			레이아웃이 이 css를 가지고 있기때문에, 각 페이지에서는 css link가 필요없다. 
    			공통적으로 지정을 한 상태임.
    --%>
</head>
<body>
    <table>
        <tr>
            <td colspan="3" align="right">
                자바/스프링 기반 빅데이터 플랫폼 개발자 양성과정 모델2 프로그램 연습
                <span style="float:right">
                    <c:if test="${empty sessionScope.login}">
                        <a href="${path}/model2/member/loginform.me">로그인</a>
                        <a href="${path}/model2/member/joinform.me">회원가입</a>
                    </c:if>
                    <c:if test="${!empty sessionScope.login}">
                        ${sessionScope.login}님이 로그인하셨습니다. &nbsp; &nbsp;
                        <a href="${path}/model2/member/logout.me">로그아웃</a>
                    </c:if>
                </span>
            </td>
        </tr>
        <tr>
            <td width="15%" style="vertical-align:top">
                <a href="${path}/model2/member/main.me">회원관리</a> <br>
                <a href="${path}/model2/board/list.do">게시판</a> <br>
                <a href="${path}/model2/chat/chatform.do">채팅</a> <br>
            </td>
            <td colspan="2" style="text-align: left; vertical-align: top">
                <decorator:body /> <%--바디부분 소스들이 이 안으로 쏙. --%>
            </td>
        </tr>
        <tr>
            <td colspan="3">구디아카데미 Since 2016</td>
        </tr>
    </table>
</body>
</html>