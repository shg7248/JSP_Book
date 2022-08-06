<%@page import="com.movie.dao.MemberDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	JSONParser parser = new JSONParser(request.getReader());
	HashMap<String, Object> map = parser.object();
	String mid = String.valueOf(map.get("mid"));
	
	MemberDao dao = MemberDao.getInstance();
	boolean is_mcode = dao.isMemberCode(mid);
	
	out.print("{\"data\":\"" + is_mcode + "\"}");
%>