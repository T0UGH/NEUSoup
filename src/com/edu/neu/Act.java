package com.edu.neu;

import java.sql.Timestamp;

public class Act {
	private int act_id;
	private String user_email;
	private int article_id;
	private Timestamp time;
	private int act_type;
	public Act() {
	}
	public Act(int act_id, String user_email, int article_id, Timestamp time, int act_type) {
		this.act_id = act_id;
		this.user_email = user_email;
		this.article_id = article_id;
		this.time = time;
		this.act_type = act_type;
	}
	public Act(String user_email, int article_id, Timestamp time, int act_type) {
		super();
		this.user_email = user_email;
		this.article_id = article_id;
		this.time = time;
		this.act_type = act_type;
	}

	public Act(String user_email, Timestamp time, int act_type) {
		super();
		this.user_email = user_email;
		this.time = time;
		this.act_type = act_type;
	}
	public int getAct_id() {
		return act_id;
	}
	public void setAct_id(int act_id) {
		this.act_id = act_id;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public int getArticle_id() {
		return article_id;
	}
	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public int getAct_type() {
		return act_type;
	}
	public void setAct_type(int act_type) {
		this.act_type = act_type;
	}
}
