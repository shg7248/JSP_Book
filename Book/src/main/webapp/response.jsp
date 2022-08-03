<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	String msg = request.getParameter("msg");
	String url = request.getParameter("url");
	String type = request.getParameter("type");
	
	out.print("<script>alert('" + msg + "')</script>");
	
	if(type.equals("pop")) {
		out.print("<script>window.opener.location.reload(true)</script>");
		out.print("<script>window.self.close()</script>");
	}
	else {
		response.sendRedirect(contextPath + "/" + url);
	}
%>
