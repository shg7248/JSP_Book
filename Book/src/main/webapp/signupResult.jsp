<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/signupin/top.jsp" %>
<style type="text/css">
	.signin-result__title {
		text-align: center;
		font-weight: bold;
		line-height: 40px;
	}
	.signin-result__title h2{
		font-size: 25px;
	}
	.signin-result__buttons {
		display: flex;
		justify-content: center;
		margin: 30px;
	}
	.signin-result__buttons li {
		padding: 0px 20px;
	}
	.signin-result__buttons li a {
		display: inline-block;
		line-height: 100px;
		text-align: center;
		background: #00BFFF;
		width: 200px;
		height: 100px;
		font-size: 20px;
		font-weight: bold;
		color: white;
		border-radius: 10px;
	}
</style>
<main class="main">
	<div class="main__inner">
		<div class="main__signin-result">
			<div class="signin-result">
				<div class="signin-result__title">
					<h2>축하합니다<br>회원가입이 완료 되었습니다</h2>
				</div>
				<ul class="signin-result__buttons">
					<li class="signin-result__buttons--main"><a href="<%=contextPath %>/main.jsp">메인으로</a></li>
					<li class="signin-result__buttons--signin"><a href="<%=contextPath %>/signinForm.jsp">로그인</a></li>
				</ul>
			</div>
		</div>
	</div>
</main>
