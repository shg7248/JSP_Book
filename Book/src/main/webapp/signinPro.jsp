<%@page import="com.movie.beans.MemberBean"%>
<%@page import="com.movie.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String referer = request.getParameter("referer");
	
	String con = "http://localhost:8080" + contextPath + "/";
	referer = referer.replace(con, "");
	
	MemberDao dao = MemberDao.getInstance();
	MemberBean bean = dao.confirmMember(id, pwd);
	
	String msg = null;
	String url = null;
	String type = null;
	if(bean == null) {
		msg = "잘못 입력하셨습니다";
		url = "signinForm.jsp";
		type = "normal";
	}
	else {
		session.setAttribute("mem", bean);
		msg = "회원님 환영합니다";
		url = referer;
		type = "normal";		
	}
	
	response.sendRedirect(contextPath + "/response.jsp?msg="+msg+"&url="+url+"&type="+type);
%>