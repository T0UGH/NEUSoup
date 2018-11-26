package com.edu.neu;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;


@WebServlet(name="focus", urlPatterns={"/focus"})
public class FocusServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try { 
			HttpSession session=req.getSession();
			User user = null;
			JSONObject object=new JSONObject();
			if((user=(User) session.getAttribute("user"))!=null) {
				String focus_email=req.getParameter("requested_user");
				Timestamp time=new Timestamp(Long.parseLong(req.getParameter("time")));
				Focus focus=new Focus();
				focus.setFocus_email(focus_email);
				focus.setUser_email(user.getEmail());
				focus.setTime(time);
				object.put("code", DBHandler.focus(focus)?0:1);
			}else {
				object.put("code", 2);//如果是2的话就是说登陆不行
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
