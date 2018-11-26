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
@WebServlet(name="like", urlPatterns={"/like"})
public class LikeArticleServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try { 
			int article_id=Integer.parseInt(req.getParameter("article_id"));
			Timestamp time=new Timestamp(Long.parseLong(req.getParameter("time")));
			HttpSession session=req.getSession();
			User user = null;
			JSONObject object=new JSONObject();
			if((user=(User) session.getAttribute("user"))!=null){
				Act act=new Act();
				act.setArticle_id(article_id);
				act.setTime(time);
				act.setUser_email(user.getEmail());
				int resultCode=DBHandler.likeArticle(act)?0:1;
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
