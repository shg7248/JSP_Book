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

import com.movie.beans.CategoryBean;

public class CategoryDao {
	
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	private static CategoryDao instance = null;
	
	public static CategoryDao getInstance() throws NamingException, SQLException {
		if(instance == null)
			instance = new CategoryDao();
		return instance;
	}
	
	private CategoryDao() throws NamingException, SQLException {
		Context initContext = new InitialContext();
		Context envinit = (Context) initContext.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envinit.lookup("jdbc/OracleDB");
		conn = dataSource.getConnection();
	}
	
	public ArrayList<CategoryBean> getAllCategorys() {
		
		ArrayList<CategoryBean> beans = new ArrayList<>();
		
		try {
			String sql = "SELECT * FROM BOOK_CATEGORY WHERE CATEGROUP IS NULL";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CategoryBean bean = new CategoryBean();
				bean.setCateCode(rs.getString("CATECODE"));
				bean.setCateGroup(rs.getString("CATEGROUP"));
				bean.setCateName(rs.getString("CATENAME"));
				bean.setCateUrl(rs.getString("CATEURL"));
				bean.setReg_date(rs.getTimestamp("REG_DATE"));
				beans.add(bean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		return beans;
	}
	
	public ArrayList<CategoryBean> getAllCategorys(String groupCode) {
		
		ArrayList<CategoryBean> beans = new ArrayList<>();
		
		try {
			String sql = "SELECT * FROM BOOK_CATEGORY WHERE CATEGROUP = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, groupCode);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CategoryBean bean = new CategoryBean();
				bean.setCateCode(rs.getString("CATECODE"));
				bean.setCateGroup(rs.getString("CATEGROUP"));
				bean.setCateName(rs.getString("CATENAME"));
				bean.setReg_date(rs.getTimestamp("REG_DATE"));
				beans.add(bean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps, rs);
		}
		
		return beans;
	}
	
	public int insertFirstCategory(CategoryBean bean) {
		
		int cnt = -1;
		try {
			String sql = 	"INSERT INTO BOOK_CATEGORY (CATECODE, CATEGROUP, CATENAME, CATEURL, REG_DATE) " +
							"VALUES(?, NULL, ?, ?, SYSDATE)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bean.getCateCode());
			ps.setString(2, bean.getCateName());
			ps.setString(3, bean.getCateUrl());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}
	
	public int insertSecondCategory(CategoryBean bean) {
		
		int cnt = -1;
		try {
			String sql = 	"INSERT INTO BOOK_CATEGORY (CATECODE, CATEGROUP, CATENAME, REG_DATE) " +
							"VALUES(?, ?, ?, SYSDATE)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bean.getCateCode());
			ps.setString(2, bean.getCateGroup());
			ps.setString(3, bean.getCateName());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}

}
