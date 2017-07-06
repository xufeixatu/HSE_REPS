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
					href="${ctx}/work/workPlan/pending_list?planType=${planTypeDict.value}">回复${planTypeDict.label}反馈</a></li>
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
					class="input-xlarge required" disabled="true" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作描述：</label>
			<div class="controls">
				<form:textarea path="workDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">反馈:</label>
			<div class="controls">
				<form:textarea path="feedbackDesc" htmlEscape="false" rows="4"
					disabled="true" maxlength="255" class="input-xxlarge "
					cssClass="required" />
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

	<form:form
		action="${ctx}/work/workPlan2/dept_replay_remain_feedback_save"
		method="post" id="auditingForm" modelAttribute="workPlan"
		class="form-horizontal">
		<form:hidden path="feedbackId" />
		<input type="hidden" name="planType" value="department" />
		<div class="control-group">
			<label class="control-label">回复反馈:</label>
			<div class="controls">
				<form:textarea path="replyContent" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required" />
			</div>
		</div>

		<div class="form-actions">

			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="回复" />&nbsp; <input id="btnCancel" class="btn" type="button"
				value="返 回" onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>