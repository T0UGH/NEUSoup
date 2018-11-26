<%@page import="com.edu.neu.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>NEU Soup</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/global-main.css">
  <link rel="stylesheet" type="text/css" href="css/nav.css">
  <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
  <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
  <style>
html,body{height: 100%;width: 100%;}
body,ol,ul,h1,h2,h3,h4,h5,h6,p,th,td,dl,dd,form,fieldset,legend,input,textarea,select{margin:0;padding:0} 
body{font-size:12px;font-family:'微软雅黑';background:#fff;height: 100%;width: 100%;background-color: #fff;} 
a{color:#2d374b;text-decoration:none} 
a:hover{color:#cd0200;text-decoration:underline} 
em{font-style:normal} 
li{list-style:none} 
img{border:0;vertical-align:middle} 
table{border-collapse:collapse;border-spacing:0} 
p{word-wrap:break-word}
#content { 
	width: 100%;
	height: 100%; 
	top: 0px;
	overflow: hidden; 
	position: absolute; 
}
#snowflake { 
	width: 100%; 
	height: 100%; 
	position: absolute; 
	top: 0; 
	left: 0; 
	overflow: hidden; 
}
.snowRoll { 
	position: absolute; 
	opacity: 0; 
	-webkit-animation-name: mysnow; 
	-webkit-animation-duration: 20s; 
	-moz-animation-name: mysnow; 
	-moz-animation-duration: 20s; 
	height: 80px; 
}
@-webkit-keyframes mysnow {  
	0% {
	 bottom: 100%;
	}
	 50% {
	 -webkit-transform: rotate(1080deg);
	}
	 100% {
	 -webkit-transform: rotate(0deg) translate3d(50px, 50px, 50px);
	}
}
@-moz-keyframes mysnow {  
	0% {
	 bottom: 100%;
	}
	 50% {
	 -moz-transform: rotate(1080deg);
	}
	 100% {
	 -moz-transform: rotate(0deg) translate3d(50px, 50px, 50px);
	}
}
</style>
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
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/ShowAllArticle" onclick="return checkSession()">
      					       文章
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/showArticleByUserEmail" onclick="return checkSession()">
       						个人
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" data-c_spy="scroll" href="/Soup/Contact.jsp" onclick="return checkSession()">
       						联系
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" href="/Soup/auditArticle" onclick="return checkSession()">
       						审批
      					</a>
     				</li>
     				<li class="nav-listitem">
      					<a class="nav-link" href="/Soup/PublishArticle.jsp" onclick="return checkSession()">
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
    <div id="introduce">
 		<div id="backg"><img src="img/backin.png" height="700px" width="1000px"></div>
	 		<div id='content'>
        		<!-- 飘花 -->
        	<div id="snowflake"></div>
    	</div>	
 	</div>
<script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.transit.js"></script>
	<script type="text/javascript">
	$(function() {
        var snowflakeURl = [
            './img/icon_petal_1.png',
            './img/icon_petal_2.png',
            './img/icon_petal_3.png',
            './img/icon_petal_4.png',
            './img/icon_petal_5.png',
            './img/icon_petal_6.png',
            './img/icon_petal_7.png',
            './img/icon_petal_8.png'
        ]  
        var container = $("#content");
           visualWidth = container.width();
           visualHeight = container.height();
        function snowflake() {
            // 雪花容器
            var $flakeContainer = $('#snowflake');
    　　　　　　
            // 随机六张图
            function getImagesName() {
                return snowflakeURl[[Math.floor(Math.random() * 8)]];
            }
            // 创建一个雪花元素
            function createSnowBox() {
                var url = getImagesName();
                return $('<div class="snowbox" />').css({
                    'width': 25,
                    'height': 26,
                    'position': 'absolute',
                    'backgroundRepeat':'no-repeat',
                    'zIndex': 100000,
                    'top': '-41px',
                    'backgroundImage': 'url(' + url + ')'
                }).addClass('snowRoll');
            }
            // 开始飘花
            setInterval(function() {
                // 运动的轨迹
                var startPositionLeft = Math.random() * visualWidth - 100,
                    startOpacity    = 1,
                    endPositionTop  = visualHeight - 40,
                    endPositionLeft = startPositionLeft - 100 + Math.random() * 500,
                    duration        = visualHeight * 10 + Math.random() * 5000;
                // 随机透明度，不小于0.5
                var randomStart = Math.random();
                randomStart = randomStart < 0.5 ? startOpacity : randomStart;
                // 创建一个雪花
                var $flake = createSnowBox();
                // 设计起点位置
                $flake.css({
                    left: startPositionLeft,
                    opacity : randomStart
                });
                // 加入到容器
                $flakeContainer.append($flake);
                // 开始执行动画
                $flake.transition({
                    top: endPositionTop,
                    left: endPositionLeft,
                    opacity: 0.7
                }, duration, 'ease-out', function() {
                    $(this).remove() //结束后删除
                });
            }, 500);
        }
         snowflake();
    　　　//执行函数
    })
	</script>
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
        var s="<div class='wrapper'> <h2>Sign In</h2> <div class='w3ls-form'> <form action='login' method='post' onsubmit='return checkLogin();'> <label>UserEmail</label> <input id='user_email' type='text' name='user_email' placeholder='UserEmail' required/> <label>Password</label> <input id='password' type='password' name='password' placeholder='Password' required /> <a onclick='showRmsgDiv();return false;' class='pass'>Join Us ?</a> <input type='submit' name='login' value='Log In'/> <input type='submit' value='Quit' href=\'javascript:void(0);\' onclick='delWinD();return false;'/> </form> </div> <div class='agile-icons'> <a href='#''><span class='fa fa-weixin' aria-hidden='true'></span></a> <a href='#''><span class='fa fa-qq'></span></a> <a href='#''><span class='fa fa-weibo'></span></a> </div> </div> <div class='copyright'> <p>© 2018 Rue Login. All rights reserved | Design by Mike</p>  </div>"
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
        var r="<div class='wrapper'> <h2>Register</h2> <div class='w3ls-form'> <form action='register' method='post' onsubmit='return checkRegister();'> <label>UserEmail</label> <input id='R_user_email' type='text' name='R_user_email' placeholder='UserEmail' required/> <label>Username</label> <input id='user_name' type='text' name='user_name' placeholder='Username' required /> <label>Password</label> <input id='R_password' type='password' name='R_password' placeholder='Password' required /> <label>Confirm</label> <input id='repassword' type='password' name='repassword' placeholder='Confirm' required /> <input type='hidden' name='time' id='time' value='' required/> <input type='submit' value='Register' name='register'/> <input type='submit' value='Quit' href=\'javascript:void(0);\' onclick='delWinD();return false;'/> </form> </div> <div class='agile-icons'> <a href='#''><span class='fa fa-weixin' aria-hidden='true'></span></a> <a href='#''><span class='fa fa-qq'></span></a> <a href='#''><span class='fa fa-weibo'></span></a> </div> </div> <div class='copyright'> <p>© 2018 Rue Login. All rights reserved | Design by Mike</p>  </div>"
        RmsgObj.innerHTML =r;
        document.body.appendChild(RmsgObj);
        document.getElementById("RmsgDiv").style.display="none";
    }
    function delWinD()
    {
       document.getElementById("bgDiv").style.display="none";
       document.getElementById("LmsgDiv").style.display="none";
       document.getElementById("RmsgDiv").style.display="none";
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
      //alert($("#R_user_email").val())
      //alert($("#user_name").val())
      //alert($("#R_password").val())
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
    function checkLogin (){
      //alert($("#user_email").val())
      //alert($("#password").val())
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
    }
    </script>
</body>
</html>