package com.movie.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	
	public int insertFirstCategory(CategoryBean bean) {
		
		int cnt = -1;
		try {
			String sql = 	"INSERT INTO BOOK_CATEGORY (CATECODE, CATEGROUP, CATENAME, REG_DATE) " +
							"VALUES(?, NULL, ?, SYSDATE)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bean.getCateCode());
			ps.setString(2, bean.getCateName());
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClose.close(ps);
		}
		return cnt;
	}

}
