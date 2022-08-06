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
<script type="text/javascript">

	let cateGroup = '01';

	window.addEventListener("load", function() {
		showSecondCate(cateGroup);
	})
	
	function fistCateAdd() {
		window.open('cate_firstInsertForm.jsp', '1차 카테고리 추가', 'width=500; height=500');
	}
	
	function secondCateAdd() {
		window.open('cate_secondInsertForm.jsp?group=' + cateGroup, '2차 카테고리 추가', 'width=500; height=500');
	}
	
	function showSecondCate(group) {
		
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
			let html = "";
			if(data.length == 0) {
				html = "<tr><td class='category__content'><a href='javascript:void(0)'>카테고리가 존재하지 않습니다.</a></td></tr>";
				document.querySelector('.category__table--second tbody').innerHTML = html;
			}
 			data.forEach(function(ele, i) {
	 			html += "<tr><td class='category__content'><a href='javascript:void(0)' onclick='showSecondCate("+ ele.cateCode +"')'>"+ ele.cateName +"</a></td></tr>";
	 			document.querySelector('.category__table--second tbody').innerHTML = html;
 			});
		});
	};
</script>
<style>
    .category__item {
    	width: 50%;
    	float: left;
    }
    .category__table {
    	width: 100%;
    	text-align: center;
    }
    .category__table td:not(.category__addbutton) {
    	border-bottom: 1px solid #DCDCDC;
    }
    .category__title {
    	border-bottom: 1px solid #DCDCDC;
    	padding: 20px 0 ;
    	font-size: 20px;
    	font-weight: bold;
    }
    .category__addbutton a {
    	display: inline-block;
    	width: 100%;
    	height: 50px;
    	line-height: 50px;
    	background: #1E90FF;
    	color: white;
    }
    .category__content {
    }
    .category__content a {
    	display: inline-block;
    	height: 50px;
    	line-height: 50px;
    	width: 100%;
    }
    .category__content.on a {
    	background: #00BFFF;
    	color: white;
    }
</style>
<main class="main">
	<div class="main__inner">
		<div class="category">
			<ul class="category__list">
				<li class="category__item category__item--first">
					<table class="category__table">
						<caption class="category__title">1차 카테고리</caption>
						<%
							if(beans.size() == 0) {
								%>
								<tr>
					       			<td class="category__content">
					       				<a href="javascript:void(0)">카테고리가 존재하지 않습니다.</a>
					       			</td>
					       		</tr>
								<%
							}
					       	for(CategoryBean bean : beans) {
					       		%>
					       		<tr>
					       			<td class="category__content">
					       				<a href='javascript:void(0)' onclick='showSecondCate("<%=bean.getCateCode() %>")'><%=bean.getCateName() %></a>
					       			</td>
					       		</tr>
					       		<%
					       	}
					    %>
					    <tr>
					    	<td class="category__addbutton">
					    		<a href="javascript:fistCateAdd()">추가하기</a>
					    	</td>
					    </tr>
					</table>
				</li>
				<li class="category__item category__item--second">
					<table class="category__table category__table--second">
						<caption class="category__title">2차 카테고리</caption>
						<tbody></tbody>
					</table>
				</li>
			</ul>
		</div>
    </div>
</main>
<script type="text/javascript">
	document.querySelectorAll(".category__item--first .category__content").forEach(function(ele, i) {
		ele.addEventListener("click", function(event) {
			const on = document.querySelector(".category__item--first .category__content.on");
			if(on != null)
				on.classList.remove("on");
			event.target.parentNode.classList.add("on");
		})
	});
</script>