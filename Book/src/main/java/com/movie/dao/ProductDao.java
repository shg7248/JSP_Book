package com.movie.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.movie.beans.ProductBean;
import com.movie.util.Paging;

public class ProductDao implements Dao {

	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private static ProductDao instance = null;
	
	public static ProductDao getInstance() throws NamingException, SQLException {
		if(instance == null)
			instance = new ProductDao();
		return instance;
	}
	
	private ProductDao() throws NamingException, SQLException {
		Context initContext = new InitialContext();
		Context envinit = (Context) initContext.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envinit.lookup("jdbc/OracleDB");
		conn = dataSource.getConnection();
	}
	
	@Override
	public int getCount(Paging paging) {
		int cnt = -1;
		
		try {
			String sql = "SELECT COUNT(*) FROM BOOK_PRODUCTS WHERE " + paging.getCondition() + " LIKE ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + paging.getValue() + "%");
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return cnt; 
	}
	
	public int insertProduct(ProductBean bean) {
		int cnt = -1;
		
		try {
			String sql = 	"INSERT INTO BOOK_PRODUCTS (PCODE, TITLE, AUTHOR, CONTENT, PUBLISHER, ISBN, IDX, QTY, PRICE, SALE, CATECODE, PUB_DATE, IMAGE, REG_DATE) " +
							"VALUES(BOOK_PRODUCTS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bean.getTitle());
			ps.setString(2, bean.getAuthor());
			ps.setString(3, bean.getContent());
			ps.setString(4, bean.getPublisher());
			ps.setString(5, bean.getIsbn());
			ps.setString(6, bean.getIdx());
			ps.setInt(7, bean.getQty());
			ps.setInt(8, bean.getPrice());
			ps.setInt(9, bean.getSale());
			ps.setString(10, bean.getCatecode());
			ps.setString(11, bean.getPub_date());
			ps.setString(12, bean.getImage());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}
	
	public ArrayList<ProductBean> getAllProduct(Paging paging) {
		
		ArrayList<ProductBean> beans = null;
		
		try {
			
			String sql = "SELECT *\r\n"
						+ "FROM BOOK_PRODUCTS A\r\n"
						+ "WHERE EXISTS (SELECT PCODE\r\n"
						+ "FROM (SELECT PCODE \r\n"
						+ "FROM (SELECT PCODE, RANK() OVER (ORDER BY PCODE DESC) RANK \r\n"
						+ "FROM BOOK_PRODUCTS"
						+ " WHERE "+ paging.getCondition() +" LIKE ? "
						+ ") WHERE RANK BETWEEN ? AND ?) B WHERE A.PCODE = B.PCODE) ORDER BY PCODE DESC";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+ paging.getValue() +"%");
			ps.setInt(2, paging.getStart());
			ps.setInt(3, paging.getEnd());
			
			rs = ps.executeQuery();
			beans = putProductBeans(rs);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return beans;
	}
	
	public ArrayList<ProductBean> getAllProduct() {
		
		ArrayList<ProductBean> beans = null;
		
		try {
			
			String sql = "SELECT * FROM BOOK_PRODUCTS";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			beans = putProductBeans(rs);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return beans;
	}
	
	public ProductBean getProductByPcode(String pcode) {
		
		ProductBean bean = null;
		
		try {
			
			String sql = "SELECT * FROM BOOK_PRODUCTS WHERE PCODE = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, pcode);
			
			rs = ps.executeQuery();
			bean = putProductBean(rs);
	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return bean;
	}
	
	private ArrayList<ProductBean> putProductBeans(ResultSet rs) throws SQLException {
		
		ArrayList<ProductBean> beans = new ArrayList<>();
		
		while(rs.next()) {
			ProductBean bean = new ProductBean();
			bean.setPcode(rs.getInt("pcode"));
			bean.setTitle(rs.getString("title"));
			bean.setAuthor(rs.getString("author"));
			bean.setContent(rs.getString("content"));
			bean.setPublisher(rs.getString("publisher"));
			bean.setIsbn(rs.getString("isbn"));
			bean.setIdx(rs.getString("idx"));
			bean.setQty(rs.getInt("qty"));
			bean.setPrice(rs.getInt("price"));
			bean.setSale(rs.getInt("sale"));
			bean.setCatecode(rs.getString("catecode"));
			bean.setPub_date(String.valueOf(rs.getTimestamp("pub_date")));
			bean.setImage(rs.getString("image"));
			bean.setReg_date(String.valueOf(rs.getTimestamp("reg_date")));
			beans.add(bean);
		}
		
		return beans;
	}
	
	public int updateProduct(ProductBean bean) {
		
		int cnt = -1;
		
		try {
			String sql = "UPDATE BOOK_PRODUCTS SET TITLE = ?, AUTHOR = ?, PUBLISHER = ?, ISBN = ?, PUB_DATE = ?, QTY = ?, PRICE = ?, SALE = ?, CATECODE = ?, IDX = ?, CONTENT = ?";
			if(bean.getImage() != null) {
				sql += ", IMAGE = ?";
			}
			sql += " WHERE PCODE = ?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, bean.getTitle());
			ps.setString(2, bean.getAuthor());
			ps.setString(3, bean.getPublisher());
			ps.setString(4, bean.getIsbn());
			ps.setString(5, bean.getPub_date());
			ps.setInt(6, bean.getQty());
			ps.setInt(7, bean.getPrice());
			ps.setInt(8, bean.getSale());
			ps.setString(9, bean.getCatecode());
			ps.setString(10, bean.getIdx());
			ps.setString(11, bean.getContent());
			if(bean.getImage() != null) {
				ps.setString(12, bean.getImage());
				ps.setInt(13, bean.getPcode());
			}
			else {
				ps.setInt(12, bean.getPcode());
			}
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	private ProductBean putProductBean(ResultSet rs) throws SQLException {
		
		ProductBean bean = null;
		
		if(rs.next()) {
			bean = new ProductBean();
			bean.setPcode(rs.getInt("pcode"));
			bean.setTitle(rs.getString("title"));
			bean.setAuthor(rs.getString("author"));
			bean.setContent(rs.getString("content"));
			bean.setPublisher(rs.getString("publisher"));
			bean.setIsbn(rs.getString("isbn"));
			bean.setIdx(rs.getString("idx"));
			bean.setQty(rs.getInt("qty"));
			bean.setPrice(rs.getInt("price"));
			bean.setSale(rs.getInt("sale"));
			bean.setCatecode(rs.getString("catecode"));
			bean.setPub_date(String.valueOf(rs.getDate("pub_date")));
			bean.setImage(rs.getString("image"));
			bean.setReg_date(String.valueOf(rs.getTimestamp("reg_date")));
		}
		
		return bean;
	}
}
