<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>risk管理</title>
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
		<li class="active">安全风险清单</li>
	</ul>
	<form:form id="searchForm" modelAttribute="riskAccess" action="${ctx}/risk/riskAccess/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>编号：</label>
				<form:input path="number" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>年份：</label>
				<form:input path="years" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>属地单位：</label>
				<form:select path="unit" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
	
			<li><label>场所、设备：</label>
				<form:input path="placeDevice" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>责任单位：</label>
				<form:select path="dutyUnit" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>年份</th>
				<th>场所、设备</th>
				<th>安全风险名称</th>
				<th>风险等级</th>
				<th>可能导致的事故</th>
				<th>触发原因</th>
				<th>措施</th>
				<th>责任单位</th>
				<th>对应管理方案</th>
				<th>备注信息</th>
				<shiro:hasPermission name="risk:riskAccess:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="riskAccess">
			<tr>
				<td><a href="${ctx}/risk/riskAccess/form?id=${riskAccess.id}">
					<fmt:formatDate value="${riskAccess.years}" pattern="yyyy"/>
				</a></td>
				<td>
					${riskAccess.placeDevice}
				</td>
				<td>
					${riskAccess.riskName}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.riskLevel, 'risk_level', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.result, 'risk_result', '')}
				</td>
				<td>
					${riskAccess.reason}
				</td>
				<td>
					${riskAccess.measure}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.dutyUnit, '', '')}
				</td>
				<td>
					${riskAccess.managementPlan}
				</td>
				<td>
					${riskAccess.remarks}
				</td>
				<shiro:hasPermission name="risk:riskAccess:edit"><td>
    				<a href="${ctx}/risk/riskAccess/form?id=${riskAccess.id}">修改</a>
					<a href="${ctx}/risk/riskAccess/delete?id=${riskAccess.id}" onclick="return confirmx('确认要删除该risk吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>