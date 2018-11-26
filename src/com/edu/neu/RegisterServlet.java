package com.edu.neu;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet(name="register", urlPatterns={"/register"})
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        Timestamp time=new Timestamp(Long.parseLong(req.getParameter("time")));
        String user_email = req.getParameter("R_user_email");
        String password = req.getParameter("R_password");
        String user_name=req.getParameter("user_name");
        User user=new User();
        user.setEmail(user_email);
        user.setPassword(password);
        user.setUsername(user_name);
        user.setTime(time);
		boolean isRegistered=DBHandler.registerUser(user);
        if (!isRegistered) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } else { 
        	HttpSession session = req.getSession();
        	session.setAttribute("user", user);
        	session.setAttribute("audited_articles", null);
        	String returnPath=(String) session.getAttribute("returnPath");
        	if(returnPath==null) {
        		req.getRequestDispatcher("showArticleByUserEmail").forward(req, resp);
        	}else {
        		//这块对不对,比如说auditArticle的时候,可以这么干
        		req.getRequestDispatcher(returnPath).forward(req, resp);
        	}
        }
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO 自动生成的方法存根
		doGet(req, resp);
	}
	
}
