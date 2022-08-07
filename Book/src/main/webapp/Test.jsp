<%@page import="com.movie.dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CartDao dao = CartDao.getInstance();
	dao.test();
%>