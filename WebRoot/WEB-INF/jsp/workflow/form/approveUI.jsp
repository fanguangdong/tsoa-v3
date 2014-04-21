<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>审批处理</title>
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

<div class="box2" panelTitle="操作面板" roller="false">
	
		<table>
			<tr>
				<td><button type="button" onclick="window.location.href='form_downloadApplication.action'"><span class="icon_doc">下载文档模板文件</span></button></td>
				<td><div class="red">&nbsp;</div></td>
			</tr>
		</table>
	
</div>


<div id="scrollContent">
	<div class="box2" panelWidth="500" panelTitle="审批处理" >
	
		<s:form action="form_approve">
			<s:hidden name="formId"></s:hidden>
    		<s:hidden name="taskId"></s:hidden>
    		<s:hidden name="approval" value="true"></s:hidden>
    		
			<table class="tableStyle" formMode="transparent">
				<tr>
					<td>审批意见</td>
                    <td><s:textarea name="comments"/></td>
				</tr> 
				
				<tr>
					<td><input type="submit" value="同意"/></td>
					<td><input type=submit onclick="document.forms[0].approval.value = 'false'" value="不同意"/></td>
					<td><input type="button" onclick="history.back()" value="返回"/></td>
				</tr>
				
			</table>
			
			
			
		</s:form>
	</div>
	
</div>
</body>
</html>



<!--显示表单内容-->
<div id=MainArea>
    <s:form action="form_approve">
    	<s:hidden name="formId"></s:hidden>
    	<s:hidden name="taskId"></s:hidden>
    	<s:hidden name="approval" value="true"></s:hidden>
    
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title1">
        	<img border="0" width="4" height="7" src="style/blue/images/item_point.gif" /> 申请信息 </div> 
        </div>
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
					<tr>
						<td><a href="form_downloadApplication.action" style="text-decoration: underline">[点击下载申请的文档]</a></td>
					</tr>
                </table>
            </div>
        </div>
	
		
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                    <tr>
                        <td>审批意见</td>
                        <td><s:textarea name="comments" cssClass="TextareaStyle" cssStyle="width: 500px;"/></td>
                    </tr>
                    <s:if test="#outcomes.size() > 1">
                    <tr>
                        <td>选择下一步</td>
                        <td>
                        	<s:select name="outcome" list="#outcomes"></s:select>
                        </td>
                    </tr>
                    </s:if>
                </table>
            </div>
        </div>
		
		<!-- 表单操作 -->
        <div id="InputDetailBar" style="float:none">
			<!--onclick事件在submit之前触发-->
			<input type="image" src="style/blue/images/button/agree.png"/>
			<input type="image" onclick="document.forms[0].approval.value = 'false'" src="style/blue/images/button/disagree.png"/>
            <a href="javascript:history.go(-1);"><img src="style/images/goBack.png"/></a>
        </div>
		
    </s:form>
</div>
 
<div class="Description">
	说明：<br />
	1，同意：本次审批通过，流程继续执行。如果所有的环节都通过，则表单的最终状态为：已通过。<br />
	2，不同意：本次审批未通过，流程结束，不再继续执行。表单的最终状态为：未通过。<br />
</div>



</body>
</html>
