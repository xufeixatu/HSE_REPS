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
			<label class="control-label">工作类别：</label>
			<div class="controls">
				<sys:treeselect id="worktype" name="workType.id"
					value="${workPlan.workType.id}" labelName="workType.name"
					labelValue="${workPlan.workType.name}" title="工作类别"
					url="/work/workType/treeData"
					allowClear="${office.currentUser.admin}" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划开始时间：</label>
			<div class="controls">
				<input name="startTime" type="text" readonly="true"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划结束时间：</label>
			<div class="controls">
				<input name="planedFinishTime" type="text" readonly="true"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.planedFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">要求结束时间：</label>
			<div class="controls">
				<input name="requiredFinishTime" type="text" readonly="true"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.requiredFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
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
			<label class="control-label">工作级别：</label>
			<div class="controls">
				<form:select path="workLevelId" class="input-medium" disabled="true" >
					<form:options items="${fns:getDictList('work_level')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">父计划:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" disabled="true"
					value="${workPlan.parent.id}" labelName="parent.name"
					labelValue="${workPlan.parent.name}" title="父工作计划"
					url="/work/workPlan/treeData" extId="${workPlan.id}" cssClass=""
					allowClear="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">任务频次：</label>
			<div class="controls">
				<form:checkboxes path="frequency" disabled="true"
					items="${fns:getDictList('frequency_months')}" itemLabel="label"
					itemValue="value" htmlEscape="false" class="" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				<sys:treeselect checked="true" id="dept" name="depts"
					value="${workPlan.depts.id}" labelName="depts"
					labelValue="${workPlan.depts.name}" title="部门"
					url="/sys/office/treeData?type=2" cssClass="" allowClear="true"
					notAllowSelectParent="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人:</label>
			<div class="controls">
				<sys:treeselect id="personLiableId" name="personLiable.id"
					value="${workPlan.personLiable.id}" labelName="personLiable.name"
					labelValue="${workPlan.personLiable.name}" title="用户"
					url="/sys/office/treeData?type=3" allowClear="true"
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