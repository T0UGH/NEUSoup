package com.edu.neu;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet(name="showComment", urlPatterns={"/showComment"})
public class showCommentByArticleid extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try { 
			resp.setCharacterEncoding("UTF-8");
			int article_id=Integer.parseInt(req.getParameter("article_id"));
			HttpSession session=req.getSession();
			User user = null;
			JSONObject object=new JSONObject();
			if((user=(User) session.getAttribute("user"))!=null){
				List<Comment> comments=DBHandler.showCommentByArticleId(article_id);
				object.put("code", 0);
				object.put("comments",comments);
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
		doGet(req, resp);
	}
	
}
