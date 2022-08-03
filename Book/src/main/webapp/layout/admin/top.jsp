<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<style>
	.wrap {
		width: 950px;
		min-height: 100%;
		margin: 0 auto;
		padding-left: 221px;
		position: relative;
	}
	.header {
		position: absolute;
		background: #202020;
		min-height: inherit;
		top: 0;
		left: 0;
	}
	.header__inner {
		width: 221px;
		padding-top: 60px;
	}
	.header__logo {
		text-align: center;
		
	}
	.nav {
		margin-top: 40px;
		text-align: center;
	}
	
	.nav__title {
		font-size: 22px;
		font-weight: bold;
		color: white;
	}
	.nav__list {
		margin-top: 22px;
	}
	.nav__link {
		display: inline-block;
		line-height: 60px;
		width: 100%;
		height: 60px;
		font-size: 16px;
		font-weight: bold;
		color: white;
	}
	.nav__link:hover {
		background: white;
		color: #707070;
	}
	
	.nav__item--on a{
		background: white;
		color: #707070;
	}
	
	.main__inner {
        width: 100%;
        padding-top: 120px;
        background: rgb(227, 255, 186);
    }
</style>
<div class="wrap">
<header class="header">
	<div class="header__inner">
		<div class="header__logo">
			<div class="logo">
				<a href="#" class="logo__link">
					<img src="<%=contextPath %>/images/logo_song_white.png">
				</a>
			</div>
		</div>
		<div class="nav">
			<strong class="nav__title">관리자 페이지</strong>
			<ul class="nav__list">
				<li class="nav__item nav__item--on">
					<a href="<%=contextPath %>/store/admin/cateList.jsp" class="nav__link">카테고리 관리</a>
				</li>
				<li class="nav__item">
					<a href="" class="nav__link">회원목록</a>
				</li>
				<li class="nav__item">
					<a href="<%=contextPath %>/store/admin/prod_List.jsp" class="nav__link">상품정보</a>
				</li>
				<li class="nav__item">
					<a href="" class="nav__link">판매목록</a>
				</li>
			</ul>
		</div>
	</div>
</header>