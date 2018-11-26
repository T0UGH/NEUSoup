<%@page import="com.edu.neu.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<Article> articles=(List<Article>)request.getAttribute("articles");
	int maxPage=(Integer)request.getAttribute("maxPage");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="jquery.js"></script>
<title>首页</title>
</head>
<body>
<%
		User user=(User)request.getSession().getAttribute("user");
		String user_email=user.getEmail();
%>
<% for(Article article:articles){
			String content=Utility.readIntoString(article.getContent());
			User watchingUser=DBHandler.findAuthor(article.getArticle_id());
			String author=watchingUser.getUsername();
			String watchingEmial=watchingUser.getEmail();
			String tag=article.getTag();
			int like_num=article.getLike_num();
			int unLike_num=article.getUnlike_num();
			String time=article.getTime().toString();
			Act act=new Act();
			act.setArticle_id(article.getArticle_id());
			act.setUser_email(user_email);
			act.setAct_type(1);
			boolean has_like=DBHandler.existAct(act);
			act.setAct_type(2);
			boolean has_unlike=DBHandler.existAct(act);
	%>
			<div id=<%=article.getArticle_id()%>>
			<%
				if(!article.isSecret()){
			%>
					<%=author%>在<%=time %>写了:<br>
					<%
					boolean hasFocused=DBHandler.hasFocused(new Focus(user_email,watchingUser.getEmail()));
					boolean isSelf=user_email.equals(watchingUser.getEmail());
					if(!hasFocused&&!isSelf){
					%>
						<button class="focus" id="user_<%=watchingEmial%>">关注</button><br>
					<%
					}else if(!isSelf&&hasFocused){
					%>
						<button class="focus" id="user_<%=watchingEmial%>" disabled="true">已关注</button><br>
					<%
					}else{
					%>
	<%
					}
				}else{
					
	%>
					匿名用户在<%=time %>写了:<br>
	<%
				}
	%>
	
				<%=content %><br>
	
	<%		
			String img_url=article.getImg_url();
			if(img_url!=null&&img_url!=""){
				String[] img_urls=img_url.split(",");
				for(int i=0;i<img_urls.length;i++){
	%>
				<span><img id="thumburlShow<%=i%>" src="<%=img_urls[i]%>" width="120" height="120"/></span>
	<%
				}
			}
	%>
			赞了<h5 class="like_num"><%=like_num%></h5>,踩了<h5 class="like_num"><%=unLike_num%></h5><br><br>
	<%
			if(has_like){
	%>
			<button class="haslike_button" disabled="true">赞过了</button><br>
	<%
			}else{
	%>
			<button class="like_button">赞</button><br>
	<%
			}
	%>
	<%
			if(has_unlike){
	%>
			<button class="hasunlike_button" disabled="true">踩过了</button><br>
	<%
			}else{
	%>
			<button class="unlike_button">踩</button><br>
	<%
			}
	%>
			<button class="showComment_button">显示评论</button>
			<div class="comments">
				<input type="text" class="write_comment" value=""></input><button class="writeComment_button">发表评论</button>
			</div>
		</div>
	<%
	} 
	%>
	<% for(int i=1;i<=maxPage;i++){%>
		<a href=<%="/Soup/ShowAllArticle?page_num="+i %>><%=i%></a>	
	<% } %>
</body>
	<script>
var user_email="<%=user_email%>"
function focus(){
	alert("focus执行了")
	$(".focus").click(function(){
    	alert("点击关注按钮了")
        var requested_user=""+$(this).attr("id")
        alert($(this).attr("id"))
        alert(requested_user)
        var requested_user=requested_user.split("_")[1]
    	alert(requested_user)
        var time=""+new Date().getTime()
        $.get("/Soup/focus",{"requested_user":requested_user,"time":time},function(data,status){
            if(data.code==0){
                $(this).attr("disabled","true")
            }else{
                alert("关注失败")
            }
         }.bind(this),"json");     
    });
}
function like(){
	alert("like执行了")
    $(".like_button").click(function(){
    	alert("点击赞按钮了")
        var article_id=$(this).parent().attr("id");
        var time=""+new Date().getTime()
        $.get("/Soup/like",{"article_id":article_id,"time":time},function(data,status){
            if(data.code==0){
                $(this).siblings(".like_num").first().text(""+(parseInt($(this).siblings(".like_num").first().text())+1))
                $(this).unbind("click")
                $(this).attr("class","haslike_button")
                $(this).attr("disabled","true")
            }else{
                alert("点赞失败")
            }
         }.bind(this),"json"); 
         
    });
}
function unlike(){
	alert("unlike执行了")
    $(".unlike_button").click(function(){
    	alert("点击踩按钮了")
        var article_id=$(this).parent().attr("id");
        var time=""+new Date().getTime()
        $.get("/Soup/unlike",{"article_id":article_id,"time":time},function(data,status){
            if(data.code==0){
                $(this).siblings(".unlike_num").first().text(""+(parseInt($(this).siblings(".unlike_num").first().text())+1))
            }else{
                alert("点踩失败")
            }
         }.bind(this),"json");   
    });
}
function showComment(){
    $(".showComment_button").click(function(){
        var article_id=$(this).parent().attr("id");
        $.get("/Soup/showComment",{"article_id":article_id},function(data,status){
            if(data.code==0){
                var comments=data.comments
                for(var i=0;i<comments.length;i++){
                    var comment=$("<p></p>").text(comments[i].username+":"+comments[i].content)
                    $(this).siblings(".comments").first().append(comment)  
                }
                $(this).text("隐藏评论")
                $(this).siblings(".comments").first().toggle()
                $(this).unbind("click").click(function(){
                $(this).siblings(".comments").first().toggle()
                })
	        }else{
	            alert("展示评论失败")
	        }
	    }.bind(this),"json")
	});
}
function writeComment(){
    $(".writeComment_button").click(function(){
        var article_id=$(this).parent().parent().attr("id")
        var time=""+new Date().getTime()
        alert($(this).siblings(".write_comment").first().val())
        var content=$(this).siblings(".write_comment").first().val()
        $(this).siblings(".write_comment").first().val("")
        $.get("/Soup/publishComment",{"article_id":article_id,"time":time,"content":content},function(data,status){},"json")
        var comment=$("<p></p>").text(user_email+":"+content)
        $(this).parent().append(comment)
    })
}
window.onload=function(){
	focus()
	$(".comments").hide()
    like()
    unlike()
	showComment()
	writeComment()
}
</script>
</html>