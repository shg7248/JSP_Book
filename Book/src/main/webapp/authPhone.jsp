<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	HashMap<String, String> auth = new HashMap<>();
	auth.put("송학관", "01012345678");
	auth.put("송아영", "01098765432");

	BufferedReader reader = request.getReader();
	JSONParser parser = new JSONParser(request.getReader());
	HashMap<String, Object> json = parser.object();
	
	String name = (String) json.get("name");
	String phone = (String) json.get("phone");
	
	if(auth.containsKey(name) && auth.get(name).equals(phone)) {
		out.print("{\"result\":\"success\"}");
	}
	else {
		out.print("{\"result\":\"fail\"}");
	}
%>	

