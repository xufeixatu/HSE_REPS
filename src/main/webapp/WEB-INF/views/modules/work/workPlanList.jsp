<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作计划管理</title>
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
		<li class="active"><a href="${ctx}/work/workPlan/">工作计划列表</a></li>
		<shiro:hasPermission name="work:workPlan:edit"><li><a href="${ctx}/work/workPlan/form">工作计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="workPlan" action="${ctx}/work/workPlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>工作计划标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>ָ责任人ID：</label>
				<form:input path="personLiableId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>指派人ID：</label>
				<form:input path="assignerId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>name：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>工作计划标题</th>
				<th>remarks</th>
				<th>update_date</th>
				<th>name</th>
				<shiro:hasPermission name="work:workPlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="workPlan">
			<tr>
				<td><a href="${ctx}/work/workPlan/form?id=${workPlan.id}">
					${workPlan.title}
				</a></td>
				<td>
					${workPlan.remarks}
				</td>
				<td>
					<fmt:formatDate value="${workPlan.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${workPlan.name}
				</td>
				<shiro:hasPermission name="work:workPlan:edit"><td>
    				<a href="${ctx}/work/workPlan/form?id=${workPlan.id}">修改</a>
					<a href="${ctx}/work/workPlan/delete?id=${workPlan.id}" onclick="return confirmx('确认要删除该工作计划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>