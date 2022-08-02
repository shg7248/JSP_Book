package com.movie.beans;

import java.sql.Timestamp;

public class CategoryBean {
	
	private int cateCode;
	private int cateGroup;
	private String cateName;
	private Timestamp date;
	
	public int getCateCode() {
		return cateCode;
	}
	public void setCateCode(int cateCode) {
		this.cateCode = cateCode;
	}
	public int getCateGroup() {
		return cateGroup;
	}
	public void setCateGroup(int cateGroup) {
		this.cateGroup = cateGroup;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
}
