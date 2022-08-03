<%@page import="com.movie.beans.CartDetailBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CartDao"%>
<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	Object mem = session.getAttribute("mem");
	CartDao dao = CartDao.getInstance();
	String condition = null;
	String value = null;
	
	String cookieValue = null;
	Cookie[] cookies = request.getCookies();
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("ccode")) {
			value = cookie.getValue();
			break;
		}
	}
	
	if(mem == null) { // 비회원일 경우
		condition = "ccode";
	}
	else { // 회원일 경우
		if(value != null) { // ccode라는 쿠키가 있을 경우 MCODE를 회원의 MCODE로 업데이트
			String mcode = String.valueOf(session.getAttribute("mem"));
			dao.updateMcode(value, mcode);
		}
		condition = "mcode";
		value = String.valueOf((int)
				mem);
	}
	
	ArrayList<CartDetailBean> beans= dao.getCateByCondition(condition, value);
%>

<main>
	<%
		for(CartDetailBean bean : beans) {
			%>
			<input type="checkbox">
			상품명 : <%=bean.getTitle() %>
			갯수 : <%=bean.getQty() %>
			<br>
			<%
		}
	%>
	<input type="button" value="주문하기">
</main>

<%@ include file="/layout/footer.jsp" %>