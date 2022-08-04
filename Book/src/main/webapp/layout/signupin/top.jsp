<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<style type="text/css">
	.header {
		font-size: 11px;
		color: #333333;
	}
	.header__inner {
		position: relative;
		padding: 200px 0 50px 0;
		width: 950px;
		margin: 0 auto;
	}
	.nav__list {
		position: absolute;
		display: flex;
		right: 20px;
		top: 6px;
	}
	.nav__item {
		margin-left: 4px;
	}
	.nav__item:not(.nav__item:last-child)::after {
		content: "|";
		color: #ccc;
	}
	.header__logo {
		text-align: center;
	}
	.main__inner {
		width: 950px;
		margin: 0 auto;
	}
</style>
<header class="header">
	<div class="header__inner">
		<div class="header__nav">
			<div class="nav">
				<ul class="nav__list">
					<li class="nav__item">
						<a href="<%=contextPath %>/signinForm.jsp">로그인</a>
					</li>
					<li class="nav__item">
						<a>고객센터</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="header__logo">
			<img src="<%=contextPath %>/images/logo_song.png">
		</div>
	</div>
</header>