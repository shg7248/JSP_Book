<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	BufferedReader br = request.getReader();
	JSONParser parser = new JSONParser(br); 
	
	LinkedHashMap<String, String> items = new LinkedHashMap<>();
	
	ArrayList<Object> objs = parser.list();
	
	System.out.println(objs.size());
	
	for(Object obj : objs) {
		String str = String.valueOf(obj);
		
		String pcode = str.substring(str.indexOf("=") + 1, str.indexOf(","));
		String qty = str.substring(str.lastIndexOf("=") + 1, str.indexOf("}"));
		
		items.put(pcode, qty);
	}
	
	
%>