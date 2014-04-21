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

<div id="scrollContent" >
	<table class="tableStyle" useClick="false"  useCheckBox="true" sortMode="true">
		<tr>
			<th width="1"></th>
			<th width="5"><span>审批人</span></th>
			<th width="10"><span>审批时间</span></th>
			<th width="1"><span>审批结果</span></th>
			<th width="40">审批意见</th>
		</tr>
		
		<s:iterator value="#approveInfos">
			<tr>
				<td><input type="checkbox"/></td>
				<td>${approver.name}</td>
				<td>${approveTime}</td>
				<td>${approval ? '通过' : '未通过'}</td>
				<td>${comment}</td>
				
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

</body>
</html>


