<%@page import="java.net.URLEncoder"%>
<%@page import="com.movie.beans.MemberBean"%>
<%@page import="com.movie.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	
	String referer2 = request.getHeader("referer");
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
		msg = "0 1";
		url = "signinForm.jsp";
		type = "normal";
	}
	else {
		session.setAttribute("mem", bean);
		msg = "0 0";
		if(referer2.equals("/signinForm.jsp")) {
			url = contextPath + "/main.jsp";
		}
		url = referer;
		type = "normal";		
	}
	
	response.sendRedirect(contextPath + "/response.jsp?msg="+msg+"&url="+url+"&type="+type);
%>