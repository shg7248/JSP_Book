<%@page import="com.movie.beans.ProductBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.movie.dao.ProductDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp"%>
<%
	ProductDao dao = ProductDao.getInstance();

	String saveDirectory = config.getServletContext().getRealPath("/store/images");
	
	File file = new File(saveDirectory);
	if(!file.exists())
		file.mkdir();
	
	int size = 1024 * 1024 * 5;
	
	String enctype = "utf-8";
	
	MultipartRequest mul = 
			new MultipartRequest(request, saveDirectory, size, enctype, new DefaultFileRenamePolicy());
	
	ProductBean bean = new ProductBean();
	bean.setTitle(mul.getParameter("title"));
	bean.setAuthor(mul.getParameter("author"));
	bean.setPublisher(mul.getParameter("publisher"));
	bean.setIsbn(mul.getParameter("isbn"));
	bean.setPub_date(mul.getParameter("pub_date"));
	bean.setQty(Integer.parseInt(mul.getParameter("qty")));
	bean.setPrice(Integer.parseInt(mul.getParameter("price")));
	bean.setSale(Integer.parseInt(mul.getParameter("sale")));
	
	String cate1 = mul.getParameter("cate1");
	String cate2 = mul.getParameter("cate2");
	bean.setCatecode(cate1 +  cate2);
	
	bean.setIdx(mul.getParameter("idx"));
	bean.setContent(mul.getParameter("content"));
	bean.setImage(mul.getFilesystemName("image"));
	
	int cnt = dao.insertProduct(bean);
	
	String msg = null;
	String url = null;
	String type = null;
	if(cnt > 0) {
		msg = "도서 입력에 성공했습니다";
		url = "store/admin/prod_List.jsp";
		type = "normal";
		
	}
	response.sendRedirect(contextPath + "/response.jsp?type=" + type + "&msg=" + msg+"&url="+url);

%>