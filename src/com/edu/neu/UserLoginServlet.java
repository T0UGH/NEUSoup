package com.edu.neu;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name="login", urlPatterns={"/login"})
public class UserLoginServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String user_email = request.getParameter("user_email");
        String password = request.getParameter("password");
        User user=new User();
        user.setEmail(user_email);
        user.setPassword(password);
		boolean isLogin=DBHandler.loginUser(user);
		HttpSession session = request.getSession();
        if (!isLogin) {
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
            session.setAttribute("user", null);
        } else { 
        	
        	session.setAttribute("user", user);
        	session.setAttribute("audited_articles", null);
        	String returnPath=(String) session.getAttribute("returnPath");
        	if(returnPath==null) {
        	request.getRequestDispatcher("showArticleByUserEmail").forward(request, response);
        	}else {
        		//这块对不对,比如说auditArticle的时候,可以这么干
        		request.getRequestDispatcher(returnPath).forward(request, response);
        	}
        }
    }
}

