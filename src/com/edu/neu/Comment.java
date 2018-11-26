package com.edu.neu;

import java.io.Reader;
import java.sql.Timestamp;

public class Comment {
	private int comment_id;
	private String content;
	private boolean is_secret;
	private String user_email;
	private int article_id;
	public boolean isIs_secret() {
		return is_secret;
	}

	public void setIs_secret(boolean is_secret) {
		this.is_secret = is_secret;
	}



	private Timestamp time;
	private int last_comment_id;
	private String username;
	public static final int NULL_COMMENT_ID=0;
	public Comment() {
		super();
	}
	
	public Comment(int comment_id, String content, boolean is_secret, String user_email, int article_id, Timestamp time,
			int last_comment_id) {
		super();
		this.comment_id = comment_id;
		this.content = content;
		this.is_secret = is_secret;
		this.user_email = user_email;
		this.article_id = article_id;
		this.time = time;
		this.last_comment_id = last_comment_id;
	}

	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isSecret() {
		return is_secret;
	}
	public void setSecret(boolean is_secret) {
		this.is_secret = is_secret;
	}
	public String getUser_email() {
		return user_email;
	}
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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
	public int getLast_comment_id() {
		return last_comment_id;
	}

	public void setLast_comment_id(int last_comment_id) {
		this.last_comment_id = last_comment_id;
	}
	
}
