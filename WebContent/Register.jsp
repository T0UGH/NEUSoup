<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery.js"></script>
<title>注册</title>     
</head>
<body>
<form id="formregister" action = "register" onsubmit="return checkSubmit();">
    用户注册<br>
    用户邮箱:<input type = "text" name = "user_email" id="user_email"/>
    用户名字:<input type = "text" name = "user_name" id="user_name"/>
    密码：<input type = "password" name = "password" id="password"/>
    确认密码:<input type = "password" name="repassword" id="repassword"/>
   <input type="hidden" name="time" id="time" value="">
   <input type = "submit" name="register" value ="注册"/>             
</form>
</body>
<script language="javascript">
function checkSubmit ()
{
   if ($("#user_email").val()==null||$("#user_email").val()=="")
   {
       alert("请填写用户邮箱！");
       return false;
   }
   if ($("#user_name").val()==null||$("#user_name").val()=="")
   {
       alert("请填写用户名！");
       return false;
   }
   if ($("#password").val()==null||$("#password").val()=="")
   {
       alert("请填写密码！");
       return false;
   }
  if ($("#password").val()!=$("#repassword").val())
  {
       alert("两次密码不一致");
       return false;
  }
  if ($("#password").val()!=$("#repassword").val())
  {
       alert("两次密码不一致");
       return false;
  }
  var time=""+new Date().getTime()
  $("#time").val(time)
  return true;
}
</script>
</html>