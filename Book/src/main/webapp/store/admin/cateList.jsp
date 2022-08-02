<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/admin/top.jsp"%>
<style>
    .main__inner {
        width: 100%;
        padding-top: 120px;
        background: rgb(227, 255, 186);
    }
</style>
<script type="text/javascript">
	function fistCateAdd() {
		open('firstCateAddForm.jsp', '1차 카테고리 추가', 'width=500; height=500')
	}	
</script>
<main class="main">
	<div class="main__inner">
       	1차 카테고리
       	<input type="button" value="추가" onclick="fistCateAdd()"/>
       	<hr>
       	2차 카테고리
       	<input type="button" value="추가" />
    </div>
</main>