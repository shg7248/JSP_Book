package com.movie.dao;

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

import com.movie.beans.OrdersBean;
import com.movie.util.Paging;

public class OrdersDao implements Dao {

	private Connection conn = null;
	private CallableStatement cs = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private static OrdersDao instance = null;
	
	public static OrdersDao getInstance() throws NamingException, SQLException {
		if(instance == null)
			instance = new OrdersDao();
		return instance;
	}
	
	private OrdersDao() throws NamingException, SQLException {
		Context initContext = new InitialContext();
		Context envinit = (Context) initContext.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envinit.lookup("jdbc/OracleDB");
		conn = dataSource.getConnection();
	}
	
	public int insertOrder(OrdersBean bean) {
		
		int ocode = -1;

		try {
			cs = conn.prepareCall("{call BOOK_ORD(?, ?, ?, ?, ?, ?)}");
			cs.setInt(1, bean.getMcode());
			cs.setString(2, bean.getName());
			cs.setString(3, bean.getEmail());
			cs.setString(4, bean.getPhone());
			cs.setString(5, bean.getPwd());
			cs.registerOutParameter(6, Types.NUMERIC);
			
			cs.execute();
			
			ocode = cs.getInt(6);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(cs);
		}
		
		return ocode;
	}
	
	public int insertOrderDetail(String cacode, int ocode) {
		
		int cnt = -1;
		
		try {
			String sql = "{call BOOK_ORD_DET(?, ?)}";
			ps = conn.prepareCall(sql);
			ps.setString(1, cacode);
			ps.setInt(2, ocode);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}

	@Override
	public int getCount(Paging paging) {
		
		int cnt = -1;
		
		String sql = "SELECT COUNT(*)\r\n"
				+ "FROM(SELECT RANK() OVER (ORDER BY O.REG_DATE DESC) RANK, A.OCODE, O.NAME, O.EMAIL, O.PHONE, A.TOTALPRICE, A.TOTALPOINT, O.REG_DATE\r\n"
				+ "FROM BOOK_ORDERS O\r\n"
				+ "INNER JOIN \r\n"
				+ "(SELECT OD.OCODE, SUM(P.PRICE*(1-P.SALE/100)*OD.QTY) TOTALPRICE, SUM(P.PRICE*0.05*OD.QTY) TOTALPOINT\r\n"
				+ "FROM BOOK_ORDERS_DETAIL OD\r\n"
				+ "INNER JOIN BOOK_PRODUCTS P\r\n"
				+ "ON OD.PCODE = P.PCODE\r\n"
				+ "GROUP BY OD.OCODE) A\r\n"
				+ "ON O.OCODE = A.OCODE WHERE "+paging.getCondition()+" LIKE ?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, paging.getValue());
			
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
	
	public ArrayList<OrdersBean> getAllOrderList(Paging paging) {
		ArrayList<OrdersBean> beans = new ArrayList<>();
		
		String sql = "SELECT OCODE, MCODE, NAME, EMAIL, PHONE, TOTALPRICE, TOTALPOINT, REG_DATE\r\n"
				+ "FROM(SELECT RANK() OVER (ORDER BY O.REG_DATE DESC) RANK, O.MCODE, A.OCODE, O.NAME, O.EMAIL, O.PHONE, A.TOTALPRICE, A.TOTALPOINT, O.REG_DATE\r\n"
				+ "FROM BOOK_ORDERS O\r\n"
				+ "INNER JOIN \r\n"
				+ "(SELECT OD.OCODE, SUM(P.PRICE*(1-P.SALE/100)*OD.QTY) TOTALPRICE, SUM(P.PRICE*0.05*OD.QTY) TOTALPOINT\r\n"
				+ "FROM BOOK_ORDERS_DETAIL OD\r\n"
				+ "INNER JOIN BOOK_PRODUCTS P\r\n"
				+ "ON OD.PCODE = P.PCODE\r\n"
				+ "GROUP BY OD.OCODE) A\r\n"
				+ "ON O.OCODE = A.OCODE WHERE "+paging.getCondition()+" LIKE ?)\r\n"
				+ "WHERE RANK BETWEEN ? AND ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, paging.getValue());
			ps.setInt(2, paging.getStart());
			ps.setInt(3, paging.getEnd());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				OrdersBean bean = new OrdersBean();
				bean.setOcode(rs.getInt("ocode"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setTotalprice(rs.getInt("totalPrice"));
				bean.setTotalpoint(rs.getInt("totalPoint"));
				bean.setReg_date(String.valueOf(rs.getDate("reg_date")));
				beans.add(bean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return beans;
	}
	
	public ArrayList<OrdersBean> getNomemOrderSearch(String opwd, String email) {
		ArrayList<OrdersBean> beans = new ArrayList<>();
		
		String sql = "select o.ocode ocode, p.title title, od.qty qty, p.price*(1-p.sale/100)*od.qty totalprice, p.price*0.05*od.qty totalpoint, o.reg_date reg_date\r\n"
				+ "from book_orders o\r\n"
				+ "inner join book_orders_detail od\r\n"
				+ "on o.ocode = od.ocode\r\n"
				+ "inner join book_products p\r\n"
				+ "on od.pcode = p.pcode\r\n"
				+ "where email = ? and pwd = ?\r\n"
				+ "and o.ocode = (select max(ocode) from book_orders where email = ? and pwd = ?)\r\n"
				+ "order by o.reg_date desc";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, opwd);
			ps.setString(3, email);
			ps.setString(4, opwd);	
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				OrdersBean ob = new OrdersBean();
				ob.setOcode(rs.getInt("ocode"));
				ob.setTitle(rs.getString("title"));
				ob.setQty(rs.getInt("qty"));
				ob.setTotalprice(rs.getInt("totalPrice"));
				ob.setTotalpoint(rs.getInt("totalPoint"));
				ob.setReg_date(String.valueOf(rs.getDate("reg_date")));
				beans.add(ob);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		System.out.println("size : " + beans.size());
		return beans;
	}
}
