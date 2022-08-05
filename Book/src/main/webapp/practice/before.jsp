<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	function insertCart() {
		const obj = [];
		document.querySelectorAll("input[name='check']:checked").forEach(function(v, i) {
			const code = v.value;
			const qty = v.dataset.qty;
			const value = document.querySelector("#"+qty).value;
			obj2 = {pcode: code, qty: value}
			obj.push(obj2);
			 
		});
		
		fetch("after.jsp", {
			 method: "post",
			 header: {
				 "Content-Type": "application/json"
			 },
			 body: JSON.stringify(obj)
		 })
		 .then(function(data) {
			 confirm("장바구니에 추가되었습니다\n이동하시겠습니까?");
		 })
	}
</script>
<form action="after.jsp">
	<input type="checkbox" name="check" value="939393" data-qty="b939393"/>하이하이
	<input type="text" id="b939393" value="1"/>
	<br>
	<input type="checkbox" name="check" value="919191" data-qty="b919191"/>하이하이
	<input type="text" id="b919191" value="1"/>
	<br>
	<input type="checkbox" name="check" value="848484"/>하이하이
	<input type="text" value="1"/>
	<br>
	<input type="button" value="장바구니 담기" onclick="insertCart()">
	<input type="submit" value="클릭" onclick="insertCart()"/>
</form>
<form>
	
</form>