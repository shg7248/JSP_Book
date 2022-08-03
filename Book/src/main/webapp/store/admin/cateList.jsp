<%@page import="com.movie.beans.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<%
	CategoryDao dao = CategoryDao.getInstance();
	ArrayList<CategoryBean> beans = dao.getAllCategorys();
%>
<style>
    .main__inner {
        width: 100%;
        padding-top: 120px;
        background: rgb(227, 255, 186);
    }
</style>
<script type="text/javascript">

	let cateGroup = '01';

	function fistCateAdd() {
		window.open('cate_firstInsertForm.jsp', '1차 카테고리 추가', 'width=500; height=500');
	}
	
	function secondCateAdd() {
		window.open('cate_secondInsertForm.jsp?group=' + cateGroup, '2차 카테고리 추가', 'width=500; height=500');
	}
	
	function showSecondCate(group) {
		
		document.querySelector('.twocate').innerHTML = "";
		
		const url = "cate_getSecondPro.jsp";
		const obj = {
			group: group
		}
		const data = {
				method: 'POST',
				headers: {
				    "Content-Type": "application/json",
				},
				body: JSON.stringify(obj)
		}
		
		fetch(url, data)
		.then((response) => {
			return response.json();
		})
		.then((data) => {
			
			cateGroup = group;
			
			for(let i in data) {
				let taga = document.createElement('a');
				taga.setAttribute('href', 'javascript: void(0)');
				taga.innerHTML = data[i].cateName;
				document.querySelector('.twocate').append(taga);
			}
		});
	}
</script>
<main class="main">
	<div class="main__inner">
       	1차 카테고리
       	<input type="button" value="추가" onclick="fistCateAdd()"/><br>
       	<%
       	for(CategoryBean bean : beans) {
       		out.print("<a href='javascript:void(0)' onclick='showSecondCate(\"" + bean.getCateCode() + "\")'>" + bean.getCateName() + "</a>");
       		out.print("<input type='button' value='수정'><br>");
       	}
       	%>
       	<hr>
       	2차 카테고리
       	<input type="button" value="추가" onclick="secondCateAdd()">
       	<div class="twocate">
       	
       	</div>
    </div>
</main>