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
		<li class="active">环境因素清单列表</li>
	</ul>
	<form:form id="searchForm" modelAttribute="riskAccess" action="${ctx}/risk/riskAccess/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input  name="riskType" type="hidden" value="3"/>
		<ul class="ul-form">
			<li><label>编号：</label>
				<form:input path="number" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>年份：</label>
				<input id="years"  name="years"  type="text"  maxlength="20" class="input-medium Wdate" style="width:163px;"
				value=""${riskAccess.years}"
					onclick="WdatePicker({dateFmt:'yyyy'});"/>
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
				<th>场所、活动、设备、物料</th>
				<th>活动、产品、服务</th>
				<th>环境因素名称</th>
				<th>等级</th>
				<th>排放频率</th>
				<th>可能产生的环境影响</th>
				<th>现有控制方法</th>
				<th>类别</th>
				<shiro:hasPermission name="risk:riskAccess:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="riskAccess">
			<tr>
				<td><a href="${ctx}/risk/riskAccess/form?id=${riskAccess.id}">
					${riskAccess.years}
				</a></td>
				<td>
					${fns:getDictLabel(riskAccess.unit, '', '')}
				</td>
				<td>
					${riskAccess.placeDevice}
				</td>
				<td>
					${riskAccess.workName}
				</td>
				<td>
					${riskAccess.riskName}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.riskLevel, '', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.frequency, 'emission_frequency', '')}
				</td>
				<td>
					${riskAccess.affect}
				</td>
				<td>
					${riskAccess.measure}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.category, 'risk_class', '')}
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