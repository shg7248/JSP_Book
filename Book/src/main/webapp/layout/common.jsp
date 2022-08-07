<%@page import="java.text.DecimalFormat"%>
<%@page import="com.movie.beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	////////////////////쿠키///////////////////////
	Cookie[] cookies = request.getCookies();
	
	////////////////가격 표시 //////////////////////
	DecimalFormat df = new DecimalFormat("###,###");

	//////////////// 절대경로 //////////////////////
	String contextPath = request.getContextPath();
	
	////////////////// 로그인 확인 //////////////////
	Object obj = session.getAttribute("mem");
	boolean is_login = obj != null;
	
	MemberBean mem = null;
	if(is_login){
		mem = (MemberBean) obj;
	} 
%>

<link rel="stylesheet" href="<%=contextPath %>/style/reset.css">