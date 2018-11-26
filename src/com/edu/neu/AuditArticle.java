package com.edu.neu;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet(name="auditArticle", urlPatterns={"/auditArticle"})
public class AuditArticle extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		HttpSession session=req.getSession();
		LinkedList<Article> articles=(LinkedList<Article>) session.getAttribute("audited_articles");
		User user = null;
		if(session==null||(user=(User) session.getAttribute("user"))==null){
			req.getRequestDispatcher("login.jsp").forward(req, resp);
			session.setAttribute("returnPath", req.getServletPath()+"?"+req.getQueryString());
			return;
		}
		if(articles==null) {
			
			articles=DBHandler.showUnAuditedArticleNoSelf(user.getEmail());
			session.setAttribute("audited_articles", articles);
		}
		String auditedArticleId=req.getParameter("article_id");//获得审批文章的id	
		String auditedResult=req.getParameter("audit_result");//获得审批的结果，1或者0
		String auditedTime=req.getParameter("audit_time");//获得审批的时间
		if(auditedArticleId!=null&&auditedResult!=null&&auditedTime!=null&
				Integer.parseInt(auditedResult)==1) {//如果有id和结果并且结果值为1
			Act act=new Act();
			act.setUser_email(user.getEmail());
			act.setArticle_id(Integer.parseInt(auditedArticleId));
			act.setTime(new Timestamp(Long.parseLong(auditedTime)));
			DBHandler.auditArticle(act);
		}
		Article article=articles.poll();
		if(article!=null) {
			System.out.println(article.getArticle_id());
			req.setAttribute("article", article);
			req.getRequestDispatcher("ExamineArticle.jsp").forward(req, resp);
		}else {
			req.getRequestDispatcher("noAudit.jsp").forward(req, resp);
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
}
