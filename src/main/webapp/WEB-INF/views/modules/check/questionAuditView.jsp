<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批管理</title>
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
		<li><a href="${ctx}/check/question/">上报问题列表</a></li>
		<li class="active">上报问题详情</li>
	</ul>
	<form:form class="form-horizontal">
		<sys:message content="${message}"/>
		<fieldset>
			<legend>上报问题详情</legend>
			<table class="table-form">
				<tr>
					<td class="tit">问题描述</td>
					<td colspan="3">
						${question.questionDesc}
					</td>
				</tr>
				<tr>
					<td class="tit">问题分类</td>
					<td>
						${question.questionDesc}
					</td>
					<td class="tit">问题级别</td>
					<td>
						${question.questionDesc}				
					</td>
				</tr>			
				<tr>
					<td class="tit">上传照片</td>
					<td>
						<form:hidden id="question.questionDesc" path="" htmlEscape="false" class="input-xlarge"/>
						<sys:ckfinder input="filePath" type="files" uploadPath="" selectMultiple="true"/>
						<span class="help-inline"><font color="red">*</font> </span>					
					</td>
					<td class="tit">受检部门</td>
					<td>
						${question.questionDesc}				
					</td>
				</tr>			
				<tr>
					<td class="tit">检查人意见</td>
					<td colspan="5">
						${question.reporterComment}
					</td>
				</tr>
				<tr>
					<td class="tit">检查部门负责人意见</td>
					<td colspan="5">
						${question.reporterLeaderComment}
					</td>
				</tr>
				<tr>
					<td class="tit">受检单位负责人意见</td>
					<td colspan="5">
						${question.rectifierLeaderComment}
					</td>
				</tr>
				<tr>
					<td class="tit">整改人意见</td>
					<td colspan="5">
						${question.rectifierComment}
					</td>
				</tr>				
			</table>
		</fieldset>
		<act:histoicFlow procInsId="${question.act.procInsId}" />
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
