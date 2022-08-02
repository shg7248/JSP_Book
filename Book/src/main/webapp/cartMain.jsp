<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies();
	
	for(Cookie c : cookies) {
		if(c.getName().equals("song")) {
			System.out.println(c.getValue());
		}
	}
%>