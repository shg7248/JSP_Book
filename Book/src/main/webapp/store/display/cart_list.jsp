<%@page import="java.text.DecimalFormat"%>
<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CartDao"%>
<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
CartDao dao = CartDao.getInstance();
	String condition = null;
	String value = null;
	
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("ccode")) {
	value = cookie.getValue();
	break;
		}
	}
	
	if(!is_login) { // 비회원일 경우
		condition = "ccode";
	}
	else { // 회원일 경우
		condition = "mcode";
		value = String.valueOf(mem.getMcode());
		
		// 이후 쿠키 삭제
		Cookie cookie = new Cookie("ccode", null);
		cookie.setMaxAge(0);
		cookie.setPath("/Book");
		response.addCookie(cookie);
	}
	
	ArrayList<CartBean> beans= dao.getCateByCondition(condition, value, is_login);
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
</style>
<script type="text/javascript">
	function allcheck(ch) {
		const rowcheck = document.querySelectorAll('input[name="rowcheck"]');
		rowcheck.forEach(function(ele, i) {
			if(ch.checked) {
				ele.checked = true;
			}
			else {
				ele.checked = false;
			}
		});
	}
	
	function alldelete() {
		
		const rowcheck = document.querySelectorAll('input[name="rowcheck"]:checked');
		
		if(rowcheck.length == 0) {
			alert("상품을 한개라도 선택하세요");
			return;
		}
		
		const form = document.createElement("form");
		form.method = "post";
		form.action = "cart_allDeletePro.jsp";
	
		rowcheck.forEach(function(ele, i) {
			let hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "cacode");
			hiddenField.setAttribute("value", ele.value);
			form.appendChild(hiddenField);
		});
		
		document.body.append(form);
		form.submit();
		
	}
	
	function cartOrders() {
		
		const cacode = document.querySelectorAll("input[name='cacode']");
		
		if(cacode.length == 0) {
			alert("장바구니에 상품이 존재하지 않습니다.");
			return;
		}
		
		const form = document.createElement("form");
		form.method = "post";
		form.action = "cart_orders.jsp";
		
		cacode.forEach(function(ele, i) {
			let hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "cacode");
			hiddenField.setAttribute("value", ele.value);
			form.appendChild(hiddenField);
		});
		
		document.body.append(form);
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
					<strong><%=beans.size()%>개의 상품이 장바구니에 담겨져 있습니다</strong>
				</div>
				<table class="cart__table">
					<thead>
						<tr class="cart__list">
							<th><input type="checkbox" onclick="allcheck(this)"></th>
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
								<td><input type="checkbox" name="rowcheck" value="<%=bean.getCacode() %>"></td>
								<td><%=bean.getTitle() %></td>
								<td><%=df.format(bean.getPrice()) %></td>
								<td><%=df.format(bean.getSalePrice()) %>원</td>
								<td>
									<form method="post" action="cart_updatePro.jsp">
										<input type="hidden" name="cacode" value="<%=bean.getCacode() %>">
										<input type="text" name="qty" value="<%=bean.getQty() %>" size=4>
										<input type="submit" value="수정"/>
									</form>
								</td>
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
					<tfoot>
						<tr class="cart__list">
							<td colspan=7 class="cart__totalPrice cart__total">
								총 금액 : <%=df.format(totalPrice) %> 원
							</td>
						</tr>
						<tr class="cart__list">
							<td colspan=7 class="cart__totalPoint cart__total">
								총 포인트 : <%=df.format(totalPoint) %> 원
							</td>
						</tr>
						<tr class="cart__list">
							<td colspan=7 class="cart__button">
								<a href="javascript:alldelete()" class="cart__delbtn">선택삭제</a>
								<a href="javascript:cartOrders()" class="cart__orderbtn" >주문하기</a>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</main>

<%@ include file="/layout/footer.jsp" %>