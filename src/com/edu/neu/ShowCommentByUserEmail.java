package com.edu.neu;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet(name="showCommentByUserEmail", urlPatterns={"/showCommentByUserEmail"})
public class ShowCommentByUserEmail extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		String user_email=req.getParameter("user_email");
		HttpSession session=req.getSession();
		User user;
		List<Comment> comments = null;
		int pageNum=Integer.parseInt(req.getParameter("page_num"));
		int maxPage;
		if(session==null||(user=(User) session.getAttribute("user"))==null){
			req.getRequestDispatcher("login.jsp").forward(req, resp);
			session.setAttribute("returnPath", req.getServletPath()+"?"+req.getQueryString());
			return;
		}
		if(user.getEmail().equals(user_email)) {
			comments=DBHandler.showCommentByUserEmail(pageNum, user_email);
			maxPage=DBHandler.maxPageCommentByUserEmail(user_email);
		}else {
			comments=DBHandler.showUnsecretedCommentByUserEmail(pageNum, user_email);
			maxPage=DBHandler.maxPageUnsecretedCommentByUserEmail(user_email);
		}
		if(comments!=null&&pageNum<=maxPage) {
		req.setAttribute("comments", comments);
		req.setAttribute("maxPage", maxPage);
		req.setAttribute("requestedUser", DBHandler.getUserByUserEmail(user_email));
		req.getRequestDispatcher("ShowCommentByUserEmail.jsp").forward(req, resp);
		}else {
			req.getRequestDispatcher("UserError.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO 自动生成的方法存根
		doPost(req, resp);
	}
	
}
