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

</head>
<body>

 
<div class="box2" panelTitle="待审批列表" roller="false">
	<!-- 
	<table>
		<tr>
			 
			<td>流程名称：</td>
			<td><input id="query_userName" type="text"/></td>
			
			<td>时间：</td>
			<td><input type="text" class="date"/></td>
			
			
			<td><button type="button" onclick="searchHandler()"><span class="icon_find">查询</span></button></td>
			 
			<td><div class="red">&nbsp;</div></td>
		</tr>
	</table>
	 -->
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
	<form action="/userAction.do?method=getUsersBasic" method="post" id="usersForm">
	
	<table class="tableStyle" useClick="false"  useCheckBox="true" sortMode="true">
		<tr>
			<th width="1"></th>
			<th width="5"><span>标题</span></th>
			<th width="10"><span>申请人</span></th>
			<th width="1"><span>申请日期</span></th>
			<th width="40">相关操作</th>
		</tr>
		
		<s:iterator value="#taskViewList">
			<tr>
				<td><input type="checkbox"/></td>
				<td>${form.title }</td>
				<td>${form.applicant.name}</td>
				<td>${form.applyTime}</td>
				
				<td><s:a action="form_approveUI?formId=%{form.id}&taskId=%{task.id}">审批处理</s:a>
					<s:a action="form_approvedHistory?formId=%{form.id}">查看流转记录</s:a>
				</td>
				
			</tr>
        </s:iterator>
		
	</table>
	</form>
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

