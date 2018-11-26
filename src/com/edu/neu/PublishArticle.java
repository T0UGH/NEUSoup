package com.edu.neu;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name="publishArticle", urlPatterns={"/publishArticle"})
public class PublishArticle extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO 自动生成的方法存根
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		User user=(User) session.getAttribute("user");
		String imgUrl=Utility.handleMessy(req.getParameter("img_url"));
		boolean is_secret=req.getParameter("is_secret")==null?false:true;
		String tag=Utility.handleMessy(req.getParameter("tag"));
		Reader content=new StringReader(Utility.handleMessy(req.getParameter("input_text")));
		Timestamp time=new Timestamp(Long.parseLong(req.getParameter("time")));
		Act act=new Act();
		act.setTime(time);
		act.setUser_email(user.getEmail());
		Article article=new Article();
		article.setContent(content);
		article.setTag(tag);
		article.setSecret(is_secret);
		article.setImg_url(imgUrl);
		DBHandler.publishedArticle(article, act);
		req.getRequestDispatcher("SubmitOK.jsp").forward(req, resp);
	}
	
}
