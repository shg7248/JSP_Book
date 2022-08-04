<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	session.invalidate();
%>
<script type="text/javascript">
	alert("로그아웃 되었습니다");
	location.href="<%=contextPath %>/main.jsp"
</script>