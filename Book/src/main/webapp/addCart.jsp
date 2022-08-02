<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
%>

<script>
	function addCookie(name, value, expires) {
		
		const td = new Date();
		const str = name + "=" + value + "; path=/Movie; ";
		if(expires != null)
			str += "expires=" + td.getDate() + expires;
		
		document.cookie = str;
	}
	
	function removeCookie(name) {
		
		const td = new Date();
		const str = name + "=; path=/Movie; expires=" + td.toGMTString() + ";";
		
		document.cookie = str;
	}
	
	let code = new Date().getTime() + "_";
	
	for(let i = 0; i < 5; i++) {
		const rannum = parseInt(Math.random() * 9) + 1;
		code += rannum;
	}
	
	confirm("장바구니로 이동하시겠습니까?");
	
	if(!/song=/.test(document.cookie)) {
		addCookie("song", code);
	}
	
	location.href="cartMain.jsp";
	
</script>