<%@page import="com.movie.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<jsp:useBean id="bean" class="com.movie.beans.CategoryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	CategoryDao dao = CategoryDao.getInstance();
	int cnt = dao.insertSecondCategory(bean);
	
	String msg = "카테고리가 성공적으로 추가 되었습니다";
	String type = "pop";
	response.sendRedirect(contextPath + "/response.jsp?type=" + type + "&msg=" + msg);
%>