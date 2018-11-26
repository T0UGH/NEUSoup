<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.edu.neu.*"%>
<%
	User user;
	if(session==null||(user=(User) session.getAttribute("user"))==null){
	request.getRequestDispatcher("login.jsp").forward(request, response);
	session.setAttribute("returnPath", request.getServletPath()+"?"+request.getQueryString());
	return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/PublishArticle.css">
<link rel="stylesheet" type="text/css" href="css/person.css">
<link rel="stylesheet" type="text/css" href="css/global-main1.css">
<script src="jquery.js"></script>
<script src="uploadFile.js"></script>
<title>发表文章</title>
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
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/showArticleByUserEmail?page_num=1&user_email=<%=user.getEmail()%>" onclick="show();window.scrollByLines(10);return false;">
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
    	<form action="publishArticle" method="post" onsubmit='return checkSubmit()'> 
    	
    	<input type="hidden" name="img_url" id="img_url" value="">
    	<input type="hidden" name="time" id="time" value="">
    	
    	<img src="img/publish.png" alt="" /><br>
        <div id="edit">
        <textarea placeholder="说点什么吧..." class="input_text" name="input_text" ></textarea><br>
        <li class="photo" ><label id="chat-tuxiang" title="上传图片" for="inputImage" >
                            <input type="file" onchange="setImg(this)" accept="image/jpg,image/jpeg,image/png"
                                   name="file" id="inputImage" class="hidden"><img id="selectPicture" src="img/upPicture.jpg" alt="" /></label></li><br>
        <div>
            <div class="myPicture"><img class="myPictureC" id="thumburlShow0" src="" width="100" height="100"/></div>
        	<div class="myPicture"><img class="myPictureC" id="thumburlShow1" src="" width="100" height="100"/></div>
        	<div class="myPicture"><img class="myPictureC" id="thumburlShow2" src="" width="100" height="100"/></div>
        	<div class="myPicture"><img class="myPictureC" id="thumburlShow3" src="" width="100" height="100"/></div><br>
        </div><br><a style="color:#4f5d61;">
    	标签</a>
    	<input type="text" name="tag" id="tag" style="background-color:#4f5d61;color:#fff;"><br>
        <br>
    	<input class="submit" type="submit" value="提交">
    	</form>
    </div>
</body>
</html>