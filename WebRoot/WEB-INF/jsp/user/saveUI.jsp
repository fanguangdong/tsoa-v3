<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

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

<script type="text/javascript">
	function readDataFromDevice() {
		alert("readDataFromDevice");
	}
</script>
</head>
<body>
<applet code="com.HelloApplet.class" id="helloApplet" codebase="." archive = "helloApplet.jar" width="0" height="0"/>
<div id="scrollContent">


<div class="box2" panelTitle="功能面板" roller="false">
	<table>
		<tr>
			<!-- 
			<td>流程名称：</td>
			<td><input id="query_userName" type="text"/></td>
			<td><button type="button" onclick="searchHandler()"><span class="icon_find">查询</span></button></td>
			 -->
			<td><button type="button" onclick="readDataFromDevice()"><span class="icon_add">从设备读取</span></button></td>
			<td><div class="red">&nbsp;</div></td>
		</tr>
	</table>
</div>

<div class="box2" panelWidth="750" panelTitle="用户信息">
	<fieldset> 
		<legend>用户基本信息</legend> 
		<table class="tableStyle" formMode="transparent" footer="normal">
			<tr>
				<td width="15%">姓名：</td><td width="35%"><input type="text"/></td>
				<td width="15%">性别：</td>
				<td><input type="radio" id="radio-1" name="ra" value="radio-1" class="hand"/><label for="radio-1" class="hand">男</label>
					<input type="radio" id="radio-2" name="ra" value="radio-2" class="hand"/><label for="radio-2" class="hand">女</label>
				</td>
			</tr>
			<tr>
				<td>证件号码：</td>
				<td><input type="text"/></td>
				<td>婚姻：</td>
				<td><input type="radio" id="radio-3" name="ra2" value="radio-3" class="hand"/><label for="radio-3" class="hand">已婚</label>
					<input type="radio" id="radio-4" name="ra2" value="radio-4" class="hand"/><label for="radio-4" class="hand">未婚</label>
				</td>
			</tr>
			<tr>
				<td>联系电话：</td>
				<td><input type="text"/></td>
				<td>出生日期：</td>
				<td>
					<input type="text" class="date"/>
				</td>
			</tr>
		</table>
	</fieldset> 
	<div class="height_15"></div>
	<fieldset> 
		<legend>用户详细信息</legend> 
		<table class="tableStyle" formMode="transparent" footer="normal">
			<tr>
				<td width="15%">籍贯：</td>
				<td width="35%">
					<select><option>北京市</option><option>天津市</option><option>黑龙江省</option></select>
				</td>
				<td width="15%">民族：</td>
				<td>
					<select><option value="1">汉族</option><option value="2">满族</option><option value="3">维吾尔族</option></select>
				</td>
			</tr>
			<tr>
				<td>学历：</td>
				<td>
				<select><option>博士</option><option>本科</option><option>大专</option><option>其它</option></select>				
				</td>
				<td>权限：</td>
				<td>
				<select><option value="1">新增图片</option><option value="2">维护图片</option><option value="3">新增新闻</option></select>
				</td>
			</tr>
		</table>
	</fieldset> 
	<div class="height_15"></div>
	<fieldset> 
		<legend>用户其他信息</legend> 
		<table class="tableStyle" formMode="transparent" footer="normal">
			<tr>
				<td width="15%">邮政编码：</td><td width="35%"><input type="text"/></td>
				<td width="15%">上传附件：</td><td><input type="file"/></td>
			</tr>
			<tr>
				<td>固定电话：</td><td><input type="text"/></td>
				
				<td>上传文档：</td><td><input type="file"/></td>
			</tr>
			<tr>
				<td>备注：</td>
				<td colspan="3">
					<textarea style="width:400px;"></textarea>
				</td>
			</tr>
		</table>
	</fieldset>
	
	<fieldset> 
		<legend>岗位设置</legend> 
		<table class="tableStyle" formMode="transparent" footer="normal">
			
			<tr>
				<td>岗位设置：</td>
				<td colspan="3">
					<select style="width:300px;" multiple="true" size="10"></select>
				</td>
			</tr>
		</table>
	</fieldset>
	<div class="height_5"></div>
	<div class="padding_top10">
		<table class="tableStyle" formMode="transparent">
			<tr>
				<td colspan="4">
					<input type="submit" value="提交"/>
					<input type="reset" value="重置"/>
				</td>
			</tr>
		</table>
	</div> 
	</div>

</div>
<script>
function initComplete(){
	 //设为不可用
	$("#form1").mask("当前不可用",500,false,"#ffffff");
}
 //设为不可用
function disableForm(){
	$("#form1").mask("当前不可用",0,false,"#ffffff");
}
//设为可用
function enableForm(){
    $("#form1").unmask();
}
</script>
</body>
</html>




<!--显示表单内容-->
<div id=MainArea>

    <s:form name="userForm" action="user_%{id == 0 ? 'add' : 'update'}.action">
        <s:hidden name="id"></s:hidden>
        <div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title1">
        	<img border="0" width="4" height="7" src="style/blue/images/item_point.gif" /> 用户信息 </div> 
        </div>
        
        <!-- 表单内容显示 --> 
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm" >
                    <tr><td width="100">所属部门</td>
                        <td><s:select name="departmentId" cssClass="SelectStyle" list="#departmentList" headerKey="-1" headerValue="请选择所属部门" listKey="id" listValue="name">
                               
                            </s:select> 
                        </td>
                    </tr>
                    <tr><td>登录名</td>              
                        <td>
                        	<s:textfield name="loginName" cssClass="InputStyle" /> *
							（登录名要唯一）
						</td>
                    </tr>
                    
                    <tr><td>姓名</td>
                        <td><s:textfield name="name" cssClass="InputStyle" /> *</td>
                    </tr>
                    
					<tr><td>性别</td>
					
                        <td>
                        	<s:radio name="gender" list="#{'1':'男', '0':'女' }"></s:radio>  
						</td>
                    </tr>
					<tr><td>身份证号</td>
                        <td><s:textfield name="idCard" cssClass="InputStyle"/></td>
                    </tr>
					<tr><td>联系电话</td>
                        <td><s:textfield name="phoneNumber" cssClass="InputStyle"/></td>
                    </tr>
                    <tr><td>E-mail</td>
                        <td><s:textfield name="email" cssClass="InputStyle"/></td>
                    </tr>
                    <tr><td>备注</td>
                        <td><s:textarea name="description" cssClass="TextareaStyle"></s:textarea></td>
                    </tr>
                </table>
            </div>
        </div>
        
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title1">
        	<img border="0" width="4" height="7" src="style/blue/images/item_point.gif" /> 岗位设置 </div> 
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
						<td width="100">岗位</td>
                        <td>
                        	<s:select name="roleIds" size="10" list="#roleList" multiple="true" cssClass="SelectStyle" listKey="id" listValue="name" >
                        		按住Ctrl键可以多选或取消选择
                        	</s:select>
                        </td>
                    </tr>
                </table>
            </div>
        </div>		
		
 
    </s:form>
</div>



</body>
</html>


