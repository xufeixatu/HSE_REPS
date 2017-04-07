<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
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
		<li><a href="${ctx}/work/workPlan/">工作计划列表</a></li>
		<li class="active"><a href="${ctx}/work/workPlan/form?id=${workPlan.id}&parent.id=${workPlanparent.id}">工作计划<shiro:hasPermission name="work:workPlan:edit">${not empty workPlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="work:workPlan:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="workPlan" action="${ctx}/work/workPlan/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作类别：</label>
			<div class="controls">
                <sys:treeselect id="work" name="workTypeId" value="${workType.id}" labelName="workType.name" labelValue="${workType.id}"
					title="工作类别" url="/work/workType/treeData" extId="" cssClass="" allowClear="${office.currentUser.admin}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划开始时间：</label>
			<div class="controls">
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划结束时间：</label>
			<div class="controls">
				<input name="planedFinishTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.planedFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">要求结束时间：</label>
			<div class="controls">
				<input name="requiredFinishTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${workPlan.requiredFinishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作描述：</label>
			<div class="controls">
				<form:textarea path="workDesc" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作要求：</label>
			<div class="controls">
				<form:textarea path="jobRequire" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				<sys:treeselect checked="true" id="deptId" name="deptId" value="${workPlan.deptId}" labelName="" labelValue="${workPlan.deptId}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人:</label>
			<div class="controls">
				 <sys:treeselect id="personLiableId" name="personLiableId" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name" labelValue="${office.primaryPerson.name}"
					title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">任务频次：</label>
			<div class="controls">
				<script type="text/javascript">
				<!--
				function updateFrequency(freq){
					var val = "";
					var t;
					if($("input[name='frequency_other']").length && $("input[name='frequency_other']").length > 0){
						t = $("input[name='frequency_other']");
					}else{
						t = $("input[name='frequency']");
						$("input[name='frequency_value']")[0].name='frequency';						
					}
					
					var a = new Array();
			
					var j = 0;
					for(var i = 0 ; i < t.length ; i++){
						t[i].name = "frequency_other";
						if(t[i].checked){
							a[j++] = t[i].value;
						}
					}
					
					for(var x = 0 ; x < a.length ; x++){
						val += a[x];
						if(x < a.length - 1){
							val += ",";
						}
					}
					
					$("input[name='frequency']")[0].value = val;
				}
				-->
				</script>
				<input type="text" style="display:none" name="frequency_value"/>
				<form:checkboxes path="frequency" onclick="updateFrequency(this);" items="${fns:getDictList('frequency_months')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作级别：</label>
			<div class="controls">
				<form:select path="workLevelId" class="input-medium">
					<form:options items="${fns:getDictList('work_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">父计划:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${workPlan.parent.id}" labelName="parent.name" labelValue="${workPlan.parent.name}"
					title="parent_id" url="/work/workPlan/treeData" extId="${workPlan.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
		<table width="100">
			<tr>
				<td>
					<label class="control-label">是否开放：</label>
					<div class="controls">
						<form:checkbox path="isOpen" htmlEscape="false" maxlength="1" class="input-xlarge "/>
					</div>
				</td>
				<td>
					<label class="control-label">是否允许被审核：</label>
					<div class="controls">
						<form:checkbox path="isApprovable" htmlEscape="false" maxlength="1" class="input-xlarge "/>
					</div>
				</td>
				<td>
					<label class="control-label">审核人是否可修改：</label>
					<div class="controls">
						<form:checkbox path="isApproveUpdate" htmlEscape="false" maxlength="1" class="input-xlarge "/>
					</div>
				</td>
				<td>
					<label class="control-label">是否保留审核人修改：</label>
					<div class="controls">
						<form:checkbox path="isRetainsApproveUpdate" htmlEscape="false" maxlength="1" class="input-xlarge "/>
					</div>
				</td>
			</tr>
		</table>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>

		<!-- 
		<div class="control-group">
			<label class="control-label">sort：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">name：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		-->
		<div class="form-actions">
			<shiro:hasPermission name="work:workPlan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<div id="files" class="control-group"></div>
	<form:form id="fileForm" modelAttribute="workPlan" enctype="multipart/form-data" action="${ctx}/work/workPlan/upload" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">工作附件：</label>
			<div class="controls">
				<input name="attachFile" type="file" width="100"/>
				<shiro:hasPermission name="work:workPlan:edit"><input id="btnUpload" type="submit" value="上传"/>&nbsp;</shiro:hasPermission>
			</div>
		</div>
	</form:form>
</body>
</html>