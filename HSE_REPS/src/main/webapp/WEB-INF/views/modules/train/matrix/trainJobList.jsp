<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训岗位管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/train/matrix/trainJob/">培训岗位列表</a></li>
		<shiro:hasPermission name="train:matrix:trainJob:edit"><li><a href="${ctx}/train/matrix/trainJob/form">培训岗位添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainJob" action="${ctx}/train/matrix/trainJob/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>岗位：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>分类：</label>
				<form:select path="classify" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('train_job_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>岗位</th>
				<th>序号</th>
				<th>分类</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="train:matrix:trainJob:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="trainJob">
			<tr>
				<td><a href="${ctx}/train/matrix/trainJob/form?id=${trainJob.id}">
					${trainJob.name}
				</a></td>
				<td>
					${trainJob.sn}
				</td>
				<td>
					${fns:getDictLabel(trainJob.classify, 'train_job_classify', '')}
				</td>
				<td>
					<fmt:formatDate value="${trainJob.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${trainJob.remarks}
				</td>
				<shiro:hasPermission name="train:matrix:trainJob:edit"><td>
    				<a href="${ctx}/train/matrix/trainJob/form?id=${trainJob.id}">修改</a>
					<a href="${ctx}/train/matrix/trainJob/delete?id=${trainJob.id}" onclick="return confirmx('确认要删除该培训岗位吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>