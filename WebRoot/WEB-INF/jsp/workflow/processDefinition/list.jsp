<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<%@include file="/commons/common.jsp" %>

<!--框架必需start-->
<script type="text/javascript" src="libs/js/jquery.js"></script>
<script type="text/javascript" src="libs/js/framework.js"></script>
<link href="libs/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=request.getContextPath() %>/"/>
<link rel="stylesheet" type="text/css" id="customSkin"/>
<!--框架必需end-->

<!-- 日期选择框start -->
<script type="text/javascript" src="libs/js/form/datePicker/WdatePicker.js"></script>
<!-- 日期选择框end -->

<!--数字分页start-->
<script type="text/javascript" src="libs/js/nav/pageNumber.js"></script>
<!--数字分页end-->


<!-- 业务相关 -->
<script type="text/javascript">
	    function showProcessImage( pdId ){
	    	pdId = encodeURI(pdId); // 进行URL编码
	    	pdId = encodeURI(pdId); // 进行URL编码（第2次）
	    	var url = "${pageContext.request.contextPath}/processDefinition/showProcessImage.oa?pdId=" + pdId + "&t=" + new Date();
	    	
	    	window.showModalDialog(url, null, "dialogHeight:500px; dialogWidth:600px; resizable:yes");
        }
        
        function deleteProcessDefinition(pdKey) {
        	pdKey = encodeURI(pdKey);
        	return pdKey;
        }
        
        function deleteRecord(id) {
        	var r = false;
        	top.Dialog.confirm(info, function(){r = true;},function(){r = false;});
        	return r;
        }
    </script> 
</head>
<body>

 
<div class="box2" panelTitle="功能面板" roller="false">
	<table>
		<tr>
			<!-- 
			<td>流程名称：</td>
			<td><input id="query_userName" type="text"/></td>
			<td><button type="button" onclick="searchHandler()"><span class="icon_find">查询</span></button></td>
			 -->
			<td><button type="button" onclick="window.location.href='processDefinition/addUI.oa'"><span class="icon_add">部署流程定义文档</span></button></td>
			<td><div class="red">&nbsp;</div></td>
		</tr>
	</table>
</div>

<!--
<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
	<div class="center">
	<div class="left">
	<div class="right">
		<div class="padding_top5 padding_left10">
		<a href="javascript:;" onclick="addUser()"><span class="icon_add">新增用户</span></a>
		<div class="box_tool_line"></div>
		<a href="javascript:;" onclick="deleteUser()"><span class="icon_delete">批量删除</span></a>
		<div class="box_tool_line"></div>
		<a href="javascript:;" onclick="importUser()"><span class="icon_import">导入</span></a>
		<div class="box_tool_line"></div>
		<a href="javascript:;" onclick="exportUser()"><span class="icon_export">导出当前页</span></a>
		<div class="box_tool_line"></div>
		<a href="javascript:;"  onclick="exportUser2()"><span class="icon_export">导出全部</span></a>
		<div class="clear"></div>
		</div>
	</div>		
	</div>	
	</div>
	<div class="clear"></div>
</div> 

 -->
<div id="scrollContent" >
	<table class="tableStyle" useClick="false"  useCheckBox="true" sortMode="true">
	
		<tr>
			<th width="1"></th>
			<th width="50"><span  id="span_userName">流程名称</span></th>
			<th width="20"><span id="span_userLoginName">最新版本</span></th>
			<th width="30"><span id="span_orgName">流程描述</span></th>
			<th width="40">相关操作</th>
		</tr>
		
		<c:forEach var="pd" items="${pdList }">
		
			<tr>
				<td><input type="checkbox"/></td>
				<td>${pd.name}</td>
				<td>${pd.version}</td>	
				<td>${pd.description}</td>
				
				<td>
					<a href="javascript: showProcessImage('${pd.id}')"> 查看流程图    &nbsp;</a> 
					
					<a href="processDefinition/delete.oa?key=${pd.key}">删除</a>
					
				</td>
			</tr>
        </c:forEach>
        
	</table>
</div>

<div style="height:35px;">
	<div class="float_left padding5">
		数据共   条
	</div>
	<div class="float_right padding5">
		<div class="pageNumber" total="200" pageSize="20" showSelect="true" showInput="true" id="pageContent"></div>
	</div>
	<div class="clear"></div>
</div>
<script type="text/javascript">


</script>
</body>
</html>
	