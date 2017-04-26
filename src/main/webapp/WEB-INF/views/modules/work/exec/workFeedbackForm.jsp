<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(
			function() {

				//更新时回显frequency频次的选择项开始
				<c:if test="${not empty workPlan.frequency}">
				var freqs = "${workPlan.frequency}".split(",");
				$("input[name='frequency']").each(function() {
					for (var i = 0; i < freqs.length; i++) {
						if (this.value == freqs[i]) {
							this.checked = true;
							break;
						}
					}
				});
				</c:if>
				//更新时回显frequency频次的选择项结束
				$("#name").focus();
				$("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
	//否决的方法
	function reject(){
		location = "${ctx}/work/workPlan/reject?id=${workPlan.id}&planType=${planTypeDict.value}";
	}

	//修改的方法
	function save(){
		var f = $("form")[0];
		f.submit();
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a
				href="${ctx}/work/workPlan/workList?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>
		
		<c:if test="${user.name eq office_quality.primaryPerson.name or user.name eq office_quality.deputyPerson}">
			<shiro:hasPermission name="work:workPlan:edit">
				<li class="active"><a
					href="${ctx}/work/workPlan/pending_list?planType=${planTypeDict.value}">接受待审核${planTypeDict.label}列表</a></li>
			</shiro:hasPermission>
		</c:if>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="planType" value="${planTypeDict.id}" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="200"
					class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作类别：</label>
			<div class="controls">
				<sys:treeselect id="worktype" name="workType.id"
					value="${workPlan.workType.id}" labelName="workType.name"
					labelValue="${workPlan.workType.name}" title="工作类别"
					url="/work/workType/treeData"
					allowClear="${office.currentUser.admin}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划开始时间：</label>
			<div class="controls">
				<input name="startTime" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划结束时间：</label>
			<div class="controls">
				<input name="planedFinishTime" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.planedFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
			</div>
		</div>
		<c:forEach items="${fns:getUser().roleList}" var="role">
			<c:if
				test="${role.name eq '科级以上干部' and planTypeDict.value != 'personal'}">
				<div class="control-group">
					<label class="control-label">要求结束时间：</label>
					<div class="controls">
						<input name="requiredFinishTime" type="text" readonly="readonly"
							maxlength="20" class="input-medium Wdate "
							value="<fmt:formatDate value="${workPlan.requiredFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
					</div>
				</div>
			</c:if>
		</c:forEach>
		<c:if test="${planTypeDict.value != 'personal'}">
			<c:forEach items="${fns:getUser().roleList}" var="role">
				<c:if test="${role.name eq '科级以上干部'}">
					<div class="control-group">
						<label class="control-label">工作要求：</label>
						<div class="controls">
							<form:textarea path="jobRequire" htmlEscape="false" rows="4"
								maxlength="255" class="input-xxlarge " />
						</div>
					</div>

				</c:if>
			</c:forEach>
		</c:if>
		<div class="control-group">
			<label class="control-label">父计划:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id"
					value="${workPlan.parent.id}" labelName="parent.name"
					labelValue="${workPlan.parent.name}" title="父工作计划"
					url="/work/workPlan/treeData" extId="${workPlan.id}" cssClass=""
					allowClear="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">任务频次：</label>
			<div class="controls">
				<form:checkboxes path="frequency"
					items="${fns:getDictList('frequency_months')}" itemLabel="label"
					itemValue="value" htmlEscape="false" class="" />
			</div>
		</div>

<div id="files" class="control-group">此处是下载附件链接的列表</div>
	</form:form>
	
	<form:form action="${ctx}/work/workPlan2/feedback_save" method="post" id="auditingForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="remainId" />
		<input type="hidden" name="planType" value="company" />
		<div class="control-group">
			<label class="control-label">反馈工作结果:</label>
			<div class="controls">
				<form:textarea path="feedbackDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div>
			<label class="control-label">工作是否结束:</label>
			<div class="controls">
				<form:checkbox path="isOver" htmlEscape="false" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			
			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="反馈"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>