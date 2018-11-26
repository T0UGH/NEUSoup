package com.edu.neu;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet(name="publishComment", urlPatterns={"/publishComment"})
public class PublishComment extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try { 
			int article_id=Integer.parseInt(req.getParameter("article_id"));
			Timestamp time=new Timestamp(Long.parseLong(req.getParameter("time")));
			String content=req.getParameter("content");
			HttpSession session=req.getSession();
			User user = null;
			JSONObject object=new JSONObject();
			if((user=(User) session.getAttribute("user"))!=null){
				Comment comment=new Comment();
				comment.setArticle_id(article_id);
				comment.setUser_email(user.getEmail());
				comment.setContent(content);
				comment.setTime(time);
				comment.setSecret(false);
				int resultCode=DBHandler.publishComment(comment)?0:1;
	            object.put("code", resultCode);
			}else {
				object.put("code",2);//没有登陆就返回2
			}
			resp.setContentType("text/plain");
            PrintWriter writer=resp.getWriter();
            writer.println(object.toString());
		 }catch(Exception e) {
			 JSONObject object=new JSONObject();
	         object.put("code", 1);
	         PrintWriter writer=resp.getWriter();
	         writer.println(object.toString());
			 e.printStackTrace();
		 }
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
