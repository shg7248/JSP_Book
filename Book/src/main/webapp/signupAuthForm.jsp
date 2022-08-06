<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/signupin/top.jsp" %>
<style>
	input::placeholder {
		opacity: .5;
	}

	.auth__inner {
		width: 950px;
		margin: 0 auto;
	}
	.auth-form {
		display: grid;
		grid-template-rows: repeat(4, 1fr);
		row-gap: 50px;
	}
	
	.auth-form__item {
		margin: 0 auto;
		width: inherit;
	}
	
	.auth-form__title {
		font-size: 25px;
		font-weight: bold;
		padding-bottom: 9px;
	}
	
	.auth-form__text {
		width: 464px;
		height: 49px;
		padding: 0 0 0 20px;
		font-size: 1rem;
		font-weight: bold;
	}
	
	.auth-form__birth {
		width: 346px;
	}
	
	.auth-form__gender {
		position: relative;
		display: inline-block;
		width: 49px;
		height: 49px;
		top: 2px;
		text-align: center;
		border: 1px solid black;
		line-height: 49px;
	}
	.auth-form__gender:hover {
		cursor: pointer;
	}
	.auth-form__gender.on {
		background: #4093F1;
		color: white;
	}
	
	.auth-form__phone {
		width: 346px;
	}
	
	.auth-form__phone-button {
		width: 107px;
		height: 49px;
		margin-left: 10px;
	}
	
	.auth-form__submit {
		width: 464px;
		height: 49px;
	}
</style>
<script>
	const authfn = auth();
	
	function phoneAuth() {
		
		const name = window.document.forms[0].name;
		const phone = window.document.forms[0].phone;
		const birth = window.document.forms[0].birth;
		const gender = window.document.forms[0].gender;
		
		if(name.value.length == 0) {
			alert("이름을 입력해 주세요");
			name.focus();
			return;
		}
		
		if(birth.value.length == 0) {
			alert("생년월일을 입력해 주세요");
			birth.focus();
			return;
		}
		
		let gf = false;
		for(let i in gender) {
			if(gender[i].checked) {
				gf = true;
				break;
			}
		}
		
		if(!gf) {
			alert("성별을 선택해 주세요");
			return;
		}
		
		if(phone.value.length == 0) {
			alert("휴대폰 번호를 입력해 주세요");
			phone.focus();
			return;
		}
		
		if(!/^010\d{4}\d{4}$/.test(phone.value)) {
			alert("휴대폰 번호 형식과 맞지 않습니다");
			phone.value = "";
			phone.focus();
			return;
		}
		
		const obj = {name: name.value, phone: phone.value};
		const data = {
				method: 'POST',
				headers: {
				    "Content-Type": "application/json",
				},
				body: JSON.stringify(obj)
		}
		
		fetch('authPhone.jsp', data)
		.then((response)=> response.json())
		.then((data) => {
			authfn.setAuthPhone(data.result);
		})
	}
	
	function auth() {
		let authPhone = false;
		
		return {
			setAuthPhone: function(s) {
				if(s == "success") {
					authPhone = true;
					alert("인증이 되었습니다");
				}
				else {
					authPhone = false;
					alert("인증에 실패했습니다\n입력하신 정보를 다시 확인해 주세요");
				}	
			},
			getAuthPhone() {
				return authPhone;
			}
		}
	}
	
	function authSubmit() {
		
		const name = window.document.forms[0].name;
		const phone = window.document.forms[0].phone;
		
		if(!authfn.getAuthPhone()) {
			alert("인증이 필요합니다");
			return false;
		}
	}
</script>
<main class="main">
	<div class="main_auth">
		<div class="auth">
			<div class="auth__inner">
				<form action="signupAddForm.jsp" method="post" class="auth-form">
					<div class="auth-form__item">
						<div class="auth-form__title">이름</div>
						<input type="text" name="name" class="auth-form__name auth-form__text">
					</div>
					<div class="auth-form__item">
						<div class="auth-form__title">생년월일 / 성별</div>
						<input type="text" name="birth" class="auth-form__birth auth-form__text" placeholder="19901001">
						<input type="radio" id="gender-man" name="gender" class="auth-form__gender--man" value="남" style="display: none;" checked/>
						<label for="gender-man" class="auth-form__gender gender on">남</label>
						<input type="radio" id="gender-woman" name="gender" class="auth-form__gender--woman" value="여" style="display: none;"/>
						<label for="gender-woman" class="auth-form__gender gender">여</label>
					</div>
					<div class="auth-form__item">
						<div class="auth-form__title">휴대폰 번호</div>
						<input type="text" name="phone" class="auth-form__phone auth-form__text" placeholder="01012345678">
						<input type="button" class="auth-form__phone-button" value="인증" onclick="phoneAuth()">
					</div>
					<div class="auth-form__item">
						<input type="submit" class="auth-form__submit" value="인증하기" onclick="return authSubmit()">
					</div>
				</form>
			</div>
		</div>
	</div>
</main>
<script>
	document.querySelectorAll(".gender").forEach(function(ele, i) {
		ele.addEventListener("click", function(event) {
			document.querySelector(".auth-form__item .on").classList.remove("on");
			event.target.classList.add("on");
		})
	});
</script>