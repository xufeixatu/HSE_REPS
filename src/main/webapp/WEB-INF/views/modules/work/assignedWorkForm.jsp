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
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/work/workPlan?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>
		<li class="active"><a
			href="${ctx}/work/workPlan/form?id=${workPlan.id}&parent.id=${workPlanparent.id}&planType=${planTypeDict.value}">分派${planTypeDict.label}<shiro:hasPermission
					name="work:workPlan:edit">${not empty workPlan.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="work:workPlan:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="workPlan"
		action="${ctx}/work/workPlan/assigned" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="planType" value="${planTypeDict.id}" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="200"
					class="input-xlarge required" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作描述：</label>
			<div class="controls">
				<form:textarea path="workDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分派任务部门：</label>
			<div class="controls">
				<sys:treeselect checked="true" id="dept" name="depts"
					value="${workPlan.depts.id}" labelName="depts"
					labelValue="${workPlan.depts.name}" title="部门"
					url="/sys/office/treeData?type=2" cssClass="required" allowClear="true"
					notAllowSelectParent="true" />
			</div>
		</div>
<div id="files" class="control-group">此处显示下载工作附件的链接[待施工...]</div>

		<div class="form-actions">
			<c:if test="${not workPlan.noedit}">
			<shiro:hasPermission name="work:workPlan:edit">
			
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="分配" />&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>

	</form:form>
	
</body>
</html>