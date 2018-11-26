<%@page import="com.edu.neu.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<% User requestedUser=(User)request.getAttribute("requestedUser");
		List<Comment> comments=(List<Comment>)request.getAttribute("comments");
		int maxPage=(Integer)request.getAttribute("maxPage");
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人主页|<%=requestedUser.getUsername() %></title>
</head>
<body>
	<%
		for(Comment comment:comments){
	        String content = comment.getContent();
	        String time=comment.getTime().toString();
	        String author=requestedUser.getUsername();
	        Article article=DBHandler.showArticleByArticleId(comment.getArticle_id());     
	        String articleContent=Utility.omitString(Utility.readIntoString(article.getContent()));
	        int last_comment_id=comment.getLast_comment_id();
	        if(last_comment_id==Comment.NULL_COMMENT_ID){
	%>	
				<%=author %>在<%=time %>评论了文章  <%=articleContent%>  :<br>
				<%=content %><br><br>
	<% 
	        }else{
	        	Comment lastComment=DBHandler.showCommentByCommentId(last_comment_id);
	        	String lastAuthor=lastComment.getUser_email();
	        	String lastContent=lastComment.getContent();
	%>
				<%=author %>在<%=time %>在文章 :<%=articleContent%> 下,<br>
				评论了<%=lastAuthor%>的评论"<%=lastContent%>":<br>
				<%=content %><br><br>
	<%        	
	        }
		}
	%>
	<% for(int i=1;i<=maxPage;i++){%>
		<a href=<%="/Soup/showCommentByUserEmail?user_email="+requestedUser.getEmail()+"&page_num="+i %>><%=i%></a>	
	<% } 
	%>
</body>
</html>