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

import com.movie.beans.CartBean;
import com.movie.beans.CartDetailBean;

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
		
		try {
			String sql = "{call INSERT_CART(?, ?)}";
			ps = conn.prepareCall(sql);
			ps.setString(1, bean.getCcode());
			ps.setInt(2, bean.getMcode());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}
	
//	CREATE OR REPLACE PROCEDURE INSERT_CART
//	(
//		VCCODE BOOK_CART.CCODE%TYPE,
//		VMCODE BOOK_MEMBERS.MCODE%TYPE
//	)
//	IS
//		NUM NUMBER := 0;
//	BEGIN
//		SELECT COUNT(*) INTO NUM
//		FROM BOOK_CART
//		WHERE CCODE = VCCODE
//		AND MCODE = VMCODE;
//		
//		IF NUM = 0 THEN
//			INSERT INTO BOOK_CART (CCODE, MCODE, REG_DATE) VALUES (VCCODE, VMCODE, SYSDATE);
//		END IF;
//	END;
	
	public int insertCartDetail(CartBean bean) {
		int cnt = -1;
		
		try {
			String sql = "{call INERT_CART_DETAIL(?, ?, ?, ?)}";
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
	
//	DROP PROCEDURE INERT_CART_DETAIL;
//	CREATE OR REPLACE PROCEDURE INERT_CART_DETAIL
//	(
//		VPCODE BOOK_PRODUCTS.PCODE%TYPE,
//		VQTY BOOK_CART_DETAIL.QTY%TYPE,
//		VCCODE BOOK_CART.CCODE%TYPE,
//		VMCODE BOOK_MEMBERS.MCODE%TYPE
//	)
//	IS
//		NUM NUMBER := 0;
//	BEGIN
//		IF VMCODE = -1 THEN
//			SELECT COUNT(*) INTO NUM
//			FROM BOOK_CART_DETAIL
//			WHERE CCODE = VCCODE
//			AND PCODE = VPCODE;
//		ELSE
//			SELECT COUNT(*) INTO NUM
//			FROM BOOK_CART_DETAIL
//			WHERE PCODE = VPCODE
//			AND MCODE = VMCODE;
//		END IF;
//		
//		IF NUM = 0 THEN
//			INSERT INTO BOOK_CART_DETAIL (PCODE, MCODE, QTY, CCODE, REG_DATE) VALUES (VPCODE, VMCODE, VQTY, VCCODE, SYSDATE);
//		ELSE
//			IF VMCODE = -1 THEN
//				UPDATE BOOK_CART_DETAIL SET QTY = VQTY WHERE CCODE = VCCODE AND PCODE = VPCODE;
//			ELSE
//				UPDATE BOOK_CART_DETAIL SET QTY = VQTY WHERE PCODE = VPCODE AND MCODE = VMCODE;
//			END IF;
//		END IF;
//	END;
	
	public ArrayList<CartDetailBean> getCateByCondition(String condition, String value, boolean is_login) {
		
		 ArrayList<CartDetailBean> beans = new ArrayList<>();
		 
		 try {
			 String sql = "SELECT CCODE, MCODE, TITLE, PRICE, SALEPRICE, QTY, TOTALPRICE, TOTALPOINT FROM(\r\n"
			 		+ "SELECT C2.CCODE, C.MCODE MCODE, P.TITLE, PRICE, PRICE*(1-SALE/100) SALEPRICE, C.QTY, P.PRICE*(1-SALE/100)*C.QTY TOTALPRICE, P.PRICE*0.05*C.QTY TOTALPOINT\r\n"
			 		+ "FROM BOOK_PRODUCTS P\r\n"
			 		+ "INNER JOIN BOOK_CART_DETAIL C\r\n"
			 		+ "ON P.PCODE = C.PCODE\r\n"
			 		+ "INNER JOIN BOOK_CART C2\r\n"
			 		+ "ON C2.CCODE = C.CCODE\r\n"
			 		+ ") WHERE " + condition + " = ?";
			 
			 if(!is_login) {
				 sql += "AND MCODE = -1";
			 }
			 ps = conn.prepareStatement(sql);
			 ps.setString(1, value);
			 
			 rs = ps.executeQuery();
			 while(rs.next()) {
				 CartDetailBean bean = new CartDetailBean();
				 bean.setCcode(rs.getString("ccode"));
				 bean.setMcode(rs.getInt("mcode"));
				 bean.setTitle(rs.getString("title"));
				 bean.setPrice(rs.getInt("price"));
				 bean.setSalePrice(rs.getInt("salePrice"));
				 bean.setQty(rs.getInt("qty"));
				 bean.setTotalPrice(rs.getInt("totalPrice"));
				 bean.setTotalPoint(rs.getInt("totalPoint"));
				 beans.add(bean);
			 }
			 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		 return beans;
	}
	
	public int mergeCart(CartBean bean) {
		int cnt = -1;
		
		System.out.println("ccode" + bean.getCcode());
		System.out.println("mcode" + bean.getMcode());
		
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
	
//	DROP PROCEDURE MERGE_CART;
//	CREATE OR REPLACE PROCEDURE MERGE_CART
//	(
//		VMCODE BOOK_MEMBERS.MCODE%TYPE,
//		VCCODE BOOK_CART.CCODE%TYPE
//	)
//	IS
//		VPCODE BOOK_PRODUCTS.PCODE%TYPE := 0;
//		VPCODE2 BOOK_PRODUCTS.PCODE%TYPE := 0;
//	BEGIN
//		FOR F1 IN (SELECT * FROM BOOK_CART_DETAIL WHERE CCODE = VCCODE AND MCODE = -1) LOOP
//			VPCODE2 := F1.PCODE;
//			BEGIN
//				SELECT NVL(MAX(PCODE), 0) INTO VPCODE FROM BOOK_CART_DETAIL WHERE MCODE = VMCODE AND PCODE = F1.PCODE;
//				
//				EXCEPTION
//					WHEN NO_DATA_FOUND THEN VPCODE := 0;
//			END;
//			
//			IF VPCODE = 0 THEN
//				UPDATE BOOK_CART_DETAIL SET MCODE = VMCODE WHERE CCODE = VCCODE AND MCODE = -1 AND PCODE = VPCODE2;
//			ELSE
//				DELETE FROM BOOK_CART_DETAIL WHERE CCODE = VCCODE AND MCODE = -1 AND PCODE = VPCODE;
//			END IF;
//		END LOOP;
//	END;
}
