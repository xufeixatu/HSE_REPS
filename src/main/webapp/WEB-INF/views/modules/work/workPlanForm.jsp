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

	//清除未选择时间类别的时间
	//    工作计划的时间有三种状态：有起止时间的，只有结束时间和只有执行频次的，这个方法就是我们选择一种时间类型如“频次”，
	//用来消除其它时间类型中选择的时间  
	function clearTime(me) {
		var timeType = $("#timeType");
		var ipts = timeType.find("input");
		for (var i = 0; i < ipts.length; i++) {
			ipts[i].type;
			if (ipts[i].alt != me.alt) {
				if (ipts[i].type == 'text')
					ipts[i].value = "";
				if (ipts[i].type == "checkbox")
					ipts[i].checked = false;
			}
		}
	}
	function showPrompt(me) {
		var message = "<font color='red'>计划起止时间、要求结束时间、频次选择一种时间类别............</font>";
		$("#" + me.name + "_message").html(message).hide(15000);
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
	<c:choose>
		<c:when test="${workPlan.noedit }">
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
						<form:input id="worktype" path="workType.id" htmlEscape="false" maxlength="200"
							class="input-xlarge required" disabled="true"/>
					</div>
				</div>
				
				<hr />

				<span id="timeType">
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
						<sys:treeselect id="personLiableId" name="personLiable.id"
							value="${workPlan.personLiable.id}" labelName="personLiable.name"
							labelValue="${workPlan.personLiable.name}" title="用户"
							url="/sys/office/treeData?type=3" allowClear="true"
							notAllowSelectParent="true"  disabled="true"/>
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
				<c:if test="${not empty workPlan.id && not workPlan.noedit}">
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
				<div class="control-group">
					<label class="control-label">父计划:</label>
					<div class="controls">
						<sys:treeselect id="parent" name="parent.id"
							value="${workPlan.parent.id}" labelName="parent.name"
							labelValue="${workPlan.parent.name}" title="父工作计划"
							url="/work/workPlan/treeData" extId="${workPlan.id}"
							allowClear="true" />
					</div>
				</div>

				<c:if test="${planTypeDict.value eq 'company'}">
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
										<form:checkbox path="isRetainsApproveUpdate"
											htmlEscape="false" maxlength="1" class="input-xlarge " />
									</div></td>
							</tr>
						</table>
					</div>


				</c:if>
				<div class="form-actions">
					<c:if test="${not workPlan.noedit}">
						<shiro:hasPermission name="work:workPlan:edit">

							<input id="btnSubmit" class="btn btn-primary" type="submit"
								value="保 存" />&nbsp;</shiro:hasPermission>
					</c:if>
					<input id="btnCancel" class="btn" type="button" value="返 回"
						onclick="history.go(-1)" />
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
		</c:when>
		<c:otherwise>
			<form:form id="inputForm" modelAttribute="workPlan"
				action="${ctx}/work/workPlan/save" method="post"
				class="form-horizontal">
				<form:hidden path="id" />
				<input type="hidden" name="planType" value="${planTypeDict.id}" />
				<sys:message content="${message}" />
				<div class="control-group">
					<label class="control-label">标题：</label>
					<div class="controls">
						<form:input path="name" htmlEscape="false" maxlength="200"
							class="input-xlarge required" />
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
							allowClear="${office.currentUser.admin}" />
					</div>
				</div>
				<script type="text/javascript">
					
				</script>
				<hr />

				<span id="timeType">
					<div class="control-group">
						<label class="control-label">计划开始时间：</label>
						<div class="controls">
							<input id="startTime" name="startTime" alt="start_end"
								type="text" readonly="readonly" maxlength="20"
								class="input-medium Wdate "
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
								value="<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});clearTime(this)"
								onmouseover="showPrompt(this);" /> <span
								id="planedFinishTime_message"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">要求结束时间：</label>
						<div class="controls">
							<input id="requiredFinishTime" name="requiredFinishTime"
								type="text" readonly="readonly" alt="required" maxlength="20"
								class="input-medium Wdate "
								value="<fmt:formatDate value="${workPlan.requiredFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});clearTime(this)"
								onmouseover="showPrompt(this);" /> <span
								id="requiredFinishTime_message"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">任务频次：</label>
						<div class="controls">
							<form:checkboxes path="frequency" alt="frequencyTime"
								onclick="clearTime(this)"
								items="${fns:getDictList('frequency_months')}" itemLabel="label"
								itemValue="value" htmlEscape="false" class=""
								onmouseover="showPrompt(this);" />
							<div id="frequency_message"></div>
						</div>
					</div>
				</span>
				<hr />
				<div class="control-group">
					<label class="control-label">工作描述：</label>
					<div class="controls">
						<form:textarea path="workDesc" htmlEscape="false" rows="4"
							maxlength="255" class="input-xxlarge " />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">工作要求：</label>
					<div class="controls">
						<form:textarea path="jobRequire" htmlEscape="false" rows="4"
							maxlength="255" class="input-xxlarge " />
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
				<div class="control-group">
					<label class="control-label">父计划:</label>
					<div class="controls">
						<sys:treeselect id="parent" name="parent.id"
							value="${workPlan.parent.id}" labelName="parent.name"
							labelValue="${workPlan.parent.name}" title="父工作计划"
							url="/work/workPlan/treeData" extId="${workPlan.id}"
							allowClear="true" />
					</div>
				</div>

				<c:if test="${planTypeDict.value eq 'company'}">
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
										<form:checkbox path="isRetainsApproveUpdate"
											htmlEscape="false" maxlength="1" class="input-xlarge " />
									</div></td>
							</tr>
						</table>
					</div>


				</c:if>
				<div class="form-actions">
					<c:if test="${not workPlan.noedit}">
						<shiro:hasPermission name="work:workPlan:edit">

							<input id="btnSubmit" class="btn btn-primary" type="submit"
								value="保 存" />&nbsp;</shiro:hasPermission>
					</c:if>
					<input id="btnCancel" class="btn" type="button" value="返 回"
						onclick="history.go(-1)" />
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
		</c:otherwise>
	</c:choose>
</body>
</html>