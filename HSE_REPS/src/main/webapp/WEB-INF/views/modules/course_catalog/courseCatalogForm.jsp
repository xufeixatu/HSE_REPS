<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课件类别管理管理</title>
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
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
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
		<li><a href="${ctx}/course_catalog/courseCatalog/">课件类别管理列表</a></li>
		<li class="active"><a href="${ctx}/course_catalog/courseCatalog/form?id=${courseCatalog.id}&parent.id=${courseCatalogparent.id}">课件类别管理<shiro:hasPermission name="course_catalog:courseCatalog:edit">${not empty courseCatalog.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="course_catalog:courseCatalog:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="courseCatalog" action="${ctx}/course_catalog/courseCatalog/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">上级父类ID:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${courseCatalog.parent.id}" labelName="parent.name" labelValue="${courseCatalog.parent.name}"
					title="父类ID" url="/course_catalog/courseCatalog/treeData" extId="${courseCatalog.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件类别名称：</label>
			<div class="controls">
				<form:input path="catalogName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件类别描述：</label>
			<div class="controls">
				<form:textarea path="catalogDesc" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="course_catalog:courseCatalog:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>