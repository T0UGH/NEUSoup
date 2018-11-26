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
<title>联系我们</title>
	<link rel="stylesheet" href="css/contact_style.css" type="text/css" media="all" />
	<script src="http://api.map.baidu.com/api?v=1.4" type="text/javascript"></script> 
	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
	
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
	
<div class="left-content">
	<div class="contact-heading">
					<h2 class="wow fadeInDown animated" data-wow-delay=".5s">CONTACT US</h2>
		            <h3 class="wow fadeInDown animated" data-wow-delay=".5s">联系我们</h3>
					<p class="wow fadeInUp animated" data-wow-delay=".5s">SHENYANG，LIAONING</p>
				</div>
	<div id="container"></div>
	<script type="text/javascript"> var map = new BMap.Map("container"); // 创建地图实例 
		var point = new BMap.Point(123.4312011693,41.6589485136); // 创建点坐标 
		map.centerAndZoom(point, 15); // 初始化地图，设置中心点坐标和地图级别 
		map.addControl(new BMap.NavigationControl());   
		map.addControl(new BMap.ScaleControl());   
		map.addControl(new BMap.OverviewMapControl());   
		map.addControl(new BMap.MapTypeControl());   
		map.setCurrentCity("沈阳");
		function addMarker(point, index){   
// 创建图标对象   
			var myIcon = new BMap.Icon("img/marker_red_sprite.png", new BMap.Size(60,65)
									   , {
				 offset: new BMap.Size(50, 100), 
                     imageOffset: new BMap.Size(5,0),
                     
                 });
				// 创建标注对象并添加到地图    
				var marker = new BMap.Marker(point, {icon: myIcon});    
			map.addOverlay(marker);   
		}  
		addMarker(point,200);
	</script> 
	
	<div class="contact-form" data-wow-delay=".5s">
				<h4>Contact Form</h4>
				<form>
					<input type="text" placeholder="Name" required="">
					<input type="email" placeholder="Email" required="">
					<textarea placeholder="Message" required=""></textarea>
					<button class="btn1 btn-1 btn-1b">Submit</button>
				</form>
			</div>
	</div>
	
	
</body>
</html>
