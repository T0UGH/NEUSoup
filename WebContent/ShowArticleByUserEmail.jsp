<%@page import="com.edu.neu.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<% User requestedUser=(User)request.getAttribute("requestedUser");
		List<Article> articles=(List<Article>)request.getAttribute("articles");
		int maxPage=(Integer)request.getAttribute("maxPage");
		User user=(User)request.getSession().getAttribute("user");
		String user_email=user.getEmail();
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/person.css">
<link rel="stylesheet" type="text/css" href="css/global-main1.css">
<title>个人主页|<%=requestedUser.getUsername() %></title>
<script src="jquery.js"></script>
</head>
<body>
		<div id="left-nav-container">
		<nav id="left-nav">
			<div class="nav-header">
				<a href="nav.html">
					<img class="brand" src="img/NEU Soup.png">
					<p>
						<br/>
					</p>
				</a>
			</div>
			<div class="nav-list-container">
				<ul class="nav-list">
     				<li class="nav-listitem active">
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/ShowAllArticle?page_num=1">
      					       文章
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/showArticleByUserEmail?page_num=1&user_email=<%=user_email%>" onclick="show();window.scrollByLines(10);return false;">
       						个人
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/Contact.jsp">
       						联系
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" href="/Soup/auditArticle">
       						审批
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" href="/Soup/PublishArticle.jsp">
       						发表
      					</a>
     				</li>
    			</ul>
    		</div>
    		<div class="nav-footer">
     			<div>
      				<div>
       					<ul class="nav-footer-list">
        					<li class="nav-footer-listitem">
         						<h4 id="footer-heading">
          							CONTACT
         						</h4>
        					</li>
        					<li class="nav-footer-listitem">
         						<i class="nav-footer-listitem">
         						</i>
         						<p class="nav-footer-info fa fa-envelope-open-o">
          							NEU Soup@163.com
         						</p>
        					</li>
        					<li class="nav-footer-listitem">
         						<i class="nav-footer-listitem">
         						</i>
         						<p class="nav-footer-info fa fa-phone-square">
          							4008-823-823
         						</p>
        					</li>
        					<li class="nav-footer-listitem">
         						<i class="nav-footer-listitem">
         						</i>
         						<p class="nav-footer-info fa fa-weixin">
          							NEU Soup
          							<br/>
         						</p>
        					</li>
       					</ul>
      				</div>
     			</div>
    		</div>
    	</nav>
			</div>

	<div class="person_content">
	<div class="background_wall">
		</div>
	<div class="person_introduce" align="center">
		<img src="img/head_portrait.png" alt="图片未找到" id="touxiang"/>
		<p id="nicheng"><%=requestedUser.getUsername()%></p>
		<div class="gf">
	关注:<p id="focus_num"><%=requestedUser.getFocus_num()%></p>
	粉丝:<p id="fan_num"><%=requestedUser.getFan_num()%></p>
	<%
		boolean hasFocused=DBHandler.hasFocused(new Focus(user_email,requestedUser.getEmail()));
		boolean isSelf=user_email.equals(requestedUser.getEmail());
		if(!hasFocused&&!isSelf){
	%>
	<button id="focus"><img src="img/guanzhu.png" alt="未找到图片"></button>
	<%
		}else if(!isSelf&&hasFocused){
	%>
	<button id="focus" disabled="true"><img src="img/yiguanzhu.png" alt="未找到图片"></button><br>
	<%
		}else{
	%>
	<%
		}
	%>
	<button id="zhuxiao"><img src="img/zhuxiao.png" alt="未找到图片"></button><br>
	</div>
		<hr>
		<p id="qianming">Welcome to home page </p><hr>
		</div>
		
	<div class="person_display">
	<p id="history">Historical records</p>
	

	<% for(Article article:articles){
			String content=Utility.readIntoString(article.getContent());
			String author=requestedUser.getUsername();
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
			<div id=<%=article.getArticle_id()%> class="article">
			<p class="time"><%=time %></p>
			<p class="content"><%=content %></p>
			<br>
			<div class="tupian">
	<%		
			String img_url=article.getImg_url();
			if(img_url!=null&&img_url!=""){
				String[] img_urls=img_url.split(",");
				for(int i=0;i<img_urls.length;i++){
	%>
				<img id="thumburlShow<%=i%>" src="<%=img_urls[i]%>" width="120" height="120"/>
	<%
				}
			}
	%>
	</div>
	<div class="caozuo">
	<%
			if(has_like){
	%>
			<button class="haslike_button" disabled="true"><img src="img/yidianzan.png" alt="未找到图片"></button>
			<p class="like_num"><%=like_num%></p>
	<%
			}else{
	%>
	        
			<button class="like_button"><img src="img/dianzan.png" alt="未找到图片"></button>
			<p class="like_num"><%=like_num%></p>
	<%
			}
	%>
	<%
			if(has_unlike){
	%>
			<button class="hasunlike_button" disabled="true"><img  src="img/yicai.png" alt="未找到图片"></button>
			<p class="unlike_num"><%=unLike_num%></p>
	<%
			}else{
	%>
			<button class="unlike_button"><img src="img/cai.png" alt="未找到图片"></button>
			<p class="unlike_num"><%=unLike_num%></p>
	<%
			}
	%>
	<button class="showComment_button"><img src="img/pinglun.png" alt="未找到图片"></button>
	</div>
			<div class="comments">
			<hr>
				<input type="text" class="write_comment" value=""></input>
				<button class="writeComment_button">发送</button>
				<hr>
			</div>
			
		</div>
		
		
	<%
	} 
	%>
	<center>
	<% for(int i=1;i<=maxPage;i++){%>
		<a href=<%="/Soup/showArticleByUserEmail?user_email="+requestedUser.getEmail()+"&page_num="+i %> style="width:10px;display:inline-block; text-decoration: none;"><%=i%></a>
	<% } %>
	</center>
	</div>
	<div style="height:100px;">
	</div>
	</div>
</body>
<script>
var user_email="<%=user_email%>"
var requested_user="<%=requestedUser.getEmail()%>"
function focus(){
    $.get("/Soup/focus",{"requested_user":requested_user,"time":""+new Date().getTime()},function(data,status){
        if(data.code==0){
            $("#focus").attr("disabled","true")
            $("#fan_num").text(""+(parseInt($("#fan_num").text())+1))
        }else{
            alert("关注失败")
        }
     },"json");
}
function zhuxiao(){
	$("#zhuxiao").click(function(){
		window.location.href="/Soup/login.jsp"
	})
}
function like(){
    $(".like_button").click(function(){
        var article_id=$(this).parent().parent().attr("id");
        var time=""+new Date().getTime()
        $.get("/Soup/like",{"article_id":article_id,"time":time},function(data,status){
            if(data.code==0){
                $(this).siblings(".like_num").first().text(""+(parseInt($(this).siblings(".like_num").first().text())+1))
                $(this).unbind("click")
                $(this).attr("class","haslike_button")
                $(this).find("img").attr("src","img/yidianzan.png")
                $(this).attr("disabled","true")
            }else{
                alert("点赞失败")
            }
         }.bind(this),"json"); 
         
    });
}
function clearCookie(name) {  
    setCookie(name, "", -1);  
} 
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}
function unlike(){
    $(".unlike_button").click(function(){
        var article_id=$(this).parent().parent().attr("id");
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
        var article_id=$(this).parent().parent().attr("id");
        $.get("/Soup/showComment",{"article_id":article_id},function(data,status){
            if(data.code==0){
                var comments=data.comments
                for(var i=0;i<comments.length;i++){
                    var comment=$("<p></p>").text(comments[i].username+":"+comments[i].content)
                    $(this).parent().siblings(".comments").first().append(comment)  
                }
                $(this).parent().siblings(".comments").first().toggle()
                $(this).unbind("click").click(function(){
                $(this).parent().siblings(".comments").first().toggle()
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
        var content=$(this).siblings(".write_comment").first().val()
        $(this).siblings(".write_comment").first().val("")
        $.get("/Soup/publishComment",{"article_id":article_id,"time":time,"content":content},function(data,status){},"json")
        var comment=$("<p></p>").text(user_email+":"+content)
        $(this).parent().append(comment)
    })
}
window.onload=function(){
	if(document.getElementById("focus"))
    	document.getElementById("focus").onclick=focus;
	$(".comments").hide()
    like()
    unlike()
	showComment()
	writeComment()
	zhuxiao()
}
</script>	
</html>