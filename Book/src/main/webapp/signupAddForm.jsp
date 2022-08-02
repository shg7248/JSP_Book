<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String phone = request.getParameter("phone");
	System.out.println(name);
%>
<style>
	.logo {
		text-align: center;
		margin: 195px 0 50px 0;
	}
	
	.inner {
		width: 950px;
		margin: 0 auto;
	}
	
	.contents-form {
		display: grid;
		grid-template-rows: repeat(4, 1fr);
		grid-gap: 50px;
	}
	
	.contents-form__item {
		width: 464px;
		margin: 0 auto;
	}
	
	.contents-form__title {
		font-size: 25px;
		font-weight: bold;
		padding-bottom: 9px;
		display: inline-block;
	}
	
	.contents-form__text {
		width: 100%;
		height: 49px;
	}
	
	.info {
		font-size: 11px;
		margin-left: 10px;
	}
	
	.info-warning {
		color: red;
	}
	
	.info-notice {
		color: #5480C2;
	}
	
	.auth {
		font-size: 11px;
		font-weight: bold;
		margin-top: 11px;
	}
	
	.auth-err {
		color: red;
	}
	
	.auth-ok {
		color: #5480C2;
	}
	
	.contents-form__submit {
		width: 100%;
		height: 49px;
	}
</style>

<main class="main">
	<div class="main__logo">
		<div class="logo">
			<img src="<%=contextPath %>/images/logo_song.png">
		</div>
	</div>
	<div class="main__contents">
		<div class="contents">
			<div class="contents__inner inner">
				<form action="signupPro.jsp" method="post" class="contents-form">
				<input type="hidden" name="name" value="<%=name %>"/>
				<input type="hidden" name="birth" value="<%=birth %>"/>
				<input type="hidden" name="gender" value="<%=gender %>"/>
				<input type="hidden" name="phone" value="<%=phone %>"/>
					<div class="contents-form__item">
						<div class="contents-form__title">아이디</div>
						<span class="info info-warning">소문자, 숫자를 포함한 8 ~ 15자리</span>
						<input type="text" name="id" class="contents-form__id contents-form__text">
						<div class="auth auth-ok">사용 가능한 아이디 입니다</div>
					</div>
					<div class="contents-form__item">
						<div class="contents-form__title">비밀번호</div>
						<span class="info info-warning">소문자, 숫자, 특수문자를 최소 1개씩 포함한 10자리 이상</span>
						<input type="text" name="pwd" class="contents-form__pwd contents-form__text">
					</div>
					<div class="contents-form__item">
						<div class="contents-form__title">비밀번호 확인</div>
						<input type="text" name="repwd" class="contents-form__checkpwd contents-form__text">
						<div class="auth auth-err">비밀번호가 일치하지 않습니다</div>
					</div>
					<div class="contents-form__item">
						<div class="contents-form__title">이메일</div>
						<span class="info info-notice">비밀번호 분실 시 이메일로 임시 비밀번호를 보내드립니다</span>
						<input type="text" name="email" id="" class="contents-form__email contents-form__text">
						<div class="auth auth-err">이메일 형식과 일치하지 않습니다</div>
					</div>
					<div class="contents-form__item">
						<input type="submit" value="가입하기" class="contents-form__submit" >
					</div>
				</form>
			</div>
		</div>
	</div>
</main>