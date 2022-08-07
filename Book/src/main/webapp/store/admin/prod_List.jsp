<%@page import="com.movie.beans.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@page import="com.movie.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<%
	String condition = request.getParameter("condition");
	String value = request.getParameter("value");
	String currentPage = request.getParameter("currentPage");

	ProductDao dao = ProductDao.getInstance();
	Paging paging = new Paging(2, 3, dao, currentPage, condition, value);
	ArrayList<ProductBean> beans = dao.getAllProduct(paging);
	
%>
<style type="text/css">
	.book-table {
		width: 100%;
	}
	.book-table__image img{
		width: 80px;
	}
	.book-table__list th {
		font-weight: bold;
	}
	.book-table__list td, .book-table__list th {
		padding: 10px 0;
		border-bottom: 1px solid #DCDCDC;		
	}
	.book-table__list td {
		font-size: 15px;
		vertical-align: middle;
		text-align: center;
	}
	.book-table__title {
		width: 200px;
	}
	.book-table__title-wrap {
		display: inline-block;	
		width: inherit;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.page-block {
		margin-top: 20px;
	}
	.page-block__list {
		display: flex;
		justify-content: center;
	}
	.page-block__item {
		margin: 0 10px;
	}
	.page-block__link.on {
		color: red;
	}
	.book-search {
		float: right;
	}
</style>
<main class="main">
	<div class="main__inner">
		<div class="">
			<input type="button" value="상품등록" onclick="location.href='prod_insertForm.jsp'"/>
			<div class="book-search">
				<form class="book-search__form" method="post" action="prod_List.jsp">
					<select name="condition">
						<option value="title" <% if(condition != null && condition.equals("title")) { %> selected <% } %>>상품명</option>
						<option value="author" <% if(condition != null && condition.equals("author")) { %> selected <% } %>>저자</option>
						<option value="publisher" <% if(condition != null && condition.equals("publisher")) { %> selected <% } %>>출판사</option>
					</select>
					<input class="book-serach__txt" type="text" name="value" value="<%=paging.getInputValue() %>"/>
					<input class="book-serach__txt" type="submit" value="검색"/>
				</form>
			</div>
		</div>
		<table class="book-table">
			<tr class="book-table__list">
				<th></th>
				<th>상품명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>재고</th>
				<th>수정</th>
			</tr>
			<% for(ProductBean bean : beans) { %>
			<tr class="book-table__list">
				<td class="book-table__image"><img src="<%=contextPath %>/store/images/<%=bean.getImage() %>" ></td>
				<td class="book-table__title">
					<div class="book-table__title-wrap">
						<a class="book-table__link" href=""><%=bean.getTitle() %></a>
					</div>
				</td>
				<td><%=bean.getAuthor() %></td>
				<td><%=bean.getPublisher() %></td>
				<td><%=bean.getQty() %></td>
				<td><a href="<%=contextPath %>/store/admin/prod_updateForm.jsp?pcode=<%=bean.getPcode() %>">수정</a></td>
			</tr>
			<% } %>
		</table>
		<div class="page-block">
			<ul class="page-block__list">
			<% if(paging.isFirstPage()) { %>
				<li><a href="prod_List.jsp?<%=paging.getPrevURL() %>">◀</a></li>
			<% } %>
			<% for(int i = paging.getStartBlock(); i <= paging.getEndBlock(); i++) { %>
				<li class="page-block__item"><a class="page-block__link <% if(paging.getCurrentPage() == i) { %>on<% } %>" href="prod_List.jsp?currentPage=<%=i %><%=paging.getURL() %>"><%=i %></a></li>
			<% } %>
			<% if(paging.isLastPage()) { %>
				<li>
					<a href="prod_List.jsp?<%=paging.getNextURL() %>">▶</a>
				</li>
			<% } %>
			</ul>
		</div>
    </div>
</main>