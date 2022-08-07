package com.movie.dao;

import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.movie.beans.CartBean;

public class CartDao {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	private static CartDao instance = null;
	
	public static CartDao getInstance() throws NamingException, SQLException {
		if(instance == null)
			instance = new CartDao();
		return instance;
	}
	
	private CartDao() throws NamingException, SQLException {
		Context initContext = new InitialContext();
		Context envinit = (Context) initContext.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envinit.lookup("jdbc/OracleDB");
		conn = dataSource.getConnection();
	}
	
	public int insertCart(CartBean bean) {
		int cnt = -1;
		
		System.out.println("bean.getPcode() : " + bean.getPcode());
		System.out.println("bean.getQty() : " + bean.getQty());
		System.out.println("bean.getCcode() : " + bean.getCcode());
		System.out.println("bean.getMcode() : " + bean.getMcode());
		
		try {
			String sql = "{call INSERT_CART (?, ?, ?, ?)}";
			ps = conn.prepareCall(sql);
			ps.setInt(1, bean.getPcode());
			ps.setInt(2, bean.getQty());
			ps.setString(3, bean.getCcode());
			ps.setInt(4, bean.getMcode());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;		
	}
	
	public ArrayList<CartBean> getCateByCondition(String condition, String value, boolean is_login) {
		
		 ArrayList<CartBean> beans = new ArrayList<>();
		 
		 try {
			 String sql = "SELECT CCODE, CACODE, MCODE, TITLE, PRICE, SALEPRICE, QTY, TOTALPRICE, TOTALPOINT FROM(\r\n"
			 		+ "SELECT C.CCODE, C.CACODE, C.MCODE MCODE, P.TITLE, PRICE, PRICE*(1-SALE/100) SALEPRICE, C.QTY, P.PRICE*(1-SALE/100)*C.QTY TOTALPRICE, P.PRICE*0.05*C.QTY TOTALPOINT\r\n"
			 		+ "FROM BOOK_PRODUCTS P\r\n"
			 		+ "INNER JOIN BOOK_CART C\r\n"
			 		+ "ON P.PCODE = C.PCODE\r\n"
			 		+ ") WHERE " + condition + " = ?";
			 
			 if(!is_login) {
				 sql += "AND MCODE = -1";
			 }
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, value);
			 
			 rs = ps.executeQuery();
			 while(rs.next()) {
				 CartBean bean = new CartBean();
				 bean.setCcode(rs.getString("ccode"));
				 bean.setMcode(rs.getInt("mcode"));
				 bean.setTitle(rs.getString("title"));
				 bean.setPrice(rs.getInt("price"));
				 bean.setSalePrice(rs.getInt("salePrice"));
				 bean.setQty(rs.getInt("qty"));
				 bean.setTotalPrice(rs.getInt("totalPrice"));
				 bean.setTotalPoint(rs.getInt("totalPoint"));
				 bean.setCacode(rs.getInt("cacode"));
				 beans.add(bean);
			 }
			 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		 return beans;
	}
	
	public int mergeCart(CartBean bean) {
		int cnt = -1;
		
		try {
			String sql = "{call MERGE_CART(?, ?)}";
			ps = conn.prepareCall(sql);
			ps.setInt(1, bean.getMcode());
			ps.setString(2, bean.getCcode());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}
	
	public int updateCartQty(String cacode, String qty) {
		int cnt = -1;
		
		try {
			String sql = "UPDATE BOOK_CART SET QTY = ? WHERE CACODE = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, qty);
			ps.setString(2, cacode);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;	
	}
	
	public int allDelete(String[] cacode) {
		int cnt = -1;
		
		try {
			for(String code : cacode) {
				String sql = "DELETE BOOK_CART WHERE CACODE = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, code);
				cnt = ps.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;			
	}
	
	public ArrayList<CartBean> getCartByCacode(String[] cacode) {
		
		ArrayList<CartBean> beans = new ArrayList<>();
		
		String sql = "SELECT CCODE, CACODE, MCODE, TITLE, PRICE, SALEPRICE, QTY, TOTALPRICE, TOTALPOINT FROM(\r\n"
				+ "SELECT C.CCODE, C.CACODE, C.MCODE MCODE, P.TITLE, PRICE, PRICE*(1-SALE/100) SALEPRICE, C.QTY, P.PRICE*(1-SALE/100)*C.QTY TOTALPRICE, P.PRICE*0.05*C.QTY TOTALPOINT\r\n"
				+ "FROM BOOK_PRODUCTS P\r\n"
				+ "INNER JOIN BOOK_CART C\r\n"
				+ "ON P.PCODE = C.PCODE\r\n"
				+ ")\r\n"
				+ "WHERE CACODE IN (";
		for(int i = 0; i < cacode.length; i++) {
			sql += "?";
			if(i < cacode.length - 1) {
				sql += ",";
			}
		}
		sql += ")";
		
		try {
			ps = conn.prepareStatement(sql);
			for(int i = 0; i < cacode.length; i++) {
				ps.setString(i + 1, cacode[i]);
			}
			
			rs = ps.executeQuery();
			while(rs.next()) {
				 CartBean bean = new CartBean();
				 bean.setCcode(rs.getString("ccode"));
				 bean.setMcode(rs.getInt("mcode"));
				 bean.setTitle(rs.getString("title"));
				 bean.setPrice(rs.getInt("price"));
				 bean.setSalePrice(rs.getInt("salePrice"));
				 bean.setQty(rs.getInt("qty"));
				 bean.setTotalPrice(rs.getInt("totalPrice"));
				 bean.setTotalPoint(rs.getInt("totalPoint"));
				 bean.setCacode(rs.getInt("cacode"));
				 beans.add(bean);
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return beans;
	}
}
