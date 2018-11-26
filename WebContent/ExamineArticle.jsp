<%@page import="com.edu.neu.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>NEU Soup</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/global-main.css">
  <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
  <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
   <script src="js/owl.carousel.js"></script>
  <link rel="stylesheet" type="text/css" href="css/article-post.css">
  <link href="css/owl.carousel.css" rel="stylesheet">
  <link href="css/owl.theme.css" rel="stylesheet">
  <%
	Article article=(Article)request.getAttribute("article");
	String content=Utility.readIntoString(article.getContent());
	String author=article.isSecret()?"匿名用户":article.getAuthor();
	String time=article.getTime().toString();
	String tag=article.getTag();
	String img_url=article.getImg_url();
  %>
</head>
<body>
	<div id="left-nav-container">
		<nav id="left-nav">
			<div class="nav-header">
				<a href="nav.html">
					<img class="brand" src="img/NEU Soup2.png">
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
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/showArticleByUserEmail" onclick="show();window.scrollByLines(10);return false;">
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
    <div id="examine-container">
    	<div class="examine-content">
    		<div class="examine-header">
    			<hr class="left-splite-line"/> 
    			<div class="examine-title">
    				<h3 class="big-title">Examine</h3>
    				<h5 class="small-title">NEU Soup</h5>
    			</div>
    			<hr class="right-splite-line"/>
    		</div>
    		<div class="examine-article">
    			<div class="row">
   						<div id="examine-owl-slider" class="owl-carousel">
   						<div class="post-slide">
   							<div id="eximg-owl-slider" class="owl-carousel">
   								<%		
								if(img_url!=null){
									String[] img_urls=img_url.split(",");
									for(int i=0;i<img_urls.length;i++){
								%>
								<div class="post-img">
									<a href="#"><img src="<%=img_urls[i]%>" alt=""></a>
								</div>
								<%
									}
								}
								%>	
							</div>	
							<div class="post-content">
								<h3 class="post-title"><a href="#"><%=author %></a></h3>
								<p class="post-description">
									<%=content %>
								</p>
								<ul class="post-bar">
								    <li><i class="fa fa-calendar"></i><%=time %></li>
								    <li>
								        <i class="fa fa-folder"></i>
								        <a href="#"><%=tag %></a>
								    </li>
								</ul>
								<div class="examine-area">
							    <hr class="article-splite-line">
								<input type="button" value="通过" id="audit_button"></input>
								<input type="button" value="不通过" id=unaudit_button></input>
								</div>
							</div>
						</div> 
					</div>
   				</div>
    		</div>
    	</div>
    </div>
    <script type="text/javascript">
    	// 弹出登录窗口
		var isshow=0;//0小窗口没有显示，1小窗口已显
		function creatediv()
		{            
		    var msgw,msgh,bordercolor;
		    msgw=400;//提示窗口的宽度
		    msgh=505;//提示窗口的高度
		    var sWidth,sHeight;
		    if( top.location == self.location )
		        doc = document;
		    var docElement = doc.documentElement;
		    sWidth=docElement.clientWidth;
		    sHeight = docElement.clientHeight;
		    if( docElement.scrollHeight > sHeight )
		        sHeight = docElement.scrollHeight;
		    var bgObj=document.createElement("div");
		    bgObj.setAttribute('id','bgDiv');
		    bgObj.style.position="absolute";
		    bgObj.style.top="0";
		    bgObj.style.left="0";
		    bgObj.style.background="#777";
		    bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
		    bgObj.style.opacity="0.6";
		    bgObj.style.width=sWidth + "px";
		    bgObj.style.height=sHeight + "px";
		    // bgObj.style.width="100%";
		    // bgObj.style.height="100%";
		    bgObj.style.zIndex = "10000";
		    document.body.appendChild(bgObj);
		        
		    var LmsgObj=document.createElement("div");
		    LmsgObj.setAttribute("id","LmsgDiv");
		    LmsgObj.setAttribute("align","center");
		    LmsgObj.style.position = "absolute";
		    LmsgObj.style.left = "50%";
		    LmsgObj.style.marginLeft = "-200px" ;
		    LmsgObj.style.top = (document.documentElement.clientHeight/2+document.documentElement.scrollTop-252)+"px";
		    // LmsgObj.style.top = "50%";
		    LmsgObj.style.zIndex = "10001";
		    var s="<div class='wrapper'> <h2>Sign In</h2> <div class='w3ls-form'> <form action='login' method='post' onsubmit='return checkLogin();'> <label>UserEmail</label> <input id='user_email' type='text' name='user_email' placeholder='UserEmail' required/> <label>Password</label> <input id='password' type='text' name='password' placeholder='Password' required /> <a onclick='showRmsgDiv();return false;' class='pass'>Join Us ?</a> <input type='submit' name='login' value='Log In'/> <input type='submit' value='Quit' href=\'javascript:void(0);\' onclick='delWinD();return false;'/> </form> </div> <div class='agile-icons'> <a href='#''><span class='fa fa-weixin' aria-hidden='true'></span></a> <a href='#''><span class='fa fa-qq'></span></a> <a href='#''><span class='fa fa-weibo'></span></a> </div> </div> <div class='copyright'> <p>© 2018 Rue Login. All rights reserved | Design by Mike</p>  </div>"
		    LmsgObj.innerHTML =s;
		    document.body.appendChild(LmsgObj);

		    var RmsgObj=document.createElement("div");
		    RmsgObj.setAttribute("id","RmsgDiv");
		    RmsgObj.setAttribute("align","center");
		    RmsgObj.style.position = "absolute";
		    RmsgObj.style.left = "50%";
		    RmsgObj.style.marginLeft = "-200px" ;
		    RmsgObj.style.top = (document.documentElement.clientHeight/2+document.documentElement.scrollTop-252)+"px";
		    // RmsgObj.style.top = "50%";
		    RmsgObj.style.zIndex = "10002";
		    var r="<div class='wrapper'> <h2>Register</h2> <div class='w3ls-form'> <form action='register' method='post' onsubmit='return checkRegister();'> <label>UserEmail</label> <input id='R_user_email' type='text' name='R_user_email' placeholder='UserEmail' required/> <label>Username</label> <input id='user_name' type='text' name='user_name' placeholder='Username' required /> <label>Password</label> <input id='R_password' type='text' name='R_password' placeholder='Password' required /> <label>Confirm</label> <input id='repassword' type='text' name='repassword' placeholder='Confirm' required /> <input type='hidden' name='time' id='time' value='' required/> <input type='submit' value='Register' name='register'/> <input type='submit' value='Quit' href=\'javascript:void(0);\' onclick='delWinD();return false;'/> </form> </div> <div class='agile-icons'> <a href='#''><span class='fa fa-weixin' aria-hidden='true'></span></a> <a href='#''><span class='fa fa-qq'></span></a> <a href='#''><span class='fa fa-weibo'></span></a> </div> </div> <div class='copyright'> <p>© 2018 Rue Login. All rights reserved | Design by Mike</p>  </div>"
		    RmsgObj.innerHTML =r;
		    document.body.appendChild(RmsgObj);
		    document.getElementById("RmsgDiv").style.display="none";
		}
		function delWinD()
		{
		   document.getElementById("bgDiv").style.display="none";
		   document.getElementById("LmsgDiv").style.display="none";
		   document.getElementById("RmsgDiv").style.display="none";
		   // document.getElementById("user_email").value="";
		   // document.getElementById("R_user_email").value="";
		   // document.getElementById("user_name").value="";
		   // document.getElementById("password").value="";
		   // document.getElementById("R_password").value="";
		   // document.getElementById("repassword").value="";    //是否需要人为清除输入框内容 进入另一页面会自动清除  
		                                                         //注意！！如果在这里清除 所有提交数据皆变为空
		   isshow=0;
		}
		function show()
		{  
		    isshow=1;
		    if(!document.getElementById("LmsgDiv"))//小窗口不存在
		        creatediv();
		    else
		    {
		        document.getElementById("bgDiv").style.display="";
		        document.getElementById("LmsgDiv").style.display="";
		        document.getElementById("RmsgDiv").style.display="none";
		        // document.getElementById("msgDiv").style.top=(document.documentElement.clientHeight/2+document.documentElement.scrollTop-252)+"px";
		    }  
		}
		function showRmsgDiv(){
			document.getElementById("LmsgDiv").style.display="none";
			document.getElementById("RmsgDiv").style.display="";
		}
		function checkRegister (){
			alert($("#R_user_email").val())
			alert($("#user_name").val())
			alert($("#R_password").val())
		   if ($("#R_user_email").val()==null||$("#R_user_email").val()=="")
		   {
		       alert("请填写用户邮箱！");
		       return false;
		   }
		   if ($("#user_name").val()==null||$("#user_name").val()=="")
		   {
		       alert("请填写用户名！");
		       return false;
		   }
		   if ($("#R_password").val()==null||$("#R_password").val()=="")
		   {
		       alert("请填写密码！");
		       return false;
		   }
		  if ($("#R_password").val()!=$("#repassword").val())
		  {
		       alert("两次密码不一致");
		       return false;
		  }
		  var time=""+new Date().getTime()
		  $("#time").val(time)
		  delWinD();
		  return true;
		}
		function checkLogin(){
			alert($("#user_email").val())
			alert($("#password").val())
		   if ($("#user_email").val()==null||$("#user_email").val()=="")
		   {
		       alert("请填写用户邮箱！");
		       return false;
		   }
		   if ($("#password").val()==null||$("#password").val()=="")
		   {
		       alert("请填写密码！");
		       return false;
		   }
		  delWinD();
		  return true;
		}
	    function checkSession(){
	        var u="<%=session.getAttribute("user")%>";
	        if(u=="null"||u==""){
	          show();
	          return false;
	        }
	        else{
	          return true;
	        }
	      };
    </script>
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
</body>
</html>