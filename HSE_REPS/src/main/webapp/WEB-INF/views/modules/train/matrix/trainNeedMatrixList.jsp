<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训需求管理</title>
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
		<li><a href="${ctx}/train/matrix/trainNeedMatrix/matrix">培训需求矩阵</a></li>
		<li class="active"><a href="${ctx}/train/matrix/trainNeedMatrix/">培训需求列表</a></li>
		<shiro:hasPermission name="train:matrix:trainNeedMatrix:edit"><li><a href="${ctx}/train/matrix/trainNeedMatrix/form">培训需求添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainNeedMatrix" action="${ctx}/train/matrix/trainNeedMatrix/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>版本号：</label>
				<form:select path="version" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('train_matrix_version')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>岗位：</label>
				<form:select path="trainJob.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${trainJobList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>知识内容：</label>
				<form:select path="trainContent.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${trainContentList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
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
				<td>版本号</td>
				<td>培训岗位名称</td>
				<td>培训知识内容名称</td>
				<td>更新时间</td>
				<td>备注</td>
				<shiro:hasPermission name="train:matrix:trainNeedMatrix:edit"><td>操作</td></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="trainNeedMatrix">
			<tr>
				<td>${fns:getDictLabel(trainNeedMatrix.version, 'train_matrix_version', '')}</td>
				<td>${trainNeedMatrix.trainJob.name}</td>
				<td>${trainNeedMatrix.trainContent.name}</td>
				<td><fmt:formatDate value="${trainNeedMatrix.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${trainNeedMatrix.remarks}</td>
				<shiro:hasPermission name="train:matrix:trainNeedMatrix:edit">
				<td>
			   		<a href="${ctx}/train/matrix/trainNeedMatrix/form?id=${trainNeedMatrix.id}">修改</a>
					<a href="${ctx}/train/matrix/trainNeedMatrix/delete?id=${trainNeedMatrix.id}" onclick="return confirmx('确认要删除该培训需求吗？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>