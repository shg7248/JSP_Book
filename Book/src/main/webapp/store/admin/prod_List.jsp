<%@page import="com.movie.beans.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@page import="com.movie.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<%
	ProductDao dao = ProductDao.getInstance();
	int size = dao.getAllProductSize();
	
	Paging paging = new Paging(10, 10);
	paging.setBoardSize(size);
	
	ArrayList<ProductBean> beans = dao.getAllProduct(paging);
	
	
%>
<main class="main">
	<div class="main__inner">
		<input type="button" value="상품등록" onclick="location.href='prod_insertForm.jsp'"/>
		
		<br>
		<%
		for(ProductBean bean : beans) {
			out.print(bean.getTitle() + "<br>");
		}
		%>
		
		<%
		
		%>
		
    </div>
</main>