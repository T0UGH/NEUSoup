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
//      alert($("#R_user_email").val())
//      alert($("#user_name").val())
//      alert($("#R_password").val())
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
//      alert($("#user_email").val())
//      alert($("#password").val())
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