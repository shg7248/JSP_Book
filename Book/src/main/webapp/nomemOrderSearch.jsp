<%@page import="com.movie.beans.OrdersBean"%>
<%@page import="com.movie.dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	String opwd = request.getParameter("opwd");
	String email = request.getParameter("email");
	OrdersDao dao = OrdersDao.getInstance();
	ArrayList<OrdersBean> beans = dao.getNomemOrderSearch(opwd, email);

	
	String msg = null;
	String url = null;
	String type = null;
	if(beans.size() == 0) {
		out.println("<script>alert('등록된 주문정보가 없습니다'); location.href='"+ contextPath +"/signinForm.jsp';</script>");
	}
%>
<style>
	table {
		width: 100%;
		text-align: center;
	}
	
	table th, table td {
		padding: 20px 0;
		border-bottom: 1px solid #DCDCDC;
	}
	
	table td {
		font-size: 14px;
	}
	
	h1{
		font-size: 22px;
		font-weight: bold;
	}
</style>
<main class="main">
	<div class="main__inner">
		<h1>비회원 주문조회</h1>
		<table>
			<tr>
				<th>상품명</th>
				<th>개수</th>
				<th>총 금액</th>
				<th>총 포인트</th>
				<th>등록일</th>
			</tr>
			<%
				for(OrdersBean bean : beans) {
			%>
				<tr>
					<td><%=bean.getTitle() %></td>
					<td><%=bean.getQty() %></td>
					<td><%=df.format(bean.getTotalprice()) %></td>
					<td><%=df.format(bean.getTotalpoint()) %></td>
					<td><%=bean.getReg_date() %></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
</main>
<%@ include file="/layout/footer.jsp" %>