<%@page import="com.movie.beans.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CategoryDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/* 
	BufferedReader reader = request.getReader();
	String group = reader.readLine();
	System.out.println(group);
*/

	request.setCharacterEncoding("utf-8");
	String contextPath = request.getContextPath();

	JSONParser parse = new JSONParser(request.getReader());
	HashMap<String, Object> map = parse.object();
	String groupCode = String.valueOf(map.get("group"));
	
	CategoryDao dao = CategoryDao.getInstance();	
	ArrayList<CategoryBean> beans = dao.getAllCategorys(groupCode);

	int i = 0;
	String str = "[";
	for(CategoryBean bean : beans) {
		i++;
		str += "{\"cateCode\":\"" + bean.getCateCode() + "\",";
		str += "\"cateGroup\":\"" + bean.getCateGroup() + "\",";
		str += "\"cateName\":\"" + bean.getCateName() + "\",";
		str += "\"reg_date\":\"" + bean.getReg_date() + "\"}";
		if(i == beans.size()) {
			break;
		}
		else {
			str += ",";
		}
	}
	str += "]";
	out.print(str);
%>