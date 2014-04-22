<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>新增角色</title>
<%@ include file="/commons/common.jsp"%>


<!--框架必需start-->
<script type="text/javascript" src="libs/js/jquery.js"></script>
<script type="text/javascript" src="libs/js/framework.js"></script>
<link href="libs/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=request.getContextPath() %>/"/>
<link rel="stylesheet" type="text/css" id="customSkin"/>
<!--框架必需end-->

<!-- 表单验证start -->
<script src="libs/js/form/validationRule.js" type="text/javascript"></script>
<script src="libs/js/form/validation.js" type="text/javascript"></script>
<!-- 表单验证end -->

</head>
<body>
<div id="scrollContent">
	<div class="box2" panelWidth="500" panelTitle="新增用户" >
		<form:form method="post" action="role/add.oa" enctype="multipart/form-data">
			<input type="hidden" name="id"/>
			<table class="tableStyle">
				<tr><td width="150">岗位名称：</td>   <td><input type="text" name="name" class="validate[required]"/> <span class="star">*</span></td></tr> 
				
				<tr><td width="150">岗位说明：</td></td>    <td> <textarea name="description" rows="2" cols="3"></textarea> </td></tr>
				
				<!-- 
				<tr><td colspan="2"><input type="submit" value="提交"/>&nbsp;<input type="reset" value="重置"/></td></tr>
				 -->
				<tr><td colspan="2"><input type="submit" value="提交"/>&nbsp;&nbsp;<input type="button" onclick="history.back()" value="返回"/></td></tr>
				
			</table>
		</form:form>
	</div>
	
	
</div>
</body>
</html>


