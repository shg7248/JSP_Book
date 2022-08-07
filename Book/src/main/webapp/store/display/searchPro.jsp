<%@page import="com.movie.beans.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.util.Paging"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	String condition = request.getParameter("condition");
	String value = request.getParameter("value");
	String currentPage = request.getParameter("currentPage");

	System.out.println("condition : " + condition);
	System.out.println("value : " + value);
	
	ProductDao dao = ProductDao.getInstance();
	Paging paging = new Paging(10, 10, dao, currentPage, condition, value);
	ArrayList<ProductBean> beans = dao.getAllProduct(paging);
%>
<style type="text/css">
	.search__size {
		font-size: 22px;
		font-weight: bold;
		margin-bottom: 50px;
	}
	.search__table {
		width: 100%;
	}
	.search__list {
		display: flex;
		justify-content: center;
	}
	.search__list td {
		border-bottom: 1px solid #DCDCDC;
		padding: 20px 0 20px 22px;
	}
	.con__title {
		font-size: 16px;
		color: #707070;
		font-weight: bold;
		margin-bottom: 5px;
	}
	.search__image img{
		width: 100px;
	}
	.con__text {
		font-size: 16px;
	}
	.search__con {
		width: 464px;
		padding: 0 22px;
	}
	.con__list li {
		display: black;
	}
	.con__image img {
		width: 100px;
	}
	.con__detail-info {
		font-size: 12px;
		color: #7D7D7D;
		margin-bottom: 20px;
	}
	.con__price {
		font-size: 11px;
	}
	.con__price .price {
		color: red;
		font-size: 16px;
		font-weight: bold;
	}
	.search__btns a {
		display: inline-block;
		width: 94px;
		height: 33px;
		text-align: center;
		line-height: 33px;
	}
	.btns__cart {
		border: 1px solid #DCDCDC;
		margin-bottom: 10px;
	}
	.btns__order {
		background: #4B78AB;
		color: white;
	}
</style>
<script>
	function goCart(pcode, qty) {
		
		if(qty.value <= 0 || qty.value.trim() == "") {
			alert("1개 이상 입력해야 합니다");
			qty.select();
			return;
		}
		
		if(isNaN(qty.value)) {
			alert("숫자만 입력해야 합니다");
			qty.select();
			return;
		}
		
		const data = []
		const obj = {pcode: pcode.value, qty: qty.value};
		data.push(obj);
		
		fetch("cart_before.jsp", {
			method: "post",
			header: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify(data)
		})
		.then(function(data) {
			const yn = confirm("성공적으로 장바구니에 들어갔습니다.\n장바구니로 이동하시겠습니까?");
			if(yn) {
				location.href="cart_list.jsp"
			}
		})
	}
</script>
<main class="main">
	<div class="main__inner">
		<div class="main__serch">
			<div class="serach">
				<h2 class="search__size">"<%=value %>" 키워드에 대한 <%=beans.size() %>건의 검색 결과입니다</h2>
				<table class="search__table">
				<% for(ProductBean bean : beans) { %>
					<tr class="search__list">
						<td class="search__image">
							<img src="<%=contextPath %>/store/images/<%=bean.getImage() %>" >
						</td>
						<td class="search__con">
							<ul class="con__list">
								<li class="con__title">
									<%=bean.getTitle() %>
								</li>
								<li class="con__detail-info">
									<%=bean.getAuthor() + " 지음 | " + bean.getPublisher() + " | " + bean.getPub_date() + " 출간 | ISBN : " + bean.getIsbn()  %>
								</li>
								<li class="con__text">
									<%=bean.getContent() %>
								</li>
								<li class="con__price">
									<%=df.format(bean.getPrice()) %> 원
									<span class="price"><%=df.format((int)(bean.getPrice() * (1 - ((double)bean.getSale() / 100)))) %></span> 원 (<%=bean.getSale() %>% 할인)
								</li>
							</ul>
						</td>
						<td>
							<div class="search__btns">
								<div class="btns__wrap">
									<form method="post">
										<input type="hidden" name="pcode" value="<%=bean.getPcode() %>" >
										<input type="text" name="qty" value="1" size="4"/><br>
										<input type="button" onclick="goCart(pcode, qty)" value="장바구니" class="btns__cart"/><br>
									</form>
								</div>
							</div>
						</td>
					</tr>
				<% } %>	
				</table>
				<div style="text-align: center; margin-top: 20px;">
			<ul class="page-block__list">
			<% if(paging.isFirstPage()) { %>
				<li><a href="searchPro.jsp?<%=paging.getPrevURL() %>">◀</a></li>
			<% } %>
			<% for(int i = paging.getStartBlock(); i <= paging.getEndBlock(); i++) { %>
				<li class="page-block__item"><a class="page-block__link <% if(paging.getCurrentPage() == i) { %>on<% } %>" href="searchPro.jsp?currentPage=<%=i %><%=paging.getURL() %>"><%=i %></a></li>
			<% } %>
			<% if(paging.isLastPage()) { %>
				<li>
					<a href="searchPro.jsp?<%=paging.getNextURL() %>">▶</a>
				</li>
			<% } %>
			</ul>
		</div>
			</div>
		</div>
	</div>
</main>
<%@ include file="/layout/footer.jsp" %>