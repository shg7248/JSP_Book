<%@page import="com.movie.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<jsp:useBean id="bean" class="com.movie.beans.CategoryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	CategoryDao dao = CategoryDao.getInstance();
	int cnt = dao.insertFirstCategory(bean);
	
	
%>