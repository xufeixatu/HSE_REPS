<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>增删改管理</title>
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
		<li><a href="${ctx}/adm/shopAdmin/">增删改列表</a></li>
		<li class="active"><a href="${ctx}/adm/shopAdmin/form?id=${shopAdmin.id}">增删改<shiro:hasPermission name="adm:shopAdmin:edit">${not empty shopAdmin.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="adm:shopAdmin:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="shopAdmin" action="${ctx}/adm/shopAdmin/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">shop_admin_id：</label>
			<div class="controls">
				<form:input path="shopAdminId" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">shop_admin_name：</label>
			<div class="controls">
				<form:hidden id="shopAdminName" path="shopAdminName" htmlEscape="false" maxlength="20" class="input-xlarge"/>
				<sys:ckfinder input="shopAdminName" type="files" uploadPath="/adm/shopAdmin" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">shop_admin_password：</label>
			<div class="controls">
				<form:input path="shopAdminPassword" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="adm:shopAdmin:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>