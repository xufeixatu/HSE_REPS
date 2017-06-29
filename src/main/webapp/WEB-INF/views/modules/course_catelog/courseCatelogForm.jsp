<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课件目录管理</title>
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
		<li class="active"><a href="${ctx}/course_catelog/courseCatelog/">课件目录列表</a></li>
		<shiro:hasPermission name="course_catelog:courseCatelog:edit"><li><a href="${ctx}/course_catelog/courseCatelog/form">课件目录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="courseCatelog" action="${ctx}/course_catelog/courseCatelog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>附件名称：</label>
				<form:input path="attachName" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>附件名称</th>
				<th>附件id</th>
				<shiro:hasPermission name="course_catelog:courseCatelog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="courseCatelog">
			<tr>
				<td><a href="${ctx}/course_catelog/courseCatelog/form?id=${courseCatelog.id}">
					${courseCatelog.attachName}
				</a></td>
				<td>
					${courseCatelog.attachId}
				</td>
				<shiro:hasPermission name="course_catelog:courseCatelog:edit"><td>
    				<a href="${ctx}/course_catelog/courseCatelog/form?id=${courseCatelog.id}">修改</a>
					<a href="${ctx}/course_catelog/courseCatelog/delete?id=${courseCatelog.id}" onclick="return confirmx('确认要删除该课件目录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/course_catelog/courseCatelog/">课件目录列表</a></li>
		<li class="active"><a href="${ctx}/course_catelog/courseCatelog/form?id=${courseCatelog.id}">课件目录<shiro:hasPermission name="course_catelog:courseCatelog:edit">${not empty courseCatelog.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="course_catelog:courseCatelog:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="courseCatelog" action="${ctx}/course_catelog/courseCatelog/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">课程id：</label>
			<div class="controls">
				<form:input path="courseId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件名称：</label>
			<div class="controls">
				<form:input path="attachName" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件id：</label>
			<div class="controls">
				<form:hidden id="attachId" path="attachId" htmlEscape="false" maxlength="64" class="input-xlarge"/>
				<sys:ckfinder input="attachId" type="files" uploadPath="/course_catelog/courseCatelog" selectMultiple="true"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="course_catelog:courseCatelog:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>