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
			String sql = "{call CART_UPDATE(?, ?, ?, ?)}";
			ps = conn.prepareCall(sql);
			ps.setString(1, bean.getCcode());
			ps.setInt(2, bean.getPcode());
			ps.setInt(3, bean.getMcode());
			ps.setInt(4, bean.getQty());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		
		return cnt;
	}
	
//	CREATE OR REPLACE PROCEDURE CART_UPDATE
//	(
//		VCCODE BOOK_CART.CCODE%TYPE,
//		VPCODE BOOK_CART.PCODE%TYPE,
//		VMCODE VARCHAR2,
//		VQTY NUMBER
//	)
//	IS
//	CNT NUMBER := 0;
//	BEGIN
//
//	    BEGIN
//		    SELECT COUNT(*)
//		    INTO CNT
//		    FROM BOOK_CART
//		    GROUP BY CCODE, PCODE
//		    HAVING CCODE = VCCODE
//		    AND PCODE = VPCODE;
//	
//		    EXCEPTION
//		        WHEN NO_DATA_FOUND THEN CNT := 0;
//	    END;
//
//	    IF CNT = 0 THEN
//	    		INSERT INTO BOOK_CART (CCODE, PCODE, MCODE, QTY, REG_DATE)
//	    		VALUES (VCCODE, VPCODE, VMCODE, VQTY, SYSDATE);
//	    ELSE
//	    	UPDATE BOOK_CART SET QTY = QTY + VQTY WHERE CCODE = VCCODE AND PCODE = VPCODE;
//	    END IF;
//	END;
	
	public ArrayList<CartDetailBean> getCateByCondition(String condition, String value, boolean is_login) {
		
		 ArrayList<CartDetailBean> beans = new ArrayList<>();
		 
		 try {
			 String sql = "SELECT CCODE, MCODE, TITLE, PRICE, SALEPRICE, QTY, TOTALPRICE, TOTALPOINT\r\n"
			 		+ "FROM(SELECT B.CCODE, B.MCODE, A.TITLE, A.PRICE, A.PRICE * (1 - A.SALE / 100) SALEPRICE, B.QTY, A.PRICE * (1 - A.SALE / 100) * B.QTY TOTALPRICE, A.PRICE * 0.05 * B.QTY TOTALPOINT\r\n"
			 		+ "FROM BOOK_PRODUCTS A\r\n"
			 		+ "INNER JOIN BOOK_CART B\r\n"
			 		+ "ON A.PCODE = B.PCODE\r\n"
			 		+ ") WHERE " + condition + " = ?";
			 
			 if(!is_login) {
				 sql += "AND MCODE = 0";
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
	
	public int updateMcode(String ccode, String mcode) {
		
		int cnt = -1;
		
		try {
			String sql = "{call CART_UPDATE2(?, ?)}";
			ps = conn.prepareCall(sql);
			ps.setString(1, mcode);
			ps.setString(2, ccode);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}
	
//	CREATE OR REPLACE PROCEDURE CART_UPDATE2 
//	(
//		VMCODE BOOK_MEMBERS.MCODE%TYPE,
//		VCCODE BOOK_CART.CCODE%TYPE
//	)
//	IS
//	BEGIN
//		FOR PROD IN (SELECT * FROM BOOK_CART WHERE CCODE = VCCODE) LOOP
//			FOR P IN (SELECT * FROM BOOK_CART WHERE MCODE = VMCODE AND PCODE = PROD.PCODE) LOOP
//				UPDATE BOOK_CART SET QTY = QTY + PROD.QTY WHERE MCODE = VMCODE AND PCODE = P.PCODE;
//				DELETE BOOK_CART WHERE CCODE = VCCODE AND PCODE = PROD.PCODE;
//			END LOOP;
//		END LOOP;
//		
//		UPDATE BOOK_CART SET MCODE = VMCODE WHERE CCODE = VCCODE AND MCODE = 0;
//	END;
}
