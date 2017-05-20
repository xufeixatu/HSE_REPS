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
		<li class="active"><a href="#"><shiro:hasPermission name="check:question:edit">${question.act.taskName}</shiro:hasPermission><shiro:lacksPermission name="check:question:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="question" action="${ctx}/check/question/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<fieldset>
			<legend>${question.act.taskName}</legend>
			<table class="table-form">
				<tr>
					<td class="tit">问题描述</td>
					<td colspan="3">
						${question.questionDesc}
					</td>
				</tr>
				<tr>
					<td class="tit">检查类别</td>
					<td>
						${question.checkTypeClass.name}
					</td>
					<td class="tit">问题级别</td>
					<td>
						${fns:getDictLabel(question.questionLevelId, 'problem_level', '')}				
					</td>
				</tr>			
				<tr>
					<td class="tit">上传照片</td>
					<td>
										
					</td>
					<td class="tit">受检部门</td>
					<td>
						${question.checkedOffice.name}					
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
				<tr>
					<td class="tit">处理人</td>
					<td>
		                <sys:treeselect id="currentAuditUser" name="currentAuditUser.id" value="${question.currentAuditUser.id}" 
		                labelName="currentAuditUser.name" labelValue="${question.currentAuditUser.name}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
						<span class="help-inline"><font color="red">*</font> </span>					
					</td>					
				</tr>								
				<tr>
					<td class="tit">您的意见</td>
					<td colspan="5">
						<form:textarea path="act.comment" class="required" rows="5" maxlength="20" cssStyle="width:500px"/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="check:question:edit">
 				<%-- <c:if test="${question.act.taskDefKey ne 'reporter_end'}">
				</c:if> --%>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="通过" onclick="$('#flag').val('yes')"/>&nbsp;
				<input id="btnSubmit" class="btn btn-inverse" type="submit" value="不通过" onclick="$('#flag').val('no')"/>&nbsp;				
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<act:histoicFlow procInsId="${question.act.procInsId}"/>
	</form:form>
</body>
</html>
