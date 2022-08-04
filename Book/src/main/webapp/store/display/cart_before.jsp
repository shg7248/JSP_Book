<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	boolean is_cookie = false; // true : 쿠키가 있다, false : 쿠키가 없다
	String ccode = null;

	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("ccode")) {
			ccode = cookie.getValue();
			is_cookie = true;
			break;
		}
	}
	
	if(!is_cookie) { // 쿠키가 없으면 ccode 생성 후 쿠키를 넣음
		LocalDateTime dateTime = LocalDateTime.now();
		String time = dateTime.format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss_"));
		
		// 11111부터 99999까지 
		int random = (int)(Math.random() * 88889) + 11111;
		ccode = time + random;
		
		Cookie cookie = new Cookie("ccode", ccode);
		cookie.setMaxAge(60 * 60 * 24 * 7);
		cookie.setPath("/Book");
		response.addCookie(cookie);
	}
	
	String[] pcode = request.getParameterValues("pcode");
	String qty = request.getParameter("qty");
	
	if(pcode != null && qty != null) {
		CartBean bean = new CartBean();
		
	}
%>