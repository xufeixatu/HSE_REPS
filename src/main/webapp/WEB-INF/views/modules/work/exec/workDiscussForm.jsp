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
		<shiro:hasPermission name="work:workPlan:edit">
			<c:if test="${user.name eq office_quality.primaryPerson.name or user.name eq office_quality.deputyPerson}">
				<li><a
					href="${ctx}/work/workPlan/pending_list?planType=${planTypeDict.value}">待审核${planTypeDict.label}列表</a></li>
			</c:if>
			<li><a
					href="${ctx}/work/workPlan/remain_list?planType=${planTypeDict.value}">待受理${planTypeDict.label}列表</a></li>
			<li><a
					href="${ctx}/work/workPlan/remainned_list?planType=${planTypeDict.value}">已受理${planTypeDict.label}列表</a></li>
			<li class="active"><a
					href="${ctx}/work/workPlan2/remainned_feedback_list?planType=${planTypeDict.value}">评论${planTypeDict.label}受理反馈列表</a></li>
		</shiro:hasPermission>
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
			<label class="control-label">工作描述：</label>
			<div class="controls">
				<form:textarea path="workDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
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

<div id="files" class="control-group">此处是下载附件链接的列表</div>
		<div class="control-group">
			<label class="control-label">最新回馈信息:</label>
			<div class="controls">
				<form:textarea path="feedbackInfo" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
<div id="files" class="control-group">此处显示最新回馈的附件：</div>
	</form:form>
	
	<form:form action="${ctx}/work/workPlan/feedback_replay_save" method="post" id="auditingForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="feedbackId"/>
		<div class="control-group">
			<label class="control-label">回复反馈信息:</label>
			<div class="controls">
				<form:textarea path="feedbackReplyInfo" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="回复"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>