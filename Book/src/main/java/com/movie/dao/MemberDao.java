package com.movie.dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDao {
	
	private Connection conn = null;
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
}
