<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	String[] cacode = request.getParameterValues("cacode");

	CartDao dao = CartDao.getInstance();
	ArrayList<CartBean> beans = dao.getCartByCacode(cacode); 
%>
<style type="text/css">
	.info {
		width: 100%;
		height: 120px;
		border: 1px solid black;
	}
	.cart__title{
		padding: 20px 0;
		font-size: 20px;
		font-weight: bold;
	}
	.cart__table {
		width: 100%;
		text-align: center;
		font-size: 11px;
	}
	.cart__list {
	
	}
	.cart__list .price {
		color: red;
	}
	.cart__list td, .cart__list th {
		padding: 10px;
		border-bottom: 1px solid #DCDCDC;
	}
	.cart__total {
		text-align: right;
		font-size: 20px;
	}
	.cart__delbtn {
		float: left;
	}
	.cart__orderbtn {
		float: right;
	}
	.cart__button a {
		width: 100px;
		height: 30px;
		background: #00BFFF;
		line-height: 30px;
		font-size: 16px;
		color: white;
	}
	
	.ord-form__buyer {
		padding: 30px 20px;
		margin-top: 30px;
		width: 100%;
		border: 1px solid #DCDCDC;
	}
	.ord-form__buyer h1 {
		padding: 20px 0;
		font-size: 20px;
		font-weight: bold;		
	}
	.ord-form__buyer td {
		padding: 10px;
	}
	
	.ord-form__buyer th {
		text-align: right;
	}
	
	.ord-form__addr {
		padding: 30px 20px;
		margin-top: 30px;
		width: 100%;
		border: 1px solid #DCDCDC;
	}
	.ord-form__addr h1 {
		padding: 20px 0;
		font-size: 20px;
		font-weight: bold;		
	}
	.ord-form__addr td {
		padding: 10px;
	}
	
	.ord-form__addr th {
		text-align: right;
	}
	
	.order-price {
		font-size: 20px;
		font-weight: bold;
		line-height: 30px;
		float: right;
	}
	.order-price .price {
		color: red;
	}
	.cart__orderbtn {
		display: inline-block;
		width: 100px;
		height: 50px;
		color: white;
		background: #1E90FF;
		text-align: center;
		line-height: 50px;
		clear: both;
	}
</style>
<script>
	function cartOrders() {
		const form = window.document.forms[1];
		
		form.submit();
	}
</script>
<main class="main">
	<div class="main__inner">
		<div class="main__info">
			<div class="info">
				<img>
			</div>
		</div>
		<div class="main__cart">
			<div class="cart">
				<div class="cart__title">
					<strong>주문상품 확인</strong>
				</div>
				<table class="cart__table">
					<thead>
						<tr class="cart__list">
							<th width=30%>상품명</th>
							<th>정가</th>
							<th>판매가</th>
							<th>수량</th>
							<th>합계</th>
							<th>포인트</th>
						</tr>
					</thead>
					<tbody>
						<%
						int totalPrice = 0;
						int totalPoint = 0;
						if(beans.size() == 0) {
							%>
								<tr class="cart__list">
									<td colspan=7 class="">담겨져있는 상품이 없습니다</td>
								</tr>
							<%
						}
						else {
						for(CartBean bean : beans) {
							totalPrice += bean.getTotalPrice();
							totalPoint += bean.getTotalPoint();
						%>
							<tr class="cart__list">
								<td><%=bean.getTitle() %></td>
								<td><%=df.format(bean.getPrice()) %></td>
								<td><%=df.format(bean.getSalePrice()) %>원</td>
								<td><%=bean.getQty() %></td>
								<td>
									<span class="price"><%=df.format(bean.getTotalPrice()) %></span> 원
								</td>
								<td>
									<%=df.format(bean.getTotalPoint()) %>포인트
								</td>
							</tr>
							<%
							}}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<div class="main__ord-mem">
			<form class="ord-form" action="order_ordersPro.jsp" method="post">
				<%
				for(String code : cacode) {
					%>
					<input type="hidden" name="cacode" value="<%=code %>">
					<%
				}
				%>
				<div class="ord-form__buyer">
					<h1>구매자 정보</h1>
					<table class="ord-mem__table">
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="buyerName"/>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<input type="text" name="buyerPhone"/>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="buyerEmail"/>
							</td>
						</tr>
						<%
							if(mem == null) {
						%>
						<tr>
							<th>주문 비밀번호</th>
							<td>
								<input type="text" name="buyerPwd"/>
							</td>
						</tr>
						<%
							}
						%>
					</table>
				</div>
				<div class="ord-form__addr">
					<h1>배송지</h1>
					<table class="ord-form__table">
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="addrName"/>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<input type="text" name="addrPhone"/>
							</td>
						</tr>
						<tr>
							<th>배송주소</th>
							<td>
								<input type="text" name="zip"/ placeholder="우편번호"><br>
								<input type="text" name="addr1" placeholder="주소1"/><br>
								<input type="text" name="addr2" placeholder="주소2"/>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<div>
			<div class="order-price">
				총 금액 : <span class="price"><%=df.format(totalPrice) %></span> 원<br>
				총 포인트 : <%=df.format(totalPoint) %> 원
			</div>
			<div>
				<a href="javascript:cartOrders()" class="cart__orderbtn" >결제하기</a>
			</div>
		</div>
	</div>
</main>

<%@ include file="/layout/footer.jsp" %>