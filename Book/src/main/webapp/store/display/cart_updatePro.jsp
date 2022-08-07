<%@page import="com.movie.dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp"%>
<%

	String cacode = request.getParameter("cacode");
	String qty = request.getParameter("qty");
	
	CartDao dao = CartDao.getInstance();
	int cnt = dao.updateCartQty(cacode, qty);
	
	String msg = null;
	String url = null;
	String type = null;
	if(cnt > 0) {
		msg = "3 0";
		url = "store/display/cart_list.jsp";
		type = "normal";
		
	}
	response.sendRedirect(contextPath + "/response.jsp?type=" + type + "&msg=" + msg+"&url="+url);
%>