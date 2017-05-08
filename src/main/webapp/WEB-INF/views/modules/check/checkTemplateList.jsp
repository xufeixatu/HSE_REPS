<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查模板管理管理</title>
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
		<li class="active"><a href="${ctx}/check/checkTemplate/">检查模板管理列表</a></li>
		<shiro:hasPermission name="check:checkTemplate:edit"><li><a href="${ctx}/check/checkTemplate/form">检查模板管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="checkTemplate" action="${ctx}/check/checkTemplate/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模板名称：</label>
				<form:input path="templateName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>是否启用：</label>
				<form:radiobuttons path="usedStatus" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模板名称</th>
				<th>描述</th>
				<th>是否启用</th>
				<th>更新时间</th>
				<shiro:hasPermission name="check:checkTemplate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="checkTemplate">
			<tr>
				<td><a href="${ctx}/check/checkTemplate/form?id=${checkTemplate.id}">
					${checkTemplate.templateName}
				</a></td>
				<td>
					${checkTemplate.templateDesc}
				</td>
				<td>
					${fns:getDictLabel(checkTemplate.usedStatus, '', '')}
				</td>
				<td>
					<fmt:formatDate value="${checkTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="check:checkTemplate:edit"><td>
    				<a href="${ctx}/check/checkTemplate/form?id=${checkTemplate.id}">修改</a>
					<a href="${ctx}/check/checkTemplate/delete?id=${checkTemplate.id}" onclick="return confirmx('确认要删除该检查模板管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>