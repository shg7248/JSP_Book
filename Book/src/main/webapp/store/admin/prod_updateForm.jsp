<%@page import="com.movie.beans.ProductBean"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@page import="com.movie.beans.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<%
	String pcode = request.getParameter("pcode");

	CategoryDao dao = CategoryDao.getInstance();
	ArrayList<CategoryBean> beans = dao.getAllCategorys();
	
	ProductDao pdao = ProductDao.getInstance();
	ProductBean pb = pdao.getProductByPcode(pcode);
	
	String cate1 = pb.getCatecode().substring(0, 2);
	String cate2 = pb.getCatecode().substring(2,4);
%>
<script>

	window.addEventListener("load", function() {
		showSecondCate("01");
	})

	function showSecondCate(group) {
		
		const cate2 = '<%=cate2 %>';
		
		document.querySelector('.prod-form__cate2').innerHTML = "";
		
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
			if(data.length == 0) {
				document.querySelector('.prod-form__cate2').innerHTML = "카테고리 없음";
			}
			let select = document.createElement("select");
			select.setAttribute("name", "cate2");
			for(let i in data) {
				let option = document.createElement('option');
				option.setAttribute('value', data[i].cateCode);
				option.innerHTML = data[i].cateName;
				if(cate2 == data[i].cateCode) {
					option.selected = true;
				}
				select.append(option);
				document.querySelector('.prod-form__cate2').append(select);
			}
		});
	 }
</script>
<style>
	.prod-form__title {
		text-align: left;
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 20px;
	}
	.prod-form__table {
		width: 80%;
		margin: 0 auto;
	}
	.prod-form__table th, .prod-form__table td{
		border: 1px solid #DCDCDC;
	}
	.prod-form__table input, .prod-form__table select {
		border: 0px;
		height: 30px;
		line-height: 30px;
	}
	.prod-form__table input {
		font-size: 16px;
	}
	.prod-form__table th {
		font-size: 15px;
		width: 200px;
		background: #6495ED;
		color: white;
		vertical-align: middle;
	}
	.prod-form__cate select {
		width: 100%;
	}
	.prod-form textarea {
		width: 100%; height: 150px;
		border: 0px;
	}
	.prod-form textarea:focus {
		outline: none;
	}
}
</style>
<main class="main">
	<div class="main__inner">
		<form method="post" action="prod_updatePro.jsp" name="mainform" enctype="multipart/form-data" class="prod-form">
		<input type="hidden" name="pcode" value="<%=pb.getPcode() %>">
			<table class="prod-form__table">
				<caption class="prod-form__title">상품 등록</caption>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="title" value="<%=pb.getTitle() %>"></td>
					<th>저자</th>
					<td><input type="text" name="author" value="<%=pb.getAuthor() %>"></td>
				</tr>
				<tr>
					<th>출판사</th>
					<td><input type="text" name="publisher" value="<%=pb.getPublisher() %>"></td>
					<th>ISBN</th>
					<td><input type="text" name="isbn" value="<%=pb.getIsbn() %>"></td>
				</tr>
				<tr>
					<th>출간일</th>
					<td><input type="text" name="pub_date" value="<%=pb.getPub_date() %>"></td>
					<th>재고</th>
					<td><input type="text" name="qty" value="<%=pb.getQty() %>"></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="text" name="price" value="<%=pb.getPrice() %>"></td>
					<th>세일</th>
					<td><input type="text" name="sale" value="<%=pb.getSale() %>"></td>
				</tr>
				<tr>
					<th>1차 분류</th>
					<td class="prod-form__cate prod-form__cate1">
						<select name="cate1" class="" onchange="showSecondCate(this.value)">
						<% 
							for(CategoryBean bean : beans) {
								// out.print("<option value= " + bean.getCateCode() + ">" + bean.getCateName() + "</option>");
							%>
								<option value="<%=bean.getCateCode() %>" <% if(bean.getCateCode().equals(cate1)) { %> selected <% } %>><%=bean.getCateName() %></option>
							<%
							}
						%>
						</select>	
					</td>
					<th>2차 분류</th>
					<td class="prod-form__cate prod-form__cate2"></td>
				</tr>
				<tr>
					<th>목차</th>
					<td colspan=3 class="prod-form__idx"><textarea rows="0" cols="0" name="idx" ><%=pb.getIdx() %></textarea></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan=3 class="prod-form__content"><textarea rows="0" cols="0" name="content"><%=pb.getContent() %></textarea></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td colspan=3 class="prod-form__image"><input type="file" name="image"></td>
				</tr>
				<tr>
					<td colspan=4><input type="submit" value="수정"></td>
				</tr>
			</table>
		</form>
    </div>
</main>