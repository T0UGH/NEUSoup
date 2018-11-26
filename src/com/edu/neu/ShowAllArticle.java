package com.edu.neu;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShowAllArticleByUserEmail
 */
@WebServlet(name="/ShowAllArticle", urlPatterns={"/ShowAllArticle","/homePage"})
public class ShowAllArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		String page=request.getParameter("page_num");
		int pageNum=page==null?1:Integer.parseInt(request.getParameter("page_num"));
		HttpSession session=request.getSession();
		User user;
		List<Article> articles=null;
		int maxPage;
		if(session==null||(user=(User) session.getAttribute("user"))==null){
			request.getRequestDispatcher("login.jsp").forward(request, response);
			session.setAttribute("returnPath", request.getServletPath()+"?"+request.getQueryString());
			return;
		}
		articles=DBHandler.showAuditedArticle(pageNum);//ÏÔÊ¾ÉóÅúÎÄÕÂ	
		maxPage=DBHandler.maxPageAuditedArticle();
		if(articles!=null&&maxPage>=pageNum){
			request.setAttribute("articles", articles);
			request.setAttribute("maxPage", maxPage);
			request.getRequestDispatcher("ShowAllArticle2.jsp").forward(request, response);
		}else
			request.getRequestDispatcher("UserError.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
