<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.movie.beans.ProductBean"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	String pcode = request.getParameter("pcode");

	ProductDao dao = ProductDao.getInstance();
	ProductBean bean = dao.getProductByPcode(pcode);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	Timestamp pub_date = Timestamp.valueOf(bean.getPub_date());
%>
<script>
	function goCart(url) {
		const form = window.document.myform;
		form.action = url;
		form.submit();
	}
</script>
<style type="text/css">
	.prod-info {
		display: grid;
		grid-template-columns: 221px auto;
		column-gap: 22px;
	}
	.prod-info__image {
		width: 221px;
	}
	.prod-info__image img {
		width: inherit;
	}
	.prod-info__item {
		padding-top: 20px;
		font-size: 11px;
		color: #7D7D7D;
	}
	.prod-info__item--title {
		font-size: 22px;
		font-weight: bold;
		color: #284998;
	}
	.prod-info__item--detailInfo {
		font-size: 12px;
		padding-bottom: 30px;
		border-bottom: 1px solid #C2C2C2;
	}
	.prod-info__item--price {
		line-height: 18px;
	}
	.prod-info__item--price .price {
		font-size: 16px;
		font-weight: bold;
		color: red;
	}
	.prod-info__item--point {
		line-height: 18px;		
	}
	.prod-info__item--qty {
		padding-bottom: 30px;
		border-bottom: 1px solid #C2C2C2;
	}
</style>
<main class="main">
	<div class="main__inner">
		<div class="main__cate">
			
		</div>
		<div class="main__prod-info">
			<div class="prod-info">
				<div class="prod-info__image">
					<img src="<%=contextPath %>/store/images/<%=bean.getImage() %>">
				</div>
				<form class="main-form prod-info__content" method="post" name="myform">
					<input type="hidden" name="pcode" value="<%=pcode %>">
					<ul class="prod-info__list">
						<li class="prod-info__item prod-info__item--title">
							<h2><%=bean.getTitle() %></h2>
						</li>
						<li class="prod-info__item prod-info__item--detailInfo">
							<%=bean.getAuthor() + " 지음 | " + bean.getPublisher() + " | " + sdf.format(pub_date) + " 출간 | ISBN : " + bean.getIsbn()  %>
						</li>
						<li class="prod-info__item prod-info__item--price">
							정가 <%=df.format(bean.getPrice()) %> 원
							<br>
							할인가 <span class="price"><%=df.format((int)(bean.getPrice() * (1 - ((double)bean.getSale() / 100)))) %></span> 원 (<%=bean.getSale() %>% 할인)
						</li>
						<li class="prod-info__item prod-info__item--point">
							적립 <%=df.format((int)(bean.getPrice() * 0.05)) %>원 (5%)
						</li>
						<li class="prod-info__item prod-info__item--qty">
							수량
							<input type="text" name="qty" value="1" size=4>
							<input type="button" value="+">
							<input type="button" value="-">
						</li>
						<li class="prod-info__item prod-info__item--order">
							<input type="button" value="장바구니" onclick="goCart('<%=contextPath %>/store/display/cart_insertPro.jsp')">
							<input type="button" value="즉시결제" >
						</li>
					</ul>
				</form>
			</div>
		</div>
		<div class="main__prod-rel">
	
		</div>
		<div class="main__prod-addInfo">
		
		</div>
	</div>
</main>

<%@ include file="/layout/footer.jsp" %>