<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>申请模板选择</title>
<%@include file="/commons/common.jsp" %>

<!--框架必需start-->
<script type="text/javascript" src="libs/js/jquery.js"></script>
<script type="text/javascript" src="libs/js/framework.js"></script>
<link href="libs/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=request.getContextPath() %>/"/>
<link rel="stylesheet" type="text/css" id="customSkin"/>
<!--框架必需end-->


<style>
	#scrollContent { width:1000px; padding:0; margin:0 auto; height:100%;}
</style>


<!--动画方式入场效果start-->
<script type="text/javascript" src="libs/js/pic/jomino.js"></script>
<script>
	 $(function(){
		$(".navIcon").jomino();
	});
	
	//跳转到指定Url可以指定参数 
	function openurl(url, p, v) {
		var toUrl = '';
		if(p == '') {
			toUrl = url;
		} else {
			toUrl = url + '?' + p + '=' + v;
		} 
		window.location.href = toUrl;	
	}
</script>
<!--动画方式入场效果end-->
</head>
<body>


<div class="box2" panelWidth="90%" panelTitle="请选择模板文件">
	<div id="scrollContent">
	
		<s:iterator value="#formTemplateList">
			<div class="navIcon" onclick="openurl('form_submitUI.action', 'formTemplateId', <s:property value="id"></s:property>); " style='display:block; float:left; margin:10px 10px'>
				<div class="navIcon_left"><img src="libs/icons/png/04.png"/></div>
				<div class="navIcon_right">
					<div class="navIcon_right_title"> <h3>${name}</h3> </div>
					<div class="navIcon_right_con">
						<font color="gray" size="1.5">${description}</font> 
					</div>
				</div>
				<div class="clear"></div> 
			</div>
		</s:iterator>
		
		
	</div>
</div>



</body>
</html>


