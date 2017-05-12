<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>risk管理</title>
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
	<%-- 	<li><a href="${ctx}/risk/risk/riskAccess/">risk列表</a></li> --%>
		<li class="active"><a href="${ctx}/risk/risk/riskAccess/form?id=${riskAccess.id}">风险识别<shiro:hasPermission name="risk:risk:riskAccess:edit">${not empty riskAccess.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="risk:risk:riskAccess:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="riskAccess" action="${ctx}/risk/risk/riskAccess/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">风险类型：</label>
			<div class="controls">
				<form:radiobuttons path="riskType" items="${fns:getDictList('risk_Type')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类别：</label>
			<div class="controls">
				<form:select path="category" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('risk_class')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">场所、设备：</label>
			<div class="controls">
				<form:input path="placeDevice" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">风险名称(环境因素名称/安全风险名称)：</label>
			<div class="controls">
				<form:input path="riskName" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">作业活动名称/活动、物料、产品、服务：</label>
			<div class="controls">
				<form:input path="workName" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">危害因素（危险源）：</label>
			<div class="controls">
				<form:input path="riskFactors" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">时态：</label>
			<div class="controls">
				<form:radiobuttons path="tense" items="${fns:getDictList('tense_Type')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('status_Type')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">可能导致的后果：</label>
			<div class="controls">
				<form:textarea path="result" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是非判断：</label>
			<div class="controls">
				<form:radiobuttons path="judgeTf" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
	<%-- 	<div class="control-group">
			<label class="control-label">评价结果ID：</label>
			<div class="controls">
				<form:input path="accessid" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
<%-- 		<div class="control-group">
			<label class="control-label">是否重大风险：</label>
			<div class="controls">
				<form:radiobuttons path="isHeaverisk" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div> --%>
                          <%-- <div class="control-group">
			<label class="control-label">对应上年度的辨识项：</label>
			<div class="controls">
				<form:input path="lastyearRecognize" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div> --%>
	<%-- 	<div class="control-group">
			<label class="control-label">风险等级：</label>
			<div class="controls">
				<form:select path="riskLevel" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
	<%-- 	<div class="control-group">
			<label class="control-label">工作流实例ID：</label>
			<div class="controls">
				<form:input path="workflowid" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">责任单位：</label>
			<div class="controls">
				<form:select path="dutyUnit" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
                  <%-- 		<div class="control-group">
			<label class="control-label">对应管理方案：</label>
			<div class="controls">
				<form:hidden id="managementPlan" path="managementPlan" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="managementPlan" type="files" uploadPath="/risk/risk/riskAccess" selectMultiple="true"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">影响（可能导致的事故、环境影响）：</label>
			<div class="controls">
				<form:textarea path="affect" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">措施（采取的消减、控制措施，现有控制方法）：</label>
			<div class="controls">
				<form:textarea path="measure" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排放频率：</label>
			<div class="controls">
				<form:select path="frequency" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('emission_frequency')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">触发原因：</label>
			<div class="controls">
				<form:textarea path="reason" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="risk:risk:riskAccess:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>