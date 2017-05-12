<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
</head>
<body>
	<ul class="nav nav-tabs">
			<li><a
				href="${ctx}/work/workPlan/workList/?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>
			<shiro:hasPermission name="work:workPlan:edit">
				<li><a
						href="${ctx}/work/workPlan2/dept_remain_list?planType=${planTypeDict.value}">待受理${planTypeDict.label}列表</a></li>
				<li><a
						href="${ctx}/work/workPlan2/dept_remainned_list?planType=${planTypeDict.value}">已受理${planTypeDict.label}列表</a></li>
				<li><a
						href="${ctx}/work/workPlan2/dept_clos_remainned_feedback_list?planType=${planTypeDict.value}">待关闭${planTypeDict.label}受理反馈列表</a></li>
				<li><a
						href="${ctx}/work/workPlan2/dept_closed_remain_feedback_list?planType=${planTypeDict.value}">已关闭${planTypeDict.label}受理反馈列表</a></li>
				<li><a>点评</a></li>
			</shiro:hasPermission>
	</ul>
	<form:form action="${ctx}/work/workPlan2/dept_workplan_comment_save" method="post" id="auditingForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="remainId" />
		<input type="hidden" name="planType" value="department" />
		<div class="control-group">
			<label class="control-label">点评:</label>
			<div class="controls">
				<form:textarea path="commentContent" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">打分:</label>
			<div class="controls">
				<form:input path="score" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div class="form-actions">
			
			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="点评"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>