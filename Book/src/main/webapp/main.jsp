<%@page import="com.movie.beans.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	ProductDao dao = ProductDao.getInstance();
	ArrayList<ProductBean> beans = dao.getAllProduct();
%>
<style>
	.contents__title {
		font-size: 25px;
		font-weight: bold;
		margin-bottom: 30px;
	}
	.contents__list {
		display: grid;
		grid-template-columns: repeat(4, 221px);
		column-gap: 22px;
	}
	.contents__item {
		width: 221px;
		margin-bottom: 25px;
	}
	
	.contents__link {
		width: inherit;
	}
	
	.contents__item img {
		width: inherit;
	}
	.contents__text {
		margin-top: 16px;
		line-height: 20px;
	}
	.contents__text strong{
		display: block;
		font-size: 15px;
		font-weight: bold;
	}
	.contents__text span {
		display: block;
		font-size: 12px;
	}
</style>
<main class="main">
	<div class="main__inner">
		<div class="main__slide">
			<div class="slide"></div>
		</div>
		<div class="main__contents">
			<section class="contents__newProd">
				<h2 class="contents__title">
					오늘의 책
				</h2>
				<ul class="contents__list">
				<%
					for(ProductBean bean : beans) {
						%>
						<li class="contents__item">
							<a href="<%=contextPath %>/store/display/prod_detail.jsp?pcode=<%=bean.getPcode() %>" class="contents__link">
								<img src="<%=contextPath %>/store/images/<%=bean.getImage() %>">
							</a>
							<div class="contents__text">
								<strong><%=bean.getTitle() %></strong>
								<span><%=bean.getAuthor()+" | "+bean.getPublisher() %></span>
								<span><%=(int)(bean.getPrice() * (1 - ((double)bean.getSale() / 100))) %> 원</span>
							</div>
						</li>
						<%
					}
				%>
				</ul>
			</section>
		</div>
	</div>
</main>
<%@ include file="/layout/footer.jsp" %>