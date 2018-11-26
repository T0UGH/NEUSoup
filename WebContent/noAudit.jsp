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
<link rel="stylesheet" type="text/css" href="css/global-main.css">
<script src="jquery.js"></script>
<script src="uploadFile.js"></script>
<title>审批文章</title>
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
	<div class="background_wall"></div>
    	<center>暂时没有可审批的文章了</center>
    </div>
</body>
</html>