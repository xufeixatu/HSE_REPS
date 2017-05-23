<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训记录管理</title>
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
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/train/record/trainRecord/">培训记录列表</a></li>
		<li class="active"><a href="${ctx}/train/record/trainRecord/form?id=${trainRecord.id}">培训记录<shiro:hasPermission name="train:record:trainRecord:edit">${not empty trainRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="train:record:trainRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="trainRecord" action="${ctx}/train/record/trainRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">培训主题：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">受训单位：</label>
			<div class="controls">
				<sys:treeselect id="objectOffice" name="objectOffice.id" value="${trainRecord.objectOffice.id}" labelName="objectOffice.name" labelValue="${trainRecord.objectOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训时间：</label>
			<div class="controls">
				<input name="trainTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${trainRecord.trainTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">责任单位：</label>
			<div class="controls">
				<sys:treeselect id="subjectOffice" name="subjectOffice.id" value="${trainRecord.subjectOffice.id}" labelName="subjectOffice.name" labelValue="${trainRecord.subjectOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训人数：</label>
			<div class="controls">
				<form:input path="planNumber" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训时长：</label>
			<div class="controls">
				<form:input path="trainDuration" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系人：</label>
			<div class="controls">
				<sys:treeselect id="contact" name="contact.id" value="${trainRecord.contact.id}" labelName="contact.name" labelValue="${trainRecord.contact.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归档状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('train_record_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息(取消原因)：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否考试：</label>
			<div class="controls">
				<form:radiobuttons path="isExam" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试时间：</label>
			<div class="controls">
				<input name="examTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${trainRecord.examTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试时长：</label>
			<div class="controls">
				<form:input path="examDuration" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合格线：</label>
			<div class="controls">
				<form:input path="pass" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否计划：</label>
			<div class="controls">
				<form:radiobuttons path="isPlan" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训计划：</label>
			<div class="controls">
				<form:select path="plan.id" class="input-xlarge">
					<form:option value="" label=""/>
					<form:options items="${trainPlanList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">选择是计划时必填*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">此培训记录的过程照片资料等：</label>
			<div class="controls">
				<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="files" type="files" uploadPath="/train/record/trainRecord" selectMultiple="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">此培训记录的课件：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>课件</th>
								<th>备注信息</th>
								<shiro:hasPermission name="train:record:trainRecord:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="trainRecordCoursewareList">
						</tbody>
						<c:if test="${trainRecord.status!='1'}" >
						<shiro:hasPermission name="train:record:trainRecord:edit"><tfoot>
							<tr><td colspan="4"><a href="javascript:" onclick="addRow('#trainRecordCoursewareList', trainRecordCoursewareRowIdx, trainRecordCoursewareTpl);trainRecordCoursewareRowIdx = trainRecordCoursewareRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
						</c:if>
					</table>
					<script type="text/template" id="trainRecordCoursewareTpl">//<!--
						<tr id="trainRecordCoursewareList{{idx}}">
							<td class="hide">
								<input id="trainRecordCoursewareList{{idx}}_id" name="trainRecordCoursewareList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="trainRecordCoursewareList{{idx}}_delFlag" name="trainRecordCoursewareList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<select id="trainRecordCoursewareList{{idx}}_courseware" name="trainRecordCoursewareList[{{idx}}].courseware.id" data-value="{{row.courseware.id}}" class="input-small ">
									<option value=""></option>
									<c:forEach items="${fns:getDictList('')}" var="dict">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<textarea id="trainRecordCoursewareList{{idx}}_remarks" name="trainRecordCoursewareList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="train:record:trainRecord:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#trainRecordCoursewareList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var trainRecordCoursewareRowIdx = 0, trainRecordCoursewareTpl = $("#trainRecordCoursewareTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(trainRecord.trainRecordCoursewareList)};
							for (var i=0; i<data.length; i++){
								addRow('#trainRecordCoursewareList', trainRecordCoursewareRowIdx, trainRecordCoursewareTpl, data[i]);
								trainRecordCoursewareRowIdx = trainRecordCoursewareRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">受培人员成绩：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>受培人员</th>
								<th>培训成绩</th>
								<th>备注信息</th>
								<shiro:hasPermission name="train:record:trainRecord:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="trainRecordScoreList">
						</tbody>
						<c:if test="${trainRecord.status!='1'}" >
						<shiro:hasPermission name="train:record:trainRecord:edit"><tfoot>
							<tr><td colspan="5"><a href="javascript:" onclick="addRow('#trainRecordScoreList', trainRecordScoreRowIdx, trainRecordScoreTpl);trainRecordScoreRowIdx = trainRecordScoreRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
						</c:if>
					</table>
					<script type="text/template" id="trainRecordScoreTpl">//<!--
						<tr id="trainRecordScoreList{{idx}}">
							<td class="hide">
								<input id="trainRecordScoreList{{idx}}_id" name="trainRecordScoreList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="trainRecordScoreList{{idx}}_delFlag" name="trainRecordScoreList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<sys:treeselect id="trainRecordScoreList{{idx}}_user" name="trainRecordScoreList[{{idx}}].user.id" value="{{row.user.id}}" labelName="trainRecordScoreList{{idx}}.user.name" labelValue="{{row.user.name}}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
							</td>
							<td>
								<input id="trainRecordScoreList{{idx}}_score" name="trainRecordScoreList[{{idx}}].score" type="text" value="{{row.score}}" maxlength="32" class="input-small required"/>
							</td>
							<td>
								<textarea id="trainRecordScoreList{{idx}}_remarks" name="trainRecordScoreList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="train:record:trainRecord:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#trainRecordScoreList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var trainRecordScoreRowIdx = 0, trainRecordScoreTpl = $("#trainRecordScoreTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(trainRecord.trainRecordScoreList)};
							for (var i=0; i<data.length; i++){
								addRow('#trainRecordScoreList', trainRecordScoreRowIdx, trainRecordScoreTpl, data[i]);
								trainRecordScoreRowIdx = trainRecordScoreRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="train:record:trainRecord:edit">
			<c:if test="${trainRecord.status!='1'}" ><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/></c:if>
			&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>