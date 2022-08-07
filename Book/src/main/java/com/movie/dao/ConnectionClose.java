package com.movie.dao;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionClose {
	
	public static void close(PreparedStatement ps, ResultSet rs) {
		try {
			if(rs != null) {
				rs.close();
			}
			if(ps != null)
				ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement ps) {
		try {
			if(ps != null)
				ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(CallableStatement cs) {
		try {
			if(cs != null)
				cs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
