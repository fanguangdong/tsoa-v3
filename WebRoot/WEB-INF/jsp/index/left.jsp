<%@ page language="java"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/commons/common.jsp" %>

<!--框架必需start-->
<script type="text/javascript" src="libs/js/jquery.js"></script>
<script type="text/javascript" src="libs/js/framework.js"></script>
<link href="libs/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=request.getContextPath()%>/"/> 
<link rel="stylesheet" type="text/css" id="customSkin"/>
<!--框架必需end-->

<!-- 树型抽屉导航start-->
<script type="text/javascript" src="libs/js/tree/ztree/ztree.js"></script>
<link href="libs/js/tree/ztree/ztree.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="libs/js/nav/treeAccordion_normal.js"></script>
<!-- 树型抽屉导航end -->
<script type="text/javascript">
	var zNodes =[
		{ id:3001, parentId:0, name:"审批流转",icon:"libs/icons/edit.gif"},
		{ id:101, parentId:3001, name:"审批流程管理",url:"processDefinition/list.oa", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:102, parentId:3001, name:"表单模板管理",url:"formTemplate/list.oa", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:103, parentId:3001, name:"起草申请",url:"form_formTemplateList.action", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:104, parentId:3001, name:"待我审批",url:"form_myTaskList.action", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:105, parentId:3001, name:"我的申请查询",url:"form_myApplicationList.action", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		{ id:3009, parentId:0, name:"系统管理",icon:"libs/icons/edit.gif"},
		{ id:301, parentId:3009, name:"用户管理",url:"user/list.oa", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:302, parentId:3009, name:"岗位管理",url:"role/list.oa", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:303, parentId:3009, name:"部门管理",url:"form_formTemplateList.action", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		{ id:3002, parentId:0, name:"表格模板",icon:"libs/icons/layers.gif"},
		{ id:201, parentId:3002, name:"页面中的grid表格",url:"../../sample/demo/grid-page.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:202, parentId:3002, name:"弹窗中的grid表格",url:"../../sample/demo/grid-pop.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:203, parentId:3002, name:"页面中的table表格",url:"../../sample/demo/table-page.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:204, parentId:3002, name:"弹窗中的table表格",url:"../../sample/demo/table-pop.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		{ id:3003, parentId:0, name:"选项卡模板",icon:"libs/icons/find2.gif"},
		{ id:301, parentId:3003, name:"页面中的选项卡",url:"../../sample/demo/tab-page.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:302, parentId:3003, name:"弹窗中的选项卡",url:"../../sample/demo/tab-pop.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		{ id:3004, parentId:0, name:"布局模板",icon:"libs/icons/img.gif"},
		{ id:401, parentId:3004, name:"单级纵向导航",url:"../../sample/demo/nav-single.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:402, parentId:3004, name:"双级纵向导航",url:"../../sample/demo/nav-double.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:403, parentId:3004, name:"分隔条",url:"../../sample/demo/spliter.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		{ id:3005, parentId:0, name:"图片模板",icon:"libs/icons/key.gif"},
		{ id:501, parentId:3005, name:"图片列表",url:"../../sample/demo/pic-list.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		
		{ id:3006, parentId:0, name:"情景模板",icon:"libs/icons/list.gif"},
		{ id:601, parentId:3006, name:"机构维护",url:"../../sample/demo/org-management.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:602, parentId:3006, name:"用户管理",url:"../../sample/demo/user-management.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:603, parentId:3006, name:"角色管理",url:"../../sample/demo/role-management.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:604, parentId:3006, name:"资源分配(按用户)",url:"../../sample/demo/user-assignment.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:605, parentId:3006, name:"资源分配(按角色)",url:"../../sample/demo/role-assignment.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:606, parentId:3006, name:"综合box容器布局",url:"../../sample/demo/layout-box.html", target:"frmright",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		
		{ id:3007, parentId:0, name:"多级示例",icon:"libs/icons/lightOn.gif"},
		{ id:701, parentId:3007, name:"第二级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:702, parentId:3007, name:"第二级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:703, parentId:3007, name:"第二级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:704, parentId:703, name:"第三级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:705, parentId:703, name:"第三级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:706, parentId:705, name:"第四级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:707, parentId:705, name:"第四级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"},
		{ id:708, parentId:707, name:"第五级节点",iconOpen:"libs/icons/folder_doc.gif",iconClose:"libs/icons/folder_doc.gif",icon:"system/layout/skin/titlebar_arrow.gif"}
	];
</script>
</head>

<body leftFrame="true">
<div class="padding_top5 ali02">
<table width="100%">
	<tr>
		<td width="85%" class="ali03"><input type="text" id="searchKey" value=""></td>
		<td><span class="img_find hand" title="点击查找节点" keepDefaultStyle="true" onclick="findNode()"></span></td>
	</tr>
	<tr>
		<td colspan="2" class="ali02"><a onclick="showAll()">全部展开</a>&nbsp;&nbsp;<a onclick="hideAll()">全部收缩</a></td>
	</tr>
</table>
</div>
<div id="scrollContent">
	<div>
		<ul id="treeDemo" class="ztree ztree_accordition"></ul>
	</div>
</div>				
</body>
</html>