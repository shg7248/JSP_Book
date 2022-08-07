<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	function checksubmit(cateCode, cateName, cateUrl) {
		if(cateCode.value.length == 0 || cateCode.value.trim() == "") {
			alert("카테고리 코드를 입력하세요");
			return false;
		}
		if(isNaN(cateCode.value)) {
			alert("숫자만 입력해야 합니다");
			return false;
		}
		if(cateName.value.length == 0 || cateName.value.trim() == "") {
			alert("카테고리 이름을 입력하세요");
			return false;
		}
		if(cateUrl.value.length == 0 || cateUrl.value.trim() == "") {
			alert("카테고리 url을 입력하세요");
			return false;
		}
	}
</script>
<form method="post" action="cate_firstInsertPro.jsp">
	<table>
		<tr>
			<th>카테고리 코드</th>
			<td><input type="text" name="cateCode"/></td>
		</tr>
		<tr>
			<th>카테고리 이름</th>
			<td><input type="text" name="cateName"/></td>
		</tr>
		<tr>
			<th>카테고리 url</th>
			<td><input type="text" name="cateUrl" /></td>
		</tr>
	</table>
	<input type="submit" value="등록" onclick="return checksubmit(cateCode, cateName, cateUrl)">
</form>
