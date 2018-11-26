package com.edu.neu;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name="showArticleByUserEmail", urlPatterns={"/showArticleByUserEmail"})
public class ShowArticleByUserEmail extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		String user_email=req.getParameter("user_email");
		int pageNum=req.getParameter("page_num")==null?1:Integer.parseInt(req.getParameter("page_num"));
		HttpSession session=req.getSession();
		User user;
		List<Article> articles=null;
		int maxPage;
		if(session==null||(user=(User) session.getAttribute("user"))==null){
			req.getRequestDispatcher("login.jsp").forward(req, resp);
			session.setAttribute("returnPath", req.getServletPath()+"?"+req.getQueryString());
			return;
		}
		//如果它没有传来useremail这个参数，就用他自己
		if(user_email==null)
			user_email=user.getEmail();
		if(user.getEmail().equals(user_email)) {
			articles=DBHandler.showArticleByUserEmail(pageNum, user_email);
			maxPage=DBHandler.maxPageArticleByUserEmail(user_email);
		}else {
			articles=DBHandler.showUnSecretedArticleByUserEmail(pageNum, user_email);
			maxPage=DBHandler.maxPageUnSecretedArticleByUserEmail(user_email);
		}
		System.out.println(articles!=null);
		System.out.println(maxPage);
		System.out.println(pageNum);
		if(articles!=null&&(maxPage>=pageNum||maxPage==0&&pageNum==1)){
			req.setAttribute("articles", articles);
			req.setAttribute("maxPage", maxPage);
			req.setAttribute("requestedUser", DBHandler.getUserByUserEmail(user_email));
			System.out.println(DBHandler.getUserByUserEmail(user_email).getFocus_num());
			System.out.println(DBHandler.getUserByUserEmail(user_email).getFan_num());
			req.getRequestDispatcher("ShowArticleByUserEmail.jsp").forward(req, resp);
		}else
			req.getRequestDispatcher("UserError.jsp").forward(req, resp);
	}
	
}
