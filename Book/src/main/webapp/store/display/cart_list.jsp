<%@page import="java.text.DecimalFormat"%>
<%@page import="com.movie.beans.CartDetailBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CartDao"%>
<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/top.jsp" %>
<%
	DecimalFormat df = new DecimalFormat("###,###");
	CartDao dao = CartDao.getInstance();
	String condition = null;
	String value = null;
	
	String cookieValue = null;
	Cookie[] cookies = request.getCookies();
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
		if(value != null) { // ccode라는 쿠키가 있을 경우 MCODE를 회원의 MCODE로 업데이트
			String mcode = String.valueOf(mem.getMcode());
			dao.updateMcode(value, mcode);
		}
		condition = "mcode";
		value = String.valueOf(mem.getMcode());
	}
	
	ArrayList<CartDetailBean> beans= dao.getCateByCondition(condition, value, is_login);
%>
<style>
	.info {
		width: 100%;
		height: 120px;
		border: 1px solid black;
	}
	.cart__list {
		width: 100%;
		text-align: center;
		font-size: 11px;
	}
</style>
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
					<strong><%=beans.size() %>개의 상품이 장바구니에 담겨져 있습니다</strong>
				</div>
				<table class="cart__list">
					<thead>
						<tr class="cart__item">
							<th><input type="checkbox"></th>
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
							for(CartDetailBean bean : beans) {
							%>
							<tr class="cart__item">
								<td><input type="checkbox"></td>
								<td><%=bean.getTitle() %></td>
								<td><%=df.format(bean.getPrice()) %></td>
								<td><%=df.format(bean.getSalePrice()) %>원</td>
								<td>
									<form>
										<input type="text" value="<%=bean.getQty() %>" size=4>
										<input type="submit" value="수정" />
									</form>
								</td>
								<td>
									<%=df.format(bean.getTotalPrice()) %>원
								</td>
								<td>
									<%=df.format(bean.getTotalPoint()) %>포인트
								</td>
							</tr>
							<%
							}
						%>
					</tbody>
					<tfoot>
						<tr class="cart__item">
							<td colspan=7><input type="button" value="주문하기"></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</main>

<%@ include file="/layout/footer.jsp" %>