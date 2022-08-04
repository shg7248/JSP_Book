<%@page import="com.movie.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<jsp:useBean id="bean" class="com.movie.beans.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	MemberDao dao = MemberDao.getInstance();
	int cnt = dao.insertMember(bean);
	
	if(cnt > 0) {
		response.sendRedirect(contextPath + "/signupResult.jsp");
	}
%>
