<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查问题上报管理</title>
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
		<li class="active"><a href="${ctx}/check/question/">上报问题列表</a></li>
		<shiro:hasPermission name="check:question:edit"><li><a href="${ctx}/check/question/form">检查问题上报</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="question" action="${ctx}/check/question/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>检查类别</th>
				<th>受检单位</th>
				<th>检查部门</th>
				<th>检查人</th>
				<th>检查时间</th>
				<th>受理状态</th>
				<shiro:hasPermission name="check:question:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="question">
			<tr>
				<td>
					${question.questionClassId}
				</td>
				<td>
					${question.rectifierOffice.name}
				</td>
				<td>
					${question.remarks}
				</td>
				<td>
					${question.remarks}
				</td>
				<td>
					${question.remarks}
				</td>
				<td>
					${question.remarks}
				</td>																
				<shiro:hasPermission name="check:question:edit"><td>
    				<a href="${ctx}/check/question/form?id=${question.id}">详情</a>
					<a href="${ctx}/check/question/delete?id=${question.id}" onclick="return confirmx('确认要删除该检查问题上报吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>