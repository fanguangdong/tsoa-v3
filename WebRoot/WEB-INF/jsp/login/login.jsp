<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<title>天时传媒OA管理系统</title>
<%@include file="/commons/common.jsp" %>

<link href="system/login/skin/style.css" rel="stylesheet" type="text/css" id="skin"/>
<script type="text/javascript" src="libs/js/jquery.js"></script>
<script type="text/javascript" src="libs/js/login.js"></script>

<!--居中显示start-->
<script type="text/javascript" src="libs/js/method/center-plugin.js"></script>
<!--居中显示end-->

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
<script type="text/javascript">
	function showErrorMsg(msg)
	{
		var _div = "<div class='k-state-error'>";
		_div += msg;
		_div +="</div>"
		$("#msg").html(_div);
	}

	function isNull(_str)
	{
		return _str==null || _str=='';
	}
	$(function(){
		$("#submitBtn").click(function(event){
		
			 var uName = $("#loginName").val();
			 var pwd = $("#password").val();
			 if(isNull(uName) || isNull(pwd) )
			 {
			  	showErrorMsg("login.msg.accountInvalid");
			 }
			 else
			 {
				 var url="<%=request.getContextPath()%>/user/login.oa";
				 var params = {loginName:uName, password:pwd};
			 	$.post(
			 		url,	
			 		params,
			 		function(data){
			 			if(data && 1 == data.status)
		 				{
		 					//${base_context}
			 				window.location.href="<%=request.getContextPath()%>/index.oa"
		 				} else {
		 					
		 					showErrorMsg("用户名或密码错误！");
		 				}
			 		},
			 		"json"
			 	);
			 }
			  event.preventDefault();
		})
		.button()
		.next()
		.button()
		;
	});

</script>
</head>

<body>
	<div class="login_main">
		<div class="login_top">
		</div>
		<div class="login_middle">
			<div class="login_middleleft"></div>
			<div class="login_middlecenter">
			
			
				<form id="loginForm" action="#" class="login_form" method="post">
					<div class="login_user"><input type="text" id="loginName" name="loginName"/></div>
					<div class="login_pass"><input type="password" id="password" name="password"/></div>
					<div class="clear"></div>
					
					<div class="login_button">
						<div class="login_button_left"><input id="submitBtn" type="button" value="" onfocus="this.blur()"/></div>
						<div class="login_button_right"><input type="reset" value="" onfocus="this.blur()"/></div>
						<div class="clear"></div>
					</div>
				</form>
					
					
					
					<div class="login_info" id="msg" style="display:block;">
						<font color="red"></font>
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
	function login1() {
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
			window.location="user/login.oa";  
		}
	}
	
	
	$(function(){
	
	top.$("#loginWin").dialog({
		autoOpen: true,
		width: 300,
		height: 200,
		pisition: { my: "center", at: "center", of: window },
		modal:false,
		resizable:false,
		
		title:"UserLogin"
	});
	/*
	$("#loginWin").kendoWindow({
		  actions		: [ ],
		  animation		: false,
		 
		  width			: 300,
		  height		: 140,
		  resizable		: false,
		  draggable		: false

		});
	*/
	//var loginWin = $("#loginWin").data("kendoWindow");
	//loginWin.center();
	
	//$("#msgTable").hide();
	
	
		
	

});
</script>
</body>
</html>

