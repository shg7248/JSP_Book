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
<script>
	function showSecondCate(group) {
		
		document.querySelector('.cate2').innerHTML = "";
		
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
				let option = document.createElement('option');
				option.setAttribute('value', data[i].cateCode);
				option.innerHTML = data[i].cateName;
				document.querySelector('.cate2').append(option);
			}
		});
	 }
</script>
<main class="main">
	<div class="main__inner">
		<form method="post" action="prod_insertPro.jsp" name="mainform" enctype="multipart/form-data">
			상품이름 : <input type="text" name="title"><br>
			저자 : <input type="text" name="author"><br>
			출판사 : <input type="text" name="publisher"><br>
			ISBN : <input type="text" name="isbn"><br>
			출간일 : <input type="text" name="pub_date"><br>
			재고 : <input type="text" name="qty"><br>
			가격 : <input type="text" name="price"><br>
			세일 : <input type="text" name="sale"><br>
			카테고리 :
			1차분류 
			<select name="cate1" onchange="showSecondCate(this.value)">
			<% 
				for(CategoryBean bean : beans) {
					out.print("<option value= " + bean.getCateCode() + ">" + bean.getCateName() + "</option>");
				}
			%>
			</select>
			
			2차분류
			<select name="cate2" class="cate2">
				
			</select><br>
			목차 : <input type="text" name="idx"><br>
			내용 : <input type="text" name="content"><br>
			이미지 : <input type="file" name="image">
			<input type="submit" value="등록">
		</form>
    </div>
</main>
