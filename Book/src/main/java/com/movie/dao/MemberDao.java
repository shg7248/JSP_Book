package com.movie.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.movie.beans.MemberBean;

public class MemberDao {
	
	private Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private static MemberDao instance = null;
	
	public static MemberDao getInstance() throws NamingException, SQLException {
		if(instance == null)
			instance = new MemberDao();
		return instance;
	}
	
	private MemberDao() throws NamingException, SQLException {
		Context initContext = new InitialContext();
		Context envinit = (Context) initContext.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envinit.lookup("jdbc/OracleDB");
		conn = dataSource.getConnection();
	}
	
	public int insertMember(MemberBean bean) {
		
		int cnt = -1;
		
		try {
			String sql = "INSERT INTO BOOK_MEMBERS (MCODE, ID, PWD, NAME, BIRTH, GENDER, EMAIL, PHONE, REG_DATE) "
					+ "VALUES (BOOK_MEMBERS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ? , SYSDATE)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bean.getId());
			ps.setString(2, bean.getPwd());
			ps.setString(3, bean.getName());
			ps.setString(4, bean.getBirth());
			ps.setString(5, bean.getGender());
			ps.setString(6, bean.getEmail());
			ps.setString(7, bean.getPhone());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}
	
	public MemberBean confirmMember(String id, String pwd) {
		
		MemberBean bean = null;
		
		try {
			String sql = "SELECT * FROM BOOK_MEMBERS WHERE ID = ? AND PWD = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				bean = new MemberBean();
				bean.setMcode(rs.getInt("mcode"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setBirth(rs.getString("birth"));
				bean.setGender(rs.getString("gender"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setReg_date(rs.getTimestamp("reg_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		
		return bean;
	}
}
