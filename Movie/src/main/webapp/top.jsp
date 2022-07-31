<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탑</title>
<link rel=stylesheet href="<%=contextPath %>/style/reset.css">
<link rel=stylesheet href="<%=contextPath %>/style/top.css">
</head>
<body>
	<header class="header">
		<div class="header__inner">
			<div class="top-nav">
				<ul class="top-nav__list">
					<li class="top-nav__item--signin">로그인</li>
					<li class="top-nav__item--signup">회원가입</li>
					<li class="top-nav__item--help">고객센터</li>
					<li class="top-nav__item--cart">장바구니</li>
				</ul>
			</div>
		</div>
	</header>
</body>
</html>