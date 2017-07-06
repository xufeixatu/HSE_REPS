<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib tagdir="/WEB-INF/tags/zsk" prefix="hse" %>
<html>
<head>
	<title>文档管理</title>
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
		<li><a href="${ctx}/zsk/zskDocument/">文档列表</a></li>
		<li class="active"><a href="${ctx}/zsk/zskDocument/form?id=${zskDocument.id}">文档<shiro:hasPermission name="zsk:zskDocument:edit">${not empty zskDocument.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zsk:zskDocument:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="zskDocument" action="${ctx}/zsk/zskDocument/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label">分类编号：</label>
			<div class="controls">
				<form:input path="classid" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
			<div class="control-group">
			<label class="control-label">分类:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="classid" value="${zskClass.parent.id}" labelName="parent.name" labelValue="${zskClass.id}"
					title="父级编号" url="/zsk/zskClass/treeData" extId="${zskClass.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件名称：</label>
			<div class="controls">
				<form:input path="fileName" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	  <div class="control-goup">
			<label class="control-label">文件路径：</label>
			<div class="controls">
				<form:hidden id="filePath" path="filePath" htmlEscape="false" class="input-xlarge"/>
				<sys:ckfinder input="filePath" type="files" uploadPath="/zsk/zskDocument" selectMultiple="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件描述信息：</label>
			<div class="controls">
				<form:textarea path="descInfo" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">文件类型：</label>
			<div class="controls">
				<form:input path="docType" htmlEscape="false" maxlength="10" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<hr>
		<%--  <div class="control-group">
			<label class="control-label">版本号码：</label>
			<div class="controls">
				<form:input path="versionNo" htmlEscape="false" maxlength="60" class="input-xlarge "/>
			</div>
		</div>  --%>
		<div class="control-group">
			<label class="control-label">修改原因：</label>
			<div class="controls">
				<form:textarea path="modifyReason" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">修改内容：</label>
			<div class="controls">
				<form:textarea path="modifyContent" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zsk:zskDocument:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>