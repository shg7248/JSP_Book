<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/signupin/top.jsp" %>
<style>
	.mem-type__title {
		text-align: center;
		font-weight: bold;
		line-height: 40px;
	}
	.mem-type__title h1 {
		font-size: 40px;
	}
	.underline {
		text-decoration: underline;
	}
	.mem-type__title h2 {
		font-size: 25px;
	}
	.mem-type__select {
		text-align: center;
		margin-top: 120px;
		font-weight: bold;
	}
	.mem-type__select p {
		font-size: 16px;
	}
	.mem-type__link {
		display: inline-block;
		width: 243px;
		height: 200px;
		background: #4093F1;
		line-height: 200px;
		font-size: 22px;
		color: white;
		margin-top: 22px;
	}
</style>
<main class="main">
	<div class="main__inner">
		<div class="main__mem-type">
			<div class="mem-type">
				<div class="mem-type__title">
					<h1>학관문고 회원가입</h1>
					<h2>안녕하세요 책의 중심지 <span class="underline">학관문고</span> 입니다</h2>
				</div>
				<hr>
				<div class="mem-type__select">
					<p>회원가입 유형을 선택해 주세요</p>
					<div class="mem-type__button">
						<a class="mem-type__link"href="signupAuthForm.jsp">개인 회원가입</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>