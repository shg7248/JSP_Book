<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String phone = request.getParameter("phone");
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
<script>

	let idc = false;
	let pwdc = false;
	let repwdc = false;
	let emailc = false;

	function idcheck(value) {
		
		document.querySelector(".auth-id").innerHTML = "";
		let div = document.createElement("div");
		
		if(!/^([a-z0-9](?![^a-z0-9])){8,15}$/.test(value)) {
			div.classList.add("auth-err");
			div.innerHTML = "아이디가 조건에 맞지 않습니다.";
			document.querySelector(".auth-id").append(div);
			idc = false;
			return;
		}
		
		obj = {mid: value};
		fetch("signup_idcheck.jsp", {
			method: 'post',
			header: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify(obj)
		}).then(function(data) {
			return data.json()
		}).then(function(data) {
			console.log(data.data == "true");
			if(data.data == "true") {
				div.classList.add("auth-err");
				div.innerHTML = "사용 불가능한 아아디 입니다.";
				document.querySelector(".auth-id").append(div);
				idc = false;
			}
			else {
				div.classList.add("auth-ok");
				div.innerHTML = "사용 가능한 아이디 입니다.";
				document.querySelector(".auth-id").append(div);
				idc = true;
			}
		});
	}
	
	function pwdcheck(value) {
		
		document.querySelector(".auth-pwd").innerHTML = "";
		let div = document.createElement("div");
		
		const check = /^(?=.*\d)(?=.*[a-z])(?=.*[~!@#$%^&*()+|=])[a-z\d~!@#$%^&*()+|=]{10,}$/.test(value);
		if(check) {
			div.classList.add("auth-ok");
			div.innerHTML = "사용 가능한 비밀번호 입니다.";
			document.querySelector(".auth-pwd").append(div);
			pwdc = true;			
		}
		else {
			div.classList.add("auth-err");
			div.innerHTML = "비밀번호 형식과 일치하지 않습니다.";
			document.querySelector(".auth-pwd").append(div);
			pwdc = false;				
		}
	}
	
	function repwdcheck(repwd, pwd) {
		
		document.querySelector(".auth-repwd").innerHTML = "";
		let div = document.createElement("div");
		
		if(repwd.value == pwd.value) {
			div.classList.add("auth-ok");
			div.innerHTML = "비밀번호가 일치합니다.";
			document.querySelector(".auth-repwd").append(div);
			repwdc = true;
		}
		else {
			div.classList.add("auth-err");
			div.innerHTML = "비밀번호가 일치하지 않습니다.";
			document.querySelector(".auth-repwd").append(div);
			repwdc = false;			
		}
	}
	
	function emailcheck(value) {
		
		document.querySelector(".auth-email").innerHTML = "";
		let div = document.createElement("div");
		
		const check = /^.+@.+\..+$/.test(value);
		
		if(check) {
			div.classList.add("auth-ok");
			div.innerHTML = "이메일 형식과 일치합니다.";
			document.querySelector(".auth-email").append(div);
			emailc = true;					
		}
		else {
			div.classList.add("auth-err");
			div.innerHTML = "이메일 형식과 일치하지 않습니다.";
			document.querySelector(".auth-email").append(div);
			emailc = false;				
		}
	}
	
	function submitcheck() {
		const id = window.document.forms[0].id;
		const pwd = window.document.forms[0].pwd;
		const repwd = window.document.forms[0].repwd;
		const email = window.document.forms[0].email;
		
		if(id.value.length == 0){
			alert("아이디를 입력하세요");
			id.focus();
			return false;
		}
		
		if(!idc) {
			alert("사용 불가능한 아이디 입니다");
			id.select();
			return false;
		}
		
		if(pwd.value.length == 0){
			alert("비밀번호를 입력하세요.");
			pwd.focus();
			return false;
		}
		
		if(!pwdc) {
			alert("비밀번호 형식과 일치하지 않습니다.");
			pwd.select();
			return false;
		}
		
		if(repwd.value.length == 0){
			alert("비밀번호를 확인을 입력하세요.");
			repwd.focus();
			return false;
		}
		
		if(!repwdc) {
			alert("비밀번호와 일치하지 않습니다.");
			repwd.select();
			return false;
		}
	
		if(email.value.length == 0){
			alert("이메일을 입력하세요.");
			email.focus();
			return false;
		}
		
		if(!emailc) {
			alert("이메일 형식과 일치하지 않습니다.");
			email.select();
			return false;
		}
	
	}
</script>
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
					<div class="contents-form__item contents-form__id">
						<div class="contents-form__title">아이디</div>
						<span class="info info-warning">소문자, 숫자만 포함한 8 ~ 15자리</span>
						<input type="text" name="id" class="contents-form__id contents-form__text" onkeyup="idcheck(this.value)">
						<div class="auth auth-id"></div>
					</div>
					<div class="contents-form__item">
						<div class="contents-form__title">비밀번호</div>
						<span class="info info-warning">소문자, 숫자, 특수문자를 최소 1개씩 포함한 10자리 이상</span>
						<input type="password" name="pwd" class="contents-form__pwd contents-form__text" onkeyup="pwdcheck(this.value)">
						<div class="auth auth-pwd"></div>
					</div>
					<div class="contents-form__item">
						<div class="contents-form__title">비밀번호 확인</div>
						<input type="password" name="repwd" class="contents-form__checkpwd contents-form__text" onkeyup="repwdcheck(this, pwd)">
						<div class="auth auth-repwd"></div>
					</div>
					<div class="contents-form__item">
						<div class="contents-form__title">이메일</div>
						<span class="info info-notice">비밀번호 분실 시 이메일로 임시 비밀번호를 보내드립니다</span>
						<input type="text" name="email" id="" class="contents-form__email contents-form__text" onkeyup="emailcheck(this.value)">
						<div class="auth auth-email"></div>
					</div>
					<div class="contents-form__item">
						<input type="submit" value="가입하기" class="contents-form__submit" onclick="return submitcheck()">
					</div>
				</form>
			</div>
		</div>
	</div>
</main>