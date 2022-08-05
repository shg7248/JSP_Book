<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<script type="text/javascript">
	function goCart() {
		fetch(getContextPath() + "/store/display/cart_before.jsp", {
			method: "post",
			header: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify([])
		})
		.then(function() {
			location.href= getContextPath() + "/store/display/cart_list.jsp";
		})
	}
	
	function getContextPath() {
		  var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		  return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
</script>
<link rel=stylesheet href="<%=contextPath %>/style/top.css">
<header class="header">
	<div class="header__inner">
		<div class="top-nav">
			<ul class="top-nav__list">
				<% if(is_login){ %>
					<li class="top-nav__item top-nav__item--signout">
						<a href="<%=contextPath %>/signout.jsp">로그아웃</a>
					</li>
					<li class="top-nav__item top-nav__item--signin">
						<a href="<%=contextPath %>/signinForm.jsp">마이페이지</a>
					</li>				
				<% } else { %>
					<li class="top-nav__item top-nav__item--signin">
						<a href="<%=contextPath %>/signinForm.jsp">로그인</a>
					</li>
					<li class="top-nav__item top-nav__item--signup">
						<a href="<%=contextPath %>/signupType.jsp">회원가입</a>
					</li>
				<% } %>
				<li class="top-nav__item top-nav__item--help">
					<a href="">고객센터</a>
				</li>
				<li class="top-nav__item top-nav__item--cart">
					<a href="javascript:goCart()">장바구니</a>
				</li>
			</ul>
		</div>
		<div class="header__search">
			<div class="search">
				<div class="search__inner">
					<form class="search__content">
						<select class="search__select">
							<option>통합검색</option>
						</select>
						<input type="text" class="search__input">
						<input type="submit" class="search__button">
					</form>
				</div>
			</div>
		</div>
		<div class="header__logo">
			<div class="logo">
				<a href="<%=contextPath %>/main.jsp" class="logo__link">
					<img src="<%=contextPath %>/images/logo_song.png" alt="학관문고" class="logo__img">
				</a>
			</div>
		</div>
	</div>
</header>
<nav class="nav">
	<div class="nav__inner">
		<ul class="nav__list">
			<li class="nav__item nav_item--kor">
				<a href="">국내도서</a>
			</li>
			<li class="nav__item nav_item--foreign">
				<a href="">해외도서</a>
			</li>
			<li class="nav__item nav_item--best">
				<a href="">베스트도서</a>
			</li>
			<li class="nav__item nav_item--new">
				<a href="">신간도서</a>
			</li>
		</ul>
	</div>
</nav>