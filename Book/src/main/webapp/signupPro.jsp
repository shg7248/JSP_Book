<%@page import="com.movie.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<jsp:useBean id="mbean" class="com.movie.beans.MemberBean"/>
<jsp:setProperty property="*" name="mbean"/>
<%
	MemberDao dao = MemberDao.getInstance();
%>
