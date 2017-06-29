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
		<%-- <shiro:hasPermission name="check:question:edit"><li><a href="${ctx}/check/question/form">检查问题上报</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="question" action="${ctx}/check/question/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>检查类别：</label>
				<sys:treeselect id="checkTypeClass" name="checkTypeClass.id" value="${question.checkTypeClass.id}" 
					labelName="checkTypeClass.name" labelValue="${question.checkTypeClass.name}"
					title="检查类别" url="/check/checkTypeClass/treeData" extId="${question.checkTypeClass.id}" cssClass="input-small" allowClear="true"/>
			</li>		
			<li><label>问题级别：</label>
				<form:select path="questionLevelId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('problem_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>受理状态：</label>
				<form:select path="stateId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('problem_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>检查类别</th>
				<th>受检单位</th>
				<th>检查部门</th>
				<th>检查人</th>
				<th>检查时间</th>
				<th>问题级别</th>
				<th>受理状态</th>
				<shiro:hasPermission name="check:question:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="question">
			<tr>
				<td>
					${question.checkTypeClass.name}
				</td>
				<td>
					${question.checkedOffice.name}
				</td>
				<td>
					${question.reportUserOfficeName}
				</td>
				<td>
					${question.reportUserName}
				</td>
				<td>
					<fmt:formatDate value="${question.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(question.questionLevelId, 'problem_level', '')}
				</td>				
				<td>
					${fns:getDictLabel(question.stateId, 'problem_status', '')}
				</td>																
				<shiro:hasPermission name="check:question:edit"><td>
    				<a href="${ctx}/check/question/form?id=${question.id}">详情</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>