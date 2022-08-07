<%@page import="com.movie.beans.OrdersBean"%>
<%@page import="com.movie.dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	
	OrdersBean ob = new OrdersBean();
	String[] cacode = request.getParameterValues("cacode");
	String buyerName = request.getParameter("buyerName");
	String buyerPhone = request.getParameter("buyerPhone");
	String buyerEmail = request.getParameter("buyerEmail");
	String buyerPwd = request.getParameter("buyerPwd");
	int mcode = mem == null? -1 : mem.getMcode();
	ob.setMcode(mcode);
	ob.setName(buyerName);
	ob.setPhone(buyerPhone);
	ob.setEmail(buyerEmail);
	ob.setPwd(buyerPwd);
	
	OrdersDao odao = OrdersDao.getInstance();
	int ocode = odao.insertOrder(ob); 
	
	for(String code : cacode) {
		odao.insertOrderDetail(code, ocode);
	}
	
	out.println("<script>alert('주문이 완료 되었습니다'); location.href='"+contextPath+"/main.jsp'</script>");
	
%>