<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训课件上传与查看管理</title>
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
		<li><a href="${ctx}/train_course/trainCourse/">培训课件查看列表</a></li>
		<li class="active"><a href="${ctx}/train_course/trainCourse/form?id=${trainCourse.id}">上传培训课件<shiro:hasPermission name="train_course:trainCourse:edit">${not empty trainCourse.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="train_course:trainCourse:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="trainCourse" action="${ctx}/train_course/trainCourse/save" method="post" class="form-horizontal" type="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">封面上传：</label>
			<div class="controls">
				<form:hidden id="coverId" path="coverId" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="coverId" type="images" uploadPath="/train_course/trainCourse" selectMultiple="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件类别:</label>
			<div class="controls">
				<sys:treeselect id="type" name="type.id" value="${trainCourse.id}" labelName="trainCourse.type" labelValue="${trainCourse.courseTypeId}"
					title="课件类别" url="/course_catalog/courseCatalog/treeData" extId="${trainCourse.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件名称：</label>
			<div class="controls">
				<form:input path="courseName" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件描述：</label>
			<div class="controls">
				<form:textarea path="courseDec" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课件时长：</label>
			<div class="controls">
				<form:input path="courseTime" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<div class="control-group">
				<label class="control-label">课件附件上传：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>附件名称</th>
								<th>附件上传</th>
								<shiro:hasPermission name="train_course:trainCourse:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="courseCatelogList">
						</tbody>
						<shiro:hasPermission name="train_course:trainCourse:edit"><tfoot>
							<tr><td colspan="4"><a href="javascript:" onclick="addRow('#courseCatelogList', courseCatelogRowIdx, courseCatelogTpl);courseCatelogRowIdx = courseCatelogRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="courseCatelogTpl">//<!--
						<tr id="courseCatelogList{{idx}}">
							<td class="hide">
								<input id="courseCatelogList{{idx}}_id" name="courseCatelogList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="courseCatelogList{{idx}}_delFlag" name="courseCatelogList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="courseCatelogList{{idx}}_attachName" name="courseCatelogList[{{idx}}].attachName" type="text" value="{{row.attach_name}}" maxlength="100" class="input-small "/>
							</td>
							<td>					
								<input name="courseCatelogList[{{idx}}].attachId" id="courseCatelogList{{idx}}_attachId" maxlength="255" class="input-xlarge" type="hidden"/>
								<sys:ckfinder input="courseCatelogList{{idx}}_attachId	" type="files" uploadPath="/train_course/trainCourse" selectMultiple="false"/>
							</td>
							
							<shiro:hasPermission name="train_course:trainCourse:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#courseCatelogList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var courseCatelogRowIdx = 0, courseCatelogTpl = $("#courseCatelogTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(trainCourse.courseCatelogList)};
							for (var i=0; i<data.length; i++){
								addRow('#courseCatelogList', courseCatelogRowIdx, courseCatelogTpl, data[i]);
								courseCatelogRowIdx = courseCatelogRowIdx + 1;
							}
						});
					</script>
				</div>
<%-- 				<label class="control-label">课件附件上传：</label>
				<div class="controls">
			<form:hidden id="docId" path="courseCatelogList[{{idx}}].attachId" htmlEscape="false" maxlength="500" class="input-xlarge"/>
								<input name="courseCatelogList[{{idx}}].attachId" id="courseCatelogList{{idx}}_attachId maxlength="255" class="input-xlarge" type="hidden"/>
								<sys:ckfinder input="courseCatelogList{{idx}}_attachId" type="files" uploadPath="/train_course/trainCourse" selectMultiple="false"/>
				

				</div> --%>
			</div> 
		</div>
		<div class="control-group">
			<label class="control-label">上传人：</label>
			<div class="controls">
				<form:input path="uploadBy" htmlEscape="false" maxlength="64" class="input-xlarge required" disabled = "true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上传时间：</label>
			<div class="controls">
				<input name="uploadTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${trainCourse.uploadTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="train_course:trainCourse:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>