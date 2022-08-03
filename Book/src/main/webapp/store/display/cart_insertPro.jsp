<%@page import="com.movie.dao.CartDao"%>
<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	String pcode = request.getParameter("pcode");
	String qty = request.getParameter("qty");

	///////////////////////////////CCODE 생성/////////////////////////////////	
	LocalDateTime dateTime = LocalDateTime.now();
	String time = dateTime.format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss_"));
	
	// 11111부터 99999까지 
	int random = (int)(Math.random() * 88889) + 11111;
	String ccode = time + random;
	///////////////////////////////CCODE 생성/////////////////////////////////
	
	CartBean bean = new CartBean();
	bean.setPcode(Integer.parseInt(pcode));
	bean.setQty(Integer.parseInt(qty));
	
	Cookie[] cookies = request.getCookies();
	
	boolean flag = false;
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("ccode")) {
			bean.setCcode(cookie.getValue());
			flag = true;
			break;
		}
	}
	
	// 쿠키 안에 ccode가 없으면 쿠키를 새로 만듬
	if(!flag) {
		Cookie cookie = new Cookie("ccode", ccode);
		cookie.setPath(contextPath);
		cookie.setMaxAge(60 * 60 * 24 * 7); // 7일
		response.addCookie(cookie);
		bean.setCcode(ccode);
	}
	
	if(session.getAttribute("mem") == null) {
		bean.setMcode(0);
	}
	else {
		bean.setMcode((int) session.getAttribute("mem"));
	}
	
	CartDao dao = CartDao.getInstance();
	int cnt = dao.insertCart(bean);
	
	if(cnt > 0) {
		response.sendRedirect(contextPath + "/response.jsp?type=normal&msg=하하하&url=store/display/cart_list.jsp");
	}
%>