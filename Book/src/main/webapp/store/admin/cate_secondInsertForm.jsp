<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String group = request.getParameter("group");
%>
<form method="post" action="cate_secondInsertPro.jsp">
	카테고리 그룹 : <input type="text" name="cateGroup" value="<%=group %>" readonly="readonly"/><br>
	카테고리 코드 : <input type="text" name="cateCode"/><br>
	카테고리 이름 : <input type="text" name="cateName"/><br>
	<input type="submit" value="등록">
</form>