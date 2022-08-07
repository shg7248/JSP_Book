package com.movie.beans;

public class OrdersBean {

	private int ocode;
	private int mcode;
	private String title;
	private String name;
	private int qty;
	private String phone;
	private String email;
	private String pwd;
	
	private int totalprice;
	private int totalpoint;
	private String reg_date;
	
	public int getOcode() {
		return ocode;
	}
	public void setOcode(int ocode) {
		this.ocode = ocode;
	}
	public int getMcode() {
		return mcode;
	}
	public void setMcode(int mcode) {
		this.mcode = mcode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public int getTotalpoint() {
		return totalpoint;
	}
	public void setTotalpoint(int totalpoint) {
		this.totalpoint = totalpoint;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
}
