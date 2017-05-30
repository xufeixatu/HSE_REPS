<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>ACT卡管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
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
		<li><a href="${ctx}/actcard/actcard/">ACT卡列表</a></li>
		<li class="active"><a href="${ctx}/actcard/actcard/form?id=${actcard.id}">ACT卡<shiro:hasPermission name="actcard:actcard:edit">${not empty actcard.id?'修改':'申请'}流程</shiro:hasPermission><shiro:lacksPermission name="actcard:actcard:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="actcard" action="${ctx}/actcard/actcard/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">属地单位：</label>
			<div class="controls">
				<sys:treeselect id="territorialOffice" name="territorialOffice.id" value="${actcard.territorialOffice.id}" labelName="territorialOffice.name" labelValue="${actcard.territorialOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不安全事件分类：</label>
			<div class="controls">
				<sys:treeselect id="actcardUnsafeEvent" name="actcardUnsafeEvent.id" value="${actcard.actcardUnsafeEvent.id}" labelName="actcardUnsafeEvent.name" labelValue="${actcard.actcardUnsafeEvent.name}" 
							title="不安全事件分类" url="/actcard/actcard/treeData" cssClass="required recipient" cssStyle="width:150px" 
							allowClear="true" notAllowSelectParent="true" smallBtn="false" checked="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不安全事件分类子类：</label>
			<div class="controls">
				<sys:treeselect id="actcardUnsafeEventChild" name="actcardUnsafeEventChild.id" value="${actcard.actcardUnsafeEventChild.id}" labelName="actcardUnsafeEventChild.name" labelValue="${actcard.actcardUnsafeEventChild.name}" 
							title="不安全事件分类子类" url="/actcard/actcard/treeData" cssClass="required recipient" cssStyle="width:150px" 
							allowClear="true" notAllowSelectParent="true" smallBtn="false" checked="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所观察到的不安全行为及有污染隐患的行为：</label>
			<div class="controls">
				<form:textarea path="unsafeActs" htmlEscape="false" rows="4" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">对不安全行为及隐患即刻的纠正行为和措施：</label>
			<div class="controls">
				<form:textarea path="measure" htmlEscape="false" rows="4" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所观察到的需要鼓励的安全、环保行为：</label>
			<div class="controls">
				<form:textarea path="safetyActs" htmlEscape="false" rows="4" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">持续改进的HSE工作的其它建议：</label>
			<div class="controls">
				<form:textarea path="suggestions" htmlEscape="false" rows="4" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上报时图片：</label>
			<div class="controls">
				<form:hidden id="reportPic" path="reportPic" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
				<sys:ckfinder input="reportPic" type="files" uploadPath="/actcard/actcard" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填报人：</label>
			<div class="controls">
				<form:input path="reporter" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填报人单位：</label>
			<div class="controls">
				<sys:treeselect id="reporterOffice" name="reporterOffice.id" value="${actcard.reporterOffice.id}" labelName="reporterOffice.name" labelValue="${actcard.reporterOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填报时间：</label>
			<div class="controls">
				<input name="reportingTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${actcard.reportingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">整改人：</label>
			<div class="controls">
				${actcard.solver.name}
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">整改图片：</label>
			<div class="controls">
				<form:hidden id="rectificationPic" path="rectificationPic" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
				<sys:ckfinder input="rectificationPic" type="files" uploadPath="/actcard/actcard" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">整改结果：</label>
			<div class="controls">
				${actcard.rectificationResult}
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				${actcard.state}
			</div>
		</div>
		
			
		<div class="control-group">
			<label class="control-label">关闭人：</label>
			<div class="controls">
				${actcard.closer.id}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关闭时间：</label>
			<div class="controls">
				<fmt:formatDate value="${actcard.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="actcard:actcard:edit">
			    <input id="btnSubmit" class="btn btn-primary" type="submit" value="暂存"/>&nbsp;
			    <input id="btnSubmit1" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty testAudit.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<c:if test="${not empty testAudit.id}">
			<act:histoicFlow procInsId="${actcard.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>