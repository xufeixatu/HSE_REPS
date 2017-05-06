<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查类别管理</title>
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
		<li class="active"><a href="${ctx}/check/checkTypeClass/">检查类别列表</a></li>
		<shiro:hasPermission name="check:checkTypeClass:edit"><li><a href="${ctx}/check/checkTypeClass/form">检查类别添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="checkTypeClass" action="${ctx}/check/checkTypeClass/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>update_date</th>
				<th>remarks</th>
				<th>名称</th>
				<shiro:hasPermission name="check:checkTypeClass:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="checkTypeClass">
			<tr>
				<td><a href="${ctx}/check/checkTypeClass/form?id=${checkTypeClass.id}">
					<fmt:formatDate value="${checkTypeClass.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${checkTypeClass.remarks}
				</td>
				<td>
					${checkTypeClass.name}
				</td>
				<shiro:hasPermission name="check:checkTypeClass:edit"><td>
    				<a href="${ctx}/check/checkTypeClass/form?id=${checkTypeClass.id}">修改</a>
					<a href="${ctx}/check/checkTypeClass/delete?id=${checkTypeClass.id}" onclick="return confirmx('确认要删除该检查类别吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>