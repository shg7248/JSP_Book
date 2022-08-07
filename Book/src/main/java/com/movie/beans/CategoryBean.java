package com.movie.beans;

import java.sql.Timestamp;

public class CategoryBean {
	
	private String cateCode;
	private String cateGroup;
	private String cateName;
	private String cateUrl;
	private Timestamp reg_date;
	
	public String getCateCode() {
		return cateCode;
	}
	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	public String getCateGroup() {
		return cateGroup;
	}
	public void setCateGroup(String cateGroup) {
		this.cateGroup = cateGroup;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getCateUrl() {
		return cateUrl;
	}
	public void setCateUrl(String cateUrl) {
		this.cateUrl = cateUrl;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
}
