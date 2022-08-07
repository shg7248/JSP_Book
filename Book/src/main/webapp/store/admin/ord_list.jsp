<%@page import="com.movie.beans.OrdersBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.util.Paging"%>
<%@page import="com.movie.dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<%
	String currentPage = request.getParameter("currentPage");
	String condition = request.getParameter("condition");
	String value = request.getParameter("value");
	OrdersDao dao = OrdersDao.getInstance();
	Paging paging = new Paging(10, 10, dao, currentPage, condition, value);
	
	ArrayList<OrdersBean> beans = dao.getAllOrderList(paging);
	
%>
<style type="text/css">
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
</style>
<main class="main">
	<div class="main__inner">
		<div>
			<form method="post" action="<%=contextPath %>/store/admin/ord_list.jsp">
				<select name="condition">
					<option value="name" <% if(condition != null && condition.equals("name")) { %> selected <% } %>>이름</option>
					<option value="email" <% if(value != null && value.equals("email")) { %> selected <% } %>>이메일</option>
				</select>
				<input type="text" name="value" value="<%=paging.getInputValue() %>">
				<input type="submit">
			</form>
		</div>
		<table>
			<tr>
				<th>결제코드</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>총 결제금액</th>
				<th>총 포인트</th>
				<th>결제일</th>
			</tr>
			<%
			for(OrdersBean bean : beans) {
			%>
			<tr>
				<td><%=bean.getOcode() %></td>
				<td><%=bean.getName() %></td>
				<td><%=bean.getEmail() %></td>
				<td><%=bean.getPhone() %></td>
				<td><%=df.format(bean.getTotalprice()) %> 원</td>
				<td><%=df.format(bean.getTotalpoint()) %> 포인트</td>
				<td><%=bean.getReg_date() %></td>
			</tr>
			<% } %>
		</table>
		<div style="text-align: center; margin-top: 20px;">
			<ul class="page-block__list">
			<% if(paging.isFirstPage()) { %>
				<li><a href="ord_list.jsp?<%=paging.getPrevURL() %>">◀</a></li>
			<% } %>
			<% for(int i = paging.getStartBlock(); i <= paging.getEndBlock(); i++) { %>
				<li class="page-block__item"><a class="page-block__link <% if(paging.getCurrentPage() == i) { %>on<% } %>" href="ord_list.jsp?currentPage=<%=i %><%=paging.getURL() %>"><%=i %></a></li>
			<% } %>
			<% if(paging.isLastPage()) { %>
				<li>
					<a href="ord_list.jsp?<%=paging.getNextURL() %>">▶</a>
				</li>
			<% } %>
			</ul>
		</div>
	</div>
</main>