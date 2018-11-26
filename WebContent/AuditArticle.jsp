<%@page import="com.edu.neu.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Article article=(Article)request.getAttribute("article");
	String content=Utility.readIntoString(article.getContent());
	String author=article.isSecret()?"匿名用户":article.getAuthor();
	String time=article.getTime().toString();
%>
<title>Title</title>
</head>
<body>
	<%=author %>在<%=time %>写了:<br>
	<%=content %><br>
	<%		
		String img_url=article.getImg_url();
		if(img_url!=null){
			String[] img_urls=img_url.split(",");
			for(int i=0;i<img_urls.length;i++){
	%>
				<span><img id="thumburlShow<%=i%>" src="<%=img_urls[i]%>" width="120" height="120"/></span>
	<%
			}
		}
	%>
	<button id="audit_button">通过</button>
	<button id="unaudit_button">不通过</button>
</body>
<script>
	var article_id=<%=article.getArticle_id()%>
	function sendAudit(isAudited){
    	var d = new Date()
    	window.location.href="auditArticle?article_id="+article_id+"&audit_result="+isAudited+"&audit_time="+d.getTime()
	}
	window.onload=function(){
    	document.getElementById("audit_button").onclick=function(){sendAudit(1)};
    	document.getElementById("unaudit_button").onclick=function(){sendAudit(0)};
	}
</script>
</html>