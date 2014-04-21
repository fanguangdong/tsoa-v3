<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>天时传媒OA管理系统</title>
<%@include file="/commons/common.jsp" %>

<link href="system/login/skin/style.css" rel="stylesheet" type="text/css" id="skin"/>
<script type="text/javascript" src="libs/js/jquery.js"></script>
<script type="text/javascript" src="libs/js/login.js"></script>

<!--居中显示start-->
<script type="text/javascript" src="libs/js/method/center-plugin.js"></script>
<!--居中显示end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="libs/js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<style>
/*提示信息*/	
#cursorMessageDiv {
	position: absolute;
	z-index: 99999;
	border: solid 1px #cc9933;
	background: #ffffcc;
	padding: 2px;
	margin: 0px;
	display: none;
	line-height:150%;
}
/*提示信息*/
</style>
</head>
<body >
	<div class="login_main">
		<div class="login_top">
		</div>
		<div class="login_middle">
			<div class="login_middleleft"></div>
			<div class="login_middlecenter">
			
			
					<form id="loginForm" action="user_login.action" class="login_form" method="post">
					<div class="login_user"><input type="text" id="loginName" name="loginName"></div>
					<div class="login_pass"><input type="password" id="password" name="password"></div>
					<div class="clear"></div>
					
					<div class="login_button">
						<div class="login_button_left"><input type="submit" value="" onfocus="this.blur()"/></div>
						<div class="login_button_right"><input type="reset" value="" onfocus="this.blur()"/></div>
						<div class="clear"></div>
					</div>
					</form>
					
					
					
					<div class="login_info" style="display:block;">
						<font color="red"><s:fielderror/></font>
					</div>
			</div>
			<div class="login_middleright"></div>
			<div class="clear"></div>
		</div>
		<div class="login_bottom">
			<div class="login_copyright">版权所有：大连天时创世纪传媒有限公司   2014   <A HREF="javascript:void(0)">&copy; www.ts987.cn</A></div>
		</div>
	</div>
<script>
	$(function(){
		//居中
		 $('.login_main').center();
		 document.getElementById("loginName").focus();
		 $("#loginName").keydown(function(event){
		 	if(event.keyCode==13){
				login();
			}
		 });
		 $("#password").keydown(function(event){
		 	if(event.keyCode==13){
				login();
			}
		 });
		 
	});

	//登录
	function login() {
		var errorMsg = "";
		var loginName = document.getElementById("loginName");
		var password = document.getElementById("password");
		if(!loginName.value){
			errorMsg += "&nbsp;&nbsp;用户名不能为空!";
		}
		if(!password.value){
			errorMsg += "&nbsp;&nbsp;密码不能为空!";
		}

		if(errorMsg != ""){
			$(".login_info").html(errorMsg);
			$(".login_info").show();
		}
		else{
			$(".login_info").html("&nbsp;&nbsp;登录成功，正在转到主页...");
			window.location="user_login.action";  
		}
	}
</script>
</body>
</html>

