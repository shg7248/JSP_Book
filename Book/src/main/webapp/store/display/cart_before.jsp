<%@page import="java.beans.beancontext.BeanContext"%>
<%@page import="com.movie.dao.CartDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.movie.beans.CartBean"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	CartDao dao = CartDao.getInstance();

	boolean is_cookie = false; // true : 쿠키가 있다, false : 쿠키가 없다
	String ccode = null;

	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("ccode")) {
			ccode = cookie.getValue();
			is_cookie = true;
			break;
		}
	}
	
	if(!is_cookie) { // 쿠키가 없으면 ccode 생성 후 쿠키를 넣음
		LocalDateTime dateTime = LocalDateTime.now();
		String time = dateTime.format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss_"));
		
		// 11111부터 99999까지 
		int random = (int)(Math.random() * 88889) + 11111;
		ccode = time + random;
		
		Cookie cookie = new Cookie("ccode", ccode);
		cookie.setMaxAge(60 * 60 * 24 * 7);
		cookie.setPath("/Book");
		response.addCookie(cookie);
	}
	
	// 카트에 담는 데이터를 보낼 경우 넣는다
	BufferedReader br = request.getReader();
	JSONParser parser = new JSONParser(br);
	ArrayList<Object> lists = parser.list();
	
	if(lists.size() > 0) {
		CartBean bean = new CartBean();
		bean.setCcode(ccode);
		
		if(is_login) {
			bean.setMcode(mem.getMcode());
		}
		else {
			bean.setMcode(-1);
		}			
		
		dao.insertCart(bean);
		
		for(Object o : lists) {
			String str = String.valueOf(o);
			int pcode = Integer.parseInt(str.substring(str.indexOf("=") + 1, str.indexOf(",")));
			int qty = Integer.parseInt(str.substring(str.lastIndexOf("=") + 1, str.indexOf("}")));
			bean.setPcode(pcode);
			bean.setQty(qty);
			dao.insertCartDetail(bean);
		}
	}
	
%>