<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查问题上报</title>
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
		<%-- <li><a href="${ctx}/check/question/">上报问题列表</a></li> --%>
		<li class="active"><a href="${ctx}/check/question/form?id=${question.id}">检查问题<shiro:hasPermission name="check:question:edit">${not empty question.id?'修改':'上报'}</shiro:hasPermission><shiro:lacksPermission name="check:question:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="question" action="${ctx}/check/question/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
	    <form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<form:hidden path="checkItemCheckId"/>
		<sys:message content="${message}"/>
		<fieldset>
			<table class="table-form">
				<tr>
					<td class="tit">问题描述</td>
					<td colspan="3">
						<form:textarea path="questionDesc" class="required" rows="5" maxlength="200" cssStyle="width:500px"/>
						<span class="help-inline"><font color="red">*</font></span>		
					</td>
				</tr>
				<tr>
					<td class="tit">检查类别</td>
					<td>
						<sys:treeselect id="checkTypeClass" name="checkTypeClass.id" value="${question.checkTypeClass.id}" 
							labelName="checkTypeClass.name" labelValue="${question.checkTypeClass.name}"
							title="检查类别" url="/check/checkTypeClass/treeData" extId="${question.checkTypeClass.id}" cssClass="required" allowClear="true"/>
							<span class="help-inline"><font color="red">*</font></span>							
					</td>
					<td class="tit">问题级别</td>
					<td>
						<form:select path="questionLevelId" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('problem_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font></span>				
					</td>
				</tr>
				<tr>
					<td class="tit">上传照片</td>
					<td>
						<form:hidden id="filePath" path="" htmlEscape="false" class="input-xlarge"/>
						<sys:ckfinder input="filePath" type="files" uploadPath="" selectMultiple="true"/>
					</td>
					<td class="tit">受检部门</td>
					<td>
						<sys:treeselect id="checkedOffice" name="checkedOffice.id" value="${question.checkedOffice.id}" 
						labelName="checkedOffice.name" labelValue="${question.checkedOffice.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
						<span class="help-inline"><font color="red">*</font></span>						
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
						<form:textarea path="act.comment" rows="5" maxlength="20" cssStyle="width:500px"/>
					</td>
				</tr>				
<%-- 				<tr>
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
				</tr> --%>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="check:question:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交流程" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty question.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁流程" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
		</div>
		<c:if test="${not empty question.id}">
			<act:histoicFlow procInsId="${question.procInsId}" />
		</c:if>		
	</form:form>
</body>
</html>