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
	function reject() {
		location = "${ctx}/work/workPlan/reject?id=${workPlan.id}&planType=${planTypeDict.value}";
	}

	//修改的方法
	function save() {
		var f = $("form")[0];
		f.submit();
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a
			href="${ctx}/work/workPlan/workList?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>

		<c:if
			test="${user.name eq office_quality.primaryPerson.name or user.name eq office_quality.deputyPerson}">
			<shiro:hasPermission name="work:workPlan:edit">
				<li class="active"><a
					href="${ctx}/work/workPlan/pending_list?planType=${planTypeDict.value}">接受待审核${planTypeDict.label}列表</a></li>
			</shiro:hasPermission>
		</c:if>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="workPlan"
				class="form-horizontal">
				<div class="control-group">
					<label class="control-label">标题：</label>
					<div class="controls">
						<form:input path="name" htmlEscape="false" maxlength="200"
							class="input-xlarge required" disabled="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">工作类别：</label>
					<div class="controls">
						<form:input id="worktype" path="workType.name" htmlEscape="false" maxlength="200"
							class="input-xlarge required" disabled="true"/>
					</div>
				</div>
				
				<hr />

				<span id="timeType">
					<c:choose>
					<c:when test="${not empty workPlan.startTime}">
					<div class="control-group">
						<label class="control-label">计划开始时间：</label>
						<div class="controls">
							<input id="startTime" name="startTime" alt="start_end"
								type="text" readonly="readonly" maxlength="20"
								class="input-medium Wdate "
								disabled="true"
								value="<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});clearTime(this)"
								onmouseover="showPrompt(this);" /> <span id="startTime_message"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">计划结束时间：</label>
						<div class="controls">
							<input id="planedFinishTime" name="planedFinishTime" type="text"
								readonly="readonly" alt="start_end" maxlength="20"
								class="input-medium Wdate "
								 disabled="true"
								value="<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});clearTime(this)"
								onmouseover="showPrompt(this);" /> <span
								id="planedFinishTime_message"></span>
						</div>
					</div>
					</c:when>
					<c:when test="${not empty workPlan.requiredFinishTime}">
					<div class="control-group">
						<label class="control-label">要求结束时间：</label>
						<div class="controls">
							<input id="requiredFinishTime" name="requiredFinishTime"
								type="text" readonly="readonly" alt="required" maxlength="20"
								class="input-medium Wdate "
								 disabled="true"
								value="<fmt:formatDate value="${workPlan.requiredFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});clearTime(this)"
								onmouseover="showPrompt(this);" /> <span
								id="requiredFinishTime_message"></span>
						</div>
					</div>
					</c:when>
					<c:when test="${not empty workPlan.frequency}">
					<div class="control-group">
						<label class="control-label">任务频次：</label>
						<div class="controls">
							<form:checkboxes path="frequency" alt="frequencyTime"  disabled="true"
								onclick="clearTime(this)"
								items="${fns:getDictList('frequency_months')}" itemLabel="label"
								itemValue="value" htmlEscape="false" class=""
								onmouseover="showPrompt(this);" />
							<div id="frequency_message"></div>
						</div>
					</div>
					</c:when>
					<c:otherwise>
					<div class="control-group">
						<label class="control-label">要求结束时间：</label>
						<div class="controls">
							<jsp:useBean id="now" class="java.util.Date" scope="page"/>
							<input id="requiredFinishTime" name="requiredFinishTime"
								type="text" readonly="readonly" alt="required" maxlength="20"
								class="input-medium Wdate "
								disabled="true"
								value="<fmt:formatDate value="${now}" pattern="yyyy"/>年12月31日"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});clearTime(this)"
								onmouseover="showPrompt(this);" /> <span
								id="requiredFinishTime_message"></span>
						</div>
					</div>
					</c:otherwise>
					</c:choose>
				</span>
				<hr />
				<div class="control-group">
					<label class="control-label">工作描述：</label>
					<div class="controls">
						<form:textarea path="workDesc" htmlEscape="false" rows="4"
							maxlength="255" class="input-xxlarge "  disabled="true"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">工作要求：</label>
					<div class="controls">
						<form:textarea path="jobRequire" htmlEscape="false" rows="4"
							maxlength="255" class="input-xxlarge "  disabled="true"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">负责人:</label>
					<div class="controls">
						<form:input id="personLiableId" path="personLiable.name" htmlEscape="false" maxlength="200"
							class="input-xlarge required" disabled="true"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">工作级别：</label>
					<div class="controls">
						<form:select path="workLevelId" class="input-medium"  disabled="true"> 
							<form:options items="${fns:getDictList('work_level')}"
								itemLabel="label" itemValue="value" htmlEscape="false" />
						</form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">备注：</label>
					<div class="controls">
						<form:textarea path="remarks" htmlEscape="false" rows="4"
							maxlength="255" class="input-xxlarge "  disabled="true"/>
					</div>
				</div>
			</form:form>
			
			<div id="files" class="control-group"></div>
			<form:form id="fileForm" modelAttribute="workPlan"
				enctype="multipart/form-data" action="${ctx}/work/workPlan/upload"
				method="post" class="form-horizontal">
				<form:hidden path="id" />
				<div class="control-group">
					<label class="control-label">工作附件：</label>
					<div class="controls">
						<input name="attachFile" type="file" width="100" />
						<shiro:hasPermission name="work:workPlan:edit">
							<input id="btnUpload" type="submit" value="上传" />&nbsp;</shiro:hasPermission>
					</div>
				</div>
			</form:form>

	<form:form action="${ctx}/work/workPlan2/dept_feedback_save" method="post"
		id="auditingForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="remainId" />
		<input type="hidden" name="planType" value="company" />
		<div class="control-group">
			<label class="control-label">反馈工作结果:</label>
			<div class="controls">
				<form:textarea path="feedbackDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required" />
			</div>
		</div>
		
		<div class="form-actions">

			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="反馈" />&nbsp; <input id="btnCancel" class="btn" type="button"
				value="返 回" onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>