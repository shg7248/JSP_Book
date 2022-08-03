<%@page import="com.movie.beans.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	ProductDao dao = ProductDao.getInstance();
	ArrayList<ProductBean> beans = dao.getAllProduct();
	
	for(ProductBean bean : beans) {
		%>
		<a href="<%=contextPath %>/store/display/prod_detail.jsp?pcode=<%=bean.getPcode() %>">
			<img src="<%=contextPath %>/store/images/<%=bean.getImage() %>">
		</a>
		<%
	}
%>
<%@ include file="/layout/footer.jsp" %>