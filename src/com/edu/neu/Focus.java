package com.edu.neu;

import java.sql.Timestamp;

public class Focus {
	private int focus_id;
	private String user_email;
	private String focus_email;
	private Timestamp time;
	
	public Focus(String user_email, String focus_email) {
		this.user_email = user_email;
		this.focus_email = focus_email;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public Focus() {
		
	}
	public int getFocus_id() {
		return focus_id;
	}
	public void setFocus_id(int focus_id) {
		this.focus_id = focus_id;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getFocus_email() {
		return focus_email;
	}
	public void setFocus_email(String focus_email) {
		this.focus_email = focus_email;
	}
	
}
