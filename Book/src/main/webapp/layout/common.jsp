<%@page import="com.movie.beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String contextPath = request.getContextPath();
	
	Object obj = session.getAttribute("mem");
	boolean is_login = obj != null;
	
	MemberBean mem = null;
	if(is_login){
		mem = (MemberBean) obj;
	}
%>

<link rel="stylesheet" href="<%=contextPath %>/style/reset.css">