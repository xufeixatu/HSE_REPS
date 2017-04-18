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
		<li><a href="${ctx}/work/workPlan?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>
		<li class="active"><a
			href="${ctx}/work/workPlan/form?id=${workPlan.id}&parent.id=${workPlanparent.id}&planType=${planTypeDict.value}">${planTypeDict.label}<shiro:hasPermission
					name="work:workPlan:edit">${not empty workPlan.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="work:workPlan:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="workPlan"
		action="${ctx}/work/workPlan/pending_save" method="post" class="form-horizontal">
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
		<div class="control-group">
			<label class="control-label">工作描述：</label>
			<div class="controls">
				<form:textarea path="workDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
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
			<%-- <!--
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
			--> --%>
			<div class="control-group">
				<label class="control-label">工作级别：</label>
				<div class="controls">
					<form:select path="workLevelId" class="input-medium">
						<form:options items="${fns:getDictList('work_level')}"
							itemLabel="label" itemValue="value" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			
			<div class="control-group">
				<table width="100">
					<tr>
						<td><label class="control-label">是否开放：</label>
							<div class="controls">
								<form:checkbox path="isOpen" htmlEscape="false" maxlength="1"
									class="input-xlarge " />
							</div></td>
						<td><label class="control-label">是否允许被审核：</label>
							<div class="controls">
								<form:checkbox path="isApprovable" htmlEscape="false"
									maxlength="1" class="input-xlarge " />
							</div></td>
						<td><label class="control-label">审核人是否可修改：</label>
							<div class="controls">
								<form:checkbox path="isApproveUpdate" htmlEscape="false"
									maxlength="1" class="input-xlarge " />
							</div></td>
						<td><label class="control-label">是否保留审核人修改：</label>
							<div class="controls">
								<form:checkbox path="isRetainsApproveUpdate" htmlEscape="false"
									maxlength="1" class="input-xlarge " />
							</div></td>
					</tr>
				</table>
			</div>
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


		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
		<c:if test="${not empty workPlan.id}">
			<div class="control-group">
				<label class="control-label">是否取消:</label>
				<div class="controls">
					<form:checkbox path="isCancel" htmlEscape="false" maxlength="1"
						class="input-xlarge " />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">取消原因:</label>
				<div class="controls">
					<form:textarea path="cancelReason" htmlEscape="false" rows="4"
						maxlength="255" class="input-xxlarge " />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">是否删除:</label>
				<div class="controls">
					<form:checkbox path="delFlag" htmlEscape="false" maxlength="1"
						value="1" class="input-xlarge " />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">删除原因:</label>
				<div class="controls">
					<form:textarea path="removeReason" htmlEscape="false" rows="4"
						maxlength="255" class="input-xxlarge " />
				</div>
			</div>
		</c:if>
<div id="files" class="control-group">此处是下载附件链接的列表</div>
		
	</form:form>
	
	
	<!-- workPlanController中的auditing审核方法和reject否决方法还未写 -->
	
	<form:form action="${ctx}/work/workPlan/agree" method="post" id="auditingForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="planType" value="${planTypeDict.id}" />
		<div class="control-group">
			<label class="control-label">审核意见:</label>
			<div class="controls">
				<form:textarea path="approveOpinion" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="work:workPlan:edit">
				<input id="btnSubmit1" class="btn btn-primary" type="submit"
					value="同意"/>&nbsp;
				<input id="btnSubmit2" class="btn btn-primary" type="button"
					value="否决" onclick="reject();"/>&nbsp;
				<c:if test="${workPlan.isApproveUpdate}">
					<input id="btnSubmit" class="btn btn-primary" type="button"
						value="修改" onclick="save();"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
		
	</form:form>
	
	
</body>
</html>