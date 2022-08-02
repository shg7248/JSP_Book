<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<form>
	회원 로그인
	<input type="text" name="id">
	<input type="text" name="pwd">
	<input type="submit" value="로그인">
	<br>
	아이디 찾기 | 비밀번호 찾기
</form>
<form>
	비회원 상품조회
	<input type="text" name="pwd">
	<input type="text" name="email">
	<input type="submit" value="확인">
	<br>
	<a href="<%=contextPath %>/signupType.jsp">회원가입</a>
</form>