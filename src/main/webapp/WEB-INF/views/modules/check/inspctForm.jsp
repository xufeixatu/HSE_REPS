<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/check/inspct/">检查记录列表</a></li>
		<li class="active"><a href="${ctx}/check/inspct/form?id=${inspct.id}">检查记录管理<shiro:hasPermission name="check:inspct:edit">${not empty inspct.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="check:inspct:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="inspct" action="${ctx}/check/inspct/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">检查部门：</label>
			<div class="controls">
				<sys:treeselect id="checkOffice" name="checkOffice.id" value="${inspct.checkOffice.id}" labelName="checkOffice.name" labelValue="${inspct.checkOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">检查时间：</label>
			<div class="controls">
				<input name="checkDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${inspct.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">受检部门：</label>
			<div class="controls">
				<sys:treeselect id="inspectionOffice" name="inspectionOffice.id" value="${inspct.inspectionOffice.id}" labelName="inspectionOffice.name" labelValue="${inspct.inspectionOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">检查类别：</label>
			<div class="controls">
				<sys:treeselect id="checkTypeClass" name="checkTypeClass.id" value="${inspct.checkTypeClass.id}" 
					labelName="checkTypeClass.name" labelValue="${inspct.checkTypeClass.name}"
					title="检查类别" url="/check/checkTypeClass/treeData" extId="${inspct.checkTypeClass.id}" cssClass="required" allowClear="true"/>
				<span class="help-inline"><font color="red">*</font></span>				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">检查模板：</label>
			<div class="controls">
				<form:select path="templateId" class="input-xlarge required">
					<form:option value="" label="请选择"/>
					<form:options items="${templates}" itemLabel="templateName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="check:inspct:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="添加"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>