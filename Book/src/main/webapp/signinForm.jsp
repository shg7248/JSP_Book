<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/signupin/top.jsp" %>
<%
	String referer = request.getHeader("referer");
%>
<main class="main">
	<div class="main__inner">
		<form method="post" action="<%=contextPath %>/signinPro.jsp">
			<input type="hidden" name="referer" value="<%=referer %>">
			<table>
				<tr>
					<td colspan=3>회원 로그인</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id"></td>
					<td rowspan=3><input type="submit" value="로그인"></td>
				</tr>
				<tr>
					<th rowspan=2>비밀번호</th>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<td>아이디찾기 | 비밀번호 찾기</td>
				</tr>
			</table>
		</form>
		<form>
			<table>
				<tr>
					<td colspan=3>비회원 상품조회</td>
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
					<td>회원가입</td>
				</tr>
			</table>
		</form>
	</div>
</main>