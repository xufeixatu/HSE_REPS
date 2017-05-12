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
		<li class="active"><a href="${ctx}/risk/risk/riskAccess/">风险列表</a></li>
	<%-- 	<shiro:hasPermission name="risk:risk:riskAccess:edit"><li><a href="${ctx}/risk/risk/riskAccess/form">risk添加</a></li></shiro:hasPermission> --%>
		<li ><a href="${ctx}/risk/risk/riskAccess/exportExcel">导出EXCEL</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="riskAccess" action="${ctx}/risk/risk/riskAccess/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>危害辨识项ID：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
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
			<li><label>风险类型：</label>
				<form:radiobuttons path="riskType" items="${fns:getDictList('risk_Type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>场所、设备：</label>
				<form:input path="placeDevice" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>是否重大风险：</label>
				<form:radiobuttons path="isHeaverisk" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>风险等级：</label>
				<form:select path="riskLevel" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
				<th>属地单位</th>
				<th>辨识人</th>
				<th>辨识时间</th>
				<th>风险类型</th>
				<th>类别</th>
				<th>场所、设备</th>
				<th>风险名称(环境因素名称/安全风险名称)</th>
				<th>作业活动名称/活动、物料、产品、服务</th>
				<th>危害因素（危险源）</th>
				<th>时态</th>
				<th>状态</th>
				<th>可能导致的后果</th>
				<th>是非判断</th>
				<th>评价结果ID</th>
				<th>是否重大风险</th>
				<th>风险等级</th>
				<th>责任单位</th>
				<th>对应管理方案</th>
				<th>影响（可能导致的事故、环境影响）</th>
				<th>措施（采取的消减、控制措施，现有控制方法）</th>
				<th>排放频率</th>
				<th>触发原因</th>
				<th>备注信息</th>
				<shiro:hasPermission name="risk:risk:riskAccess:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="riskAccess">
			<tr>
				<td><a href="${ctx}/risk/risk/riskAccess/form?id=${riskAccess.id}">
					<fmt:formatDate value="${riskAccess.years}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${fns:getDictLabel(riskAccess.unit, '', '')}
				</td>
				<td>
					${riskAccess.recognizeBy}
				</td>
				<td>
					<fmt:formatDate value="${riskAccess.recognizeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(riskAccess.riskType, 'risk_Type', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.category, 'risk_class', '')}
				</td>
				<td>
					${riskAccess.placeDevice}
				</td>
				<td>
					${riskAccess.riskName}
				</td>
				<td>
					${riskAccess.workName}
				</td>
				<td>
					${riskAccess.riskFactors}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.tense, 'tense_Type', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.status, 'status_Type', '')}
				</td>
				<td>
					${riskAccess.result}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.judgeTf, 'del_flag', '')}
				</td>
				<td>
					${riskAccess.accessid}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.isHeaverisk, 'del_flag', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.riskLevel, '', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.dutyUnit, '', '')}
				</td>
				<td>
					${riskAccess.managementPlan}
				</td>
				<td>
					${riskAccess.affect}
				</td>
				<td>
					${riskAccess.measure}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.frequency, 'emission_frequency', '')}
				</td>
				<td>
					${riskAccess.reason}
				</td>
				<td>
					${riskAccess.remarks}
				</td>
				<shiro:hasPermission name="risk:risk:riskAccess:edit"><td>
    				<a href="${ctx}/risk/risk/riskAccess/form?id=${riskAccess.id}">修改</a>
					<a href="${ctx}/risk/risk/riskAccess/delete?id=${riskAccess.id}" onclick="return confirmx('确认要删除该risk吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>