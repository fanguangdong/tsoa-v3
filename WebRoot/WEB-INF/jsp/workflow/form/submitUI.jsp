<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>提交申请</title>
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

<script type="text/javascript">
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
	
	//手动触发验证，被验证的表单元素是containerId容器里的。 可以验证整个表单，也可以验证部分表单。
	function validateForm(containerId){
		
	    var valid = $(containerId).validationEngine({returnIsValid: true});
		if(valid == true){
			top.Dialog.alert('恭喜');
		}else{
		    top.Dialog.alert('糟糕，填写不正确');
		} 
	} 
	
	function validateFile() {
		var fileValue = $("#fu").val();
		if(!fileValue) {
			top.Dialog.alert("请选择需要上传的文件|表单验证错误", function(){ });
			return false;
		} else {
			return true;
		}
	}

</script>
</head>

<body>

<div class="box2" panelTitle="功能面板" roller="false">
	<s:form>
		<s:hidden name="formTemplateId"></s:hidden>
		<table>
			<tr>
				<td><button type="button" onclick="openurl('formTemplate_download.action', 'id', <s:property value='formTemplateId'/>)"><span class="icon_doc">下载文档模板文件</span></button></td>
				<td><div class="red">&nbsp;</div></td>
			</tr>
		</table>
	</s:form>
</div>

<div id="scrollContent">
	<div class="box2" panelWidth="500" panelTitle="提交申请" failAlert="表单填写不正确，请按要求填写！">
	
		<s:form action="form_submit" enctype="multipart/form-data" id="formsubmit">
			<s:hidden name="formTemplateId"></s:hidden>
			<table class="tableStyle">
				
				<tr><td width="150">选择上传文档：</td> <td><input id="fu" type="file" name="upload"/></td></tr>
				
				<tr><td colspan="2"><input type="submit" onclick="return validateFile();" value="提交"/>&nbsp;<input type="button" onclick="history.back()" value="返回"/></td></tr>
				
			</table>
		</s:form>
	</div>
	
	
</div>
</body>
</html>

