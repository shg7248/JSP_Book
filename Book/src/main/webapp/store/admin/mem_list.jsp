<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.util.Paging"%>
<%@page import="com.movie.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<%
	String condition = request.getParameter("condition");
	String value = request.getParameter("value");
	String currentPage = request.getParameter("currentPage");

	MemberDao dao = MemberDao.getInstance();
	Paging paging = new Paging(10, 10, dao, currentPage, condition, value);
	ArrayList<MemberBean> beans = dao.getAllMembers(paging);
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
			<form method="post" action="<%=contextPath %>/store/admin/mem_list.jsp">
				<select name="condition">
					<option value="id" <% if(condition != null && condition.equals("id")) { %> selected <% } %>>아이디</option>
					<option value="name" <% if(value != null && value.equals("name")) { %> selected <% } %>>이름</option>
				</select>
				<input type="text" name="value" value="<%=paging.getInputValue() %>">
				<input type="submit">
			</form>
		</div>
		<table>
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>등록일</th>
			</tr>
			<%
			for(MemberBean bean : beans) {
			%>
			<tr>
				<td><%=bean.getMcode() %></td>
				<td><%=bean.getName() %></td>
				<td><%=bean.getEmail() %></td>
				<td><%=bean.getPhone() %></td>
				<td><%=bean.getReg_date() %></td>
			</tr>
			<% } %>
		</table>
		<div style="text-align: center; margin-top: 20px;">
			<ul class="page-block__list">
			<% if(paging.isFirstPage()) { %>
				<li><a href="mem_list.jsp?<%=paging.getPrevURL() %>">◀</a></li>
			<% } %>
			<% for(int i = paging.getStartBlock(); i <= paging.getEndBlock(); i++) { %>
				<li class="page-block__item"><a class="page-block__link <% if(paging.getCurrentPage() == i) { %>on<% } %>" href="mem_list.jsp?currentPage=<%=i %><%=paging.getURL() %>"><%=i %></a></li>
			<% } %>
			<% if(paging.isLastPage()) { %>
				<li>
					<a href="mem_list.jsp?<%=paging.getNextURL() %>">▶</a>
				</li>
			<% } %>
			</ul>
		</div>
	</div>
</main>