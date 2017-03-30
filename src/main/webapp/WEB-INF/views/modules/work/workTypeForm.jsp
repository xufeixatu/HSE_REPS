<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作类别管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
		<li><a href="${ctx}/work/workType/list?id=${workType.parent.id}&parentIds=${workType.parentIds}">工作类型列表</a></li>
		<li class="active"><a href="${ctx}/work/workType/form?id=${office.id}&parent.id=${workType.parent.id}">工作类型<shiro:hasPermission name="work:workType:edit">${not empty office.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="work:workType:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="workType" action="${ctx}/work/workType/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级工作类型:</label>
			<div class="controls">
                <sys:treeselect id="workType" name="parent.id" value="${workType.parent.id}" labelName="parent.name" labelValue="${workType.parent.name}"
					title="工作类别" url="/work/workType/treeData" extId="${workType.id}" cssClass="" allowClear="${workType.currentUser.admin}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作类型名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作类型名称:</label>
			<div class="controls">
				<form:input path="type_name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作类型描述:</label>
			<div class="controls">
				<form:input path="type_desc" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<c:if test="${empty office.id}">
			<div class="control-group">
				<label class="control-label">快速添加下级工作类别:</label>
				<div class="controls">
					<form:checkboxes path="childWorkTypeList" items="${fns:getDictList('work_workType_common')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="work:workType:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>