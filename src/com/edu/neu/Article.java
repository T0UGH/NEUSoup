package com.edu.neu;

import java.io.Reader;
import java.sql.Clob;
import java.sql.Timestamp;

public class Article {
	private int article_id;
	private Reader content;//这里到底用什么还有待考虑
	private String tag;
	private boolean isSecret;
	private boolean isAudit;
	private int like_num;
	private int unlike_num;
	private String author;
	private Timestamp time;
	private String img_url;
	public String getImg_url() {
		return img_url;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public Article() {
		super();
	}
	public Article(int article_id, Reader content, String tag, boolean isSecret, boolean isAudit, int like_num,
			int unlike_num) {
		super();
		this.article_id = article_id;
		this.content = content;
		this.tag = tag;
		this.isSecret = isSecret;
		this.isAudit = isAudit;
		this.like_num = like_num;
		this.unlike_num = unlike_num;
	}
	public Article(Reader content, String tag, boolean isSecret) {
		super();
		this.content = content;
		this.tag = tag;
		this.isSecret = isSecret;
	}
	public int getArticle_id() {
		return article_id;
	}
	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}
	public Reader getContent() {
		return content;
	}
	public void setContent(Reader content) {
		this.content = content;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public boolean isSecret() {
		return isSecret;
	}
	public void setSecret(boolean isSecret) {
		this.isSecret = isSecret;
	}
	public boolean isAudit() {
		return isAudit;
	}
	public void setAudit(boolean isAudit) {
		this.isAudit = isAudit;
	}
	public int getLike_num() {
		return like_num;
	}
	public void setLike_num(int like_num) {
		this.like_num = like_num;
	}
	public int getUnlike_num() {
		return unlike_num;
	}
	public void setUnlike_num(int unlike_num) {
		this.unlike_num = unlike_num;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
}
