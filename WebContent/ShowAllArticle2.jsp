<%@page import="com.edu.neu.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% User requestedUser=(User)request.getAttribute("requestedUser");
		List<Article> articles=(List<Article>)request.getAttribute("articles");
		int maxPage=(Integer)request.getAttribute("maxPage");
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="jquery.js"></script>
<script src="http://cdn.staticfile.org/jquery/1.8.3/jquery.min.js"></script>
<script src="js/owl.carousel.js"></script>
<link rel="stylesheet" type="text/css" href="css/global-main1.css">
<link rel="stylesheet" type="text/css" href="css/article-post.css">
<link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
<link href="css/owl.carousel.css" rel="stylesheet">
<link href="css/owl.theme.css" rel="stylesheet">
<script>
	$(function(){
		$('#owl-slider').owlCarousel({
			items: 2,
			navigation: true,
			navigationText:["前翻","后跳"],
	    	itemsMobile:[600,1],
	    	autoPlay:true,
	    	stopOnHover:true,
	    	pagination:true,
	    	paginationNumbers:true,
		});
	});
</script>
<title>首页</title>
<%
		User user=(User)request.getSession().getAttribute("user");
		String user_email=user.getEmail();
%>
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
<div class="article-container">
	<div class="article-header">
		<hr class="left-splite-line"/> 
    	<div class="examine-title">
    		<h3 class="big-title">Article</h3>
    		<h5 class="small-title">NEU Soup</h5>
    	</div>
    	<hr class="right-splite-line"/>
	</div>
	<div class="row">
		<div id="owl-slider" class="owl-carousel">	

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
			boolean hasFocused=DBHandler.hasFocused(new Focus(user_email,watchingEmial));
			String img_url=article.getImg_url();
			if(img_url!=null&&img_url!=""){
				img_url=img_url.split(",")[0];
			}else{
				img_url="img/NEU Soup2.png";
			}
	%>
			<div class="post-slide" id=<%=article.getArticle_id()%>>
				<div class="post-img">
					<img src="<%=img_url%>" alt="">
				</div>
				<div class="post-content">
					<h3 class="post-title"><a href="/Soup/showArticleByUserEmail?page_num=1&user_email=<%=watchingEmial%>"><%=author%></a></h3>
						<p class="post-description">
							<%=content%>
						</p>
					<ul class="post-bar">
						<li><i class="fa fa-calendar"></i><%=time%></li>
						<li>
							<i class="fa fa-folder"></i>
							<a href="#"><%=tag%></a>
						</li>
						
						<%
			if(has_like){
	%>
			<li class="zan_tu"><button class="haslike_button" disabled="true"><img src="img/yidianzan.png" alt="未找到图片"></button></li>
	<%
			}else{
	%>
			<li class="zan_tu"><button class="like_button"><img src="img/dianzan.png" alt="未找到图片"></button></li>
	<%
			}
	%>
	<%
			if(has_unlike){
	%>
			<li class="zan_tu"><button class="hasunlike_button" disabled="true"><img src="img/yicai.png" alt="未找到图片"></button></li>
	<%
			}else{
	%>
			<li class="zan_tu"><button class="unlike_button"><img src="img/cai.png" alt="未找到图片"></button></li>
	<%
			}
	%>
	<%
			if(hasFocused){
	%>
			<li class="zan_tu"><button class="focus" id="focu_<%=watchingEmial%>" disabled="true"><img src="img/yiguanzhu.png" alt="未找到图片"></button></li>
	<%
			}else{
	%>
			<li class="zan_tu"><button class="focus" id="focu_<%=watchingEmial%>"><img src="img/guanzhu.png" alt="未找到图片"></button></li>
	<%
			}
	%>
	<li class="zan">赞了:<h5 class="like_num"><%=like_num%></h5></li>
						<li class="zan">踩了:<h5 class="unLike_num"><%=unLike_num%></h5></li>
			<li class="showComment_div">
				<button class="showComment_button">评</button>
				<br><br>
				<div class="comments">
				<hr>
					<input type="text" class="write_comment" value=""></input><button class="writeComment_button">发表评论</button>
				<hr>
				</div>
			</li>
			</ul>
			</div>
			</div>		
	<%
	} 
	%>
	</div>
</div>
	<div class="page_a">
	<% for(int i=1;i<=maxPage;i++){%>
		<a href=<%="/Soup/ShowAllArticle?page_num="+i%> ><%=i%></a>	
	<% } %>
	</div>
</div>

</body>
	<script>
var user_email="<%=user_email%>"
function focus(){
	$(".focus").click(function(){
        var requested_user=""+$(this).attr("id")
        var requested_user=requested_user.split("_")[1]
        var time=""+new Date().getTime()
        $.get("/Soup/focus",{"requested_user":requested_user,"time":time},function(data,status){
            if(data.code==0){
                $(this).attr("disabled","true")
                $(this).find("img").attr("src","img/yiguanzhu.png")
            }else{
                alert("关注失败")
            }
         }.bind(this),"json");     
    });
}
function like(){
    $(".like_button").click(function(){
        var article_id=$(this).parents(".post-slide").attr("id");
        var time=""+new Date().getTime()
        $.get("/Soup/like",{"article_id":article_id,"time":time},function(data,status){
            if(data.code==0){
                $(this).parents(".post-slide").find(".like_num").text(""+(parseInt($(this).parents(".post-slide").find(".like_num").text())+1))
                $(this).find("img").attr("src","img/yidianzan.png")
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
    $(".unlike_button").click(function(){
        var article_id=$(this).parents(".post-slide").attr("id");
        var time=""+new Date().getTime()
        $.get("/Soup/unlike",{"article_id":article_id,"time":time},function(data,status){
            if(data.code==0){
                $(this).parents(".post-slide").find(".unLike_num").text(""+(parseInt($(this).parents(".post-slide").find(".unLike_num").text())+1))
                $(this).unbind("click")
                $(this).attr("class","hasUnLike_button")
                $(this).attr("disabled","true")
            }else{
                alert("点踩失败")
            }
         }.bind(this),"json");   
    });
}
function showComment(){
    $(".showComment_button").click(function(){
        var article_id=$(this).parents(".post-slide").attr("id");
        $.get("/Soup/showComment",{"article_id":article_id},function(data,status){
            if(data.code==0){
                var comments=data.comments
                for(var i=0;i<comments.length;i++){
                    var comment=$("<p></p>").text(comments[i].username+":"+comments[i].content)
                    $(this).siblings(".comments").first().append(comment)  
                }
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
        var article_id=$(this).parents(".post-slide").attr("id");
        var time=""+new Date().getTime()
        var content=$(this).siblings(".write_comment").first().val()
        $(this).siblings(".write_comment").first().val("")
        $.get("/Soup/publishComment",{"article_id":article_id,"time":time,"content":content},function(data,status){},"json")
        var comment=$("<p></p>").text("我"+":"+content)
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