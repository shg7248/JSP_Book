<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	String[][] msgArray = {
			{"회원님 환영합니다", "정보를 잘못 입력하셨습니다"},
			{"1차 카테고리가 추가되었습니다", "2차 카테고리가 추가되었습니다"}
	};

	String msg = request.getParameter("msg");
	String url = request.getParameter("url");
	String type = request.getParameter("type");
	
	String[] sdf = msg.split(" ");
	String mmsg = msgArray[Integer.parseInt(sdf[0])][Integer.parseInt(sdf[1])];
%>
	<script>alert('<%=mmsg %>')</script>
<%
	System.out.println(type);
	if(type.equals("pop")) {
%>
	<script>
		window.opener.location.reload(true);
		window.self.close();
	</script>
<%
	}
	else {
%>
	<script>location.href="<%=contextPath +  "/" + url%>"</script>
<%
	}
%>