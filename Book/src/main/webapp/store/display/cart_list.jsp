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
	
	CartDao dao = CartDao.getInstance();
	
	String condition = null;
	String value = null;
	
	if(session.getAttribute("mem") == null) {
		condition = "ccode";
		
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("ccode")) {
				value = cookie.getValue();
				break;
			}
		}
	}
	else {
		condition = "mcode";
		value = String.valueOf((int) session.getAttribute("mem"));
	}
	
	ArrayList<CartDetailBean> beans= dao.getCateByCondition(condition, value);
%>

<main>
	<%
		for(CartDetailBean bean : beans) {
			%>
			<%=bean.getTitle() %><br>
			<%
		}
	%>
	<input type="button" value="주문하기">
</main>

<%@ include file="/layout/footer.jsp" %>