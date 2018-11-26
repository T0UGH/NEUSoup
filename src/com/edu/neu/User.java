package com.edu.neu;

import java.sql.Timestamp;

public class User {
	private String email;
	private String username;
	private String password;
	private Timestamp registed_time;
	private int focus_num;
	private int fan_num;
	public User() {
	}
	public User(String email, String username, String password, Timestamp time) {
		super();
		this.email = email;
		this.username = username;
		this.password = password;
		this.registed_time = time;
	}
	public int getFocus_num() {
		return focus_num;
	}
	public void setFocus_num(int focus_num) {
		this.focus_num = focus_num;
	}
	public int getFan_num() {
		return fan_num;
	}
	public void setFan_num(int fan_num) {
		this.fan_num = fan_num;
	}
	public Timestamp getRegisted_time() {
		return registed_time;
	}
	public void setRegisted_time(Timestamp registed_time) {
		this.registed_time = registed_time;
	}
	public User(String email, String username, String password, long time) {
		super();
		this.email = email;
		this.username = username;
		this.password = password;
		this.registed_time = new Timestamp(time);
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public Timestamp getTime() {
		return registed_time;
	}
	public void setTime(Timestamp time) {
		this.registed_time = time;
	}
	
}
