<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/signupin/top.jsp" %>
<%
	String referer = request.getHeader("referer");
%>
<style>
	table {
		width: 40%;
		margin: 0 auto;
	}
	
	table strong {
		
	}
	
	talbe th, table td{
		
	}
	
	table th {
		font-size: 14px;
	}
</style>
<script>
	function loginCheck() {
		const form = window.document.memLogin_form;
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
	}
</script>
<main class="main">
	<div class="main__inner">
		<form method="post" name="memLogin_form" class="main__memLogin-form" action="<%=contextPath %>/signinPro.jsp">
			<input type="hidden" name="referer" value="<%=referer %>">
			<table border=1>
				<tr>
					<td colspan=3>
						<strong>회원 로그인</strong>
					</td>
				</tr>
				<tr>
					<td colspan=3 height=20></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td colspan=2 class="">
						<input type="text" name="id">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pwd">
					</td>
					<td rowspan=2>
						<input type="submit" value="로그인" onclick="return loginCheck()">
					</td>
				</tr>
				<tr>
					<td colspan=3>아이디찾기 | 비밀번호 찾기</td>
				</tr>
			</table>
		</form>
		<hr>
		<form class="main__nomemSearch-form">
			<table>
				<tr>
					<td colspan=3>
						<strong>비회원 상품조회</strong>
					</td>
				</tr>
				<tr>
					<td colspan=3 height=20></td>
				</tr>
				<tr>
					<th>주문 비밀번호</th>
					<td><input type="text" name="id"></td>
					<td rowspan=3><input type="submit" value="로그인"></td>
				</tr>
				<tr>
					<th rowspan=2>이메일</th>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<td>
						<a href="<%=contextPath %>/signupType.jsp">회원가입</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</main>