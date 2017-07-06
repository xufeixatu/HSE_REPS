<%@ page contentType="text/html;charset=UTF-8"%>
	<form:form id="inputForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="planType" value="${planTypeDict.id}" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				${workPlan.name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作类别：</label>
			<div class="controls">
				${workPlan.workType.name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划开始时间：</label>
			<div class="controls">
				<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划结束时间：</label>
			<div class="controls">
				<fmt:formatDate value="${workPlan.planedFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
		</div>
		<c:forEach items="${fns:getUser().roleList}" var="role">
			<c:if
				test="${role.name eq '科级以上干部' and planTypeDict.value != 'personal'}">
				<div class="control-group">
					<label class="control-label">要求结束时间：</label>
					<div class="controls">
						<fmt:formatDate value="${workPlan.requiredFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
			</c:if>
		</c:forEach>
		<div class="control-group">
			<label class="control-label">任务频次：</label>
			<div class="controls">
				${workPlan.frequency}月
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作描述：</label>
			<div class="controls">
				${workPlan.workDesc}
			</div>
		</div>
		<c:if test="${planTypeDict.value != 'personal'}">
			<c:forEach items="${fns:getUser().roleList}" var="role">
				<c:if test="${role.name eq '科级以上干部'}">
					<div class="control-group">
						<label class="control-label">工作要求：</label>
						<div class="controls">
							${workPlan.jobRequire}
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
					${fns:getDictByID(workPlan.workLevelId).label}
				</div>
			</div>
			
			<%-- <div class="control-group">
				<table width="100">
					<tr>
						<td><label class="control-label">是否开放：</label>
							<div class="controls">
								${workPlan.isOpen}
							</div></td>
						<td><label class="control-label">是否允许被审核：</label>
							<div class="controls">
								${workPlan.isApprovable}
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
			</div> --%>
		</c:if>
		<div class="control-group">
			<label class="control-label">父计划:</label>
			<div class="controls">
				${workPlan.parent.name}
			</div>
		</div>
	</form:form>
