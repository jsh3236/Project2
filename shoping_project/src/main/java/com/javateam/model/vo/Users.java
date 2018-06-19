package com.javateam.model.vo;

import java.util.Date;

public class Users {
	
	private String username;
	private String password;
	private int enabled;
	private String name;
	private String sex;
	private String phone;
	private String address;
	private String email;
	private Date joindate;
	
	public Users() {}

	/**
	 * @param username
	 * @param password
	 * @param enabled
	 * @param name
	 * @param sex
	 * @param phone
	 * @param address
	 * @param email
	 * @param joindate
	 */
	public Users(String username, String password, int enabled, String name, String sex, String phone, String address,
			String email, Date joindate) {
		super();
		this.username = username;
		this.password = password;
		this.enabled = enabled;
		this.name = name;
		this.sex = sex;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.joindate = joindate;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getJoindate() {
		return joindate;
	}

	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}
	
	
}
