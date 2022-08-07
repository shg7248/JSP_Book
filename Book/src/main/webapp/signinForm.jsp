<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/signupin/top.jsp" %>
<%
	String referer = request.getHeader("referer");
%>
<style>
	.signin-table {
		width: 40%;
		margin: 0 auto;
	}
	.signin-table td{
		padding-bottom: 10px;
	}
	.signin-table__sub-title {
		font-size: 20px;
		font-weight: bold;
	}
	.signin-table__link, .link-gubun {
		font-size: 12px;
	}
	.signin-table__submit {
		position: absolute;
		width: 50px;
		height: 50px;
		top: -30px;
		left: -60px;
		font-size: 10px;
	}
</style>
<script>
	function loginCheck(url) {
		const form = window.document.forms[0];
		const id = form.id;
		const pwd = form.pwd;
		
		if(id.value.length == 0){
			alert("아이디를 입력하세요");
			id.focus();
			return false;
		}
		
		if(pwd.value.length == 0){
			alert("비밀번호를 입력하세요");
			pwd.focus();
			return false;
		}
		
		form.action = url;
		form.submit();
	}
	
	function nomemSearch(opwd, email, url) {
		
		const form = window.document.forms[0];		
		if(opwd.value.length == 0) {
			
			alert("주문비밀번호를 입력해 주세요");
			opwd.focus();
			return false;
		}
		
		if(email.value.length == 0) {
			alert("이메일을 입력해 주세요");
			email.focus();
			return false;
		}
		
		form.action = url;
		form.submit();
	}
</script>
<main class=main>
	<div class=main__inner>
		<form class=signin-form method=post>
			<input type="hidden" name="referer" value="<%=referer %>">
			<table class=signin-table>
				<tr class="signin-table__sub-title">
					<th colspan=3>회원 로그인</th>
				</tr>
				<tr height=20>
					<td></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td colspan=2>
						<input type=text name="id"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd"/></td>
					<td style="position: relative;">
						<input class="signin-table__submit" type="submit" value="로그인" onclick="return loginCheck('<%=contextPath %>/signinPro.jsp')"/>
					</td>
				</tr>
				<tr>
					<td colspan=3>
						<a class=signin-table__link href=>아이디찾기</a>
						<span class="link-gubun"> | </span> 
						<a class=signin-table__link href=>비밀번호 찾기</a>
					</td>
				</tr>
				<tr height=60>
					<td colspan=3></td>
				</tr>
				<tr class=signin-table__sub-title>
					<th colspan=3>비회원 상품조회</th>
				</tr>
				<tr height=20>
					<td></td>
				</tr>
				<tr>
					<td>주문 비밀번호</td>
					<td colspan=2><input type="password" name="opwd"/></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"/></td>
					<td style="position: relative;"><input class="signin-table__submit" type="submit" value="조회" onclick="return nomemSearch(opwd, email, '<%=contextPath %>/nomemOrderSearch.jsp')"/></td>
				</tr>
				<tr>
					<td colspan=3>
						<a class=signin-table__link href="<%=contextPath %>/signupType.jsp">회원가입</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</main>