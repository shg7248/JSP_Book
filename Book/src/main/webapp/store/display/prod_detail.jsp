<%@page import="com.movie.beans.ProductBean"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	String pcode = request.getParameter("pcode");

	ProductDao dao = ProductDao.getInstance();
	ProductBean bean = dao.getProductByPcode(pcode);
%>
<script>
	function goCart(url) {
		const form = window.document.myform;
		form.action = url;
		form.submit();
	}
</script>
<main>
	<img src="<%=contextPath %>/store/images/<%=bean.getImage() %>">
	<form method="post" name="myform">
		<input type="hidden" name="pcode" value="<%=pcode %>">
		<input type="text" name="qty" value="1">
		<input type="button" value="장바구니" onclick="goCart('<%=contextPath %>/store/display/cart_insertPro.jsp')">
		<input type="button" value="즉시결제" >
	</form>
</main>

<%@ include file="/layout/footer.jsp" %>