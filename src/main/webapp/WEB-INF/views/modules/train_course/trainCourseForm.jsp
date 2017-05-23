<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训课件上传与查看管理</title>
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
		<li><a href="${ctx}/train_course/trainCourse/">培训课件查看列表</a></li>
		<li class="active"><a href="${ctx}/train_course/trainCourse/form?id=${trainCourse.id}">上传培训课件<shiro:hasPermission name="train_course:trainCourse:edit">${not empty trainCourse.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="train_course:trainCourse:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="trainCourse" action="${ctx}/train_course/trainCourse/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">封面上传：</label>
			<div class="controls">
				<form:hidden id="coverId" path="coverId" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="coverId" type="files" uploadPath="/train_course/trainCourse" selectMultiple="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件名称：</label>
			<div class="controls">
				<form:input path="courseName" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件描述：</label>
			<div class="controls">
				<form:textarea path="courseDec" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件时长：</label>
			<div class="controls">
				<form:input path="courseTime" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件附件上传：</label>
			<div class="controls">
				<form:hidden id="docId" path="docId" htmlEscape="false" maxlength="500" class="input-xlarge"/>
				<sys:ckfinder input="docId" type="files" uploadPath="/train_course/trainCourse" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上传人：</label>
			<div class="controls">
				<form:input path="uploadBy" htmlEscape="false" maxlength="64" class="input-xlarge required" disabled = "true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上传时间：</label>
			<div class="controls">
				<input name="uploadTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${trainCourse.uploadTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="train_course:trainCourse:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>