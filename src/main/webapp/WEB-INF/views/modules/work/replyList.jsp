<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 获取当前user对象 -->
<c:set value="${fns:getUser()}" var="user"/>
<c:set value="${fns:getOfficeById('4eb71afc7bd34163a381eb3e37d05fdc')}" var="office_quality"/>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
</head>
<body>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="work:workPlan:edit">
			<li><a
					href="${ctx}/work/workPlan2/dept_remainned_list?planType=${planTypeDict.value}">已受理${planTypeDict.label}列表</a></li>
			<li><a
					href="${ctx}/work/workPlan2/dept_remain_feedback_list?id=${list[0].id}&remainId=${list[0].remainId}&planType=${planTypeDict.value}">${planTypeDict.label}反馈信息列表</a></li>
			<li class="active"><a>回信息列表</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="workPlan"
		action="${ctx}/work/workPlan/" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>标题：</label> <form:input path="name"
					htmlEscape="false" maxlength="100" class="input-medium" /></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="treeTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>回复信息</th>
				<th>工作项</th>
				<th>责任单位</th>
				<th>责任人</th>
				<th>反馈时间</th>
				<th>回复时间</th>
			</tr>
		</thead>
		<tbody id="treeTableList">
		<c:forEach items="${list}" var="workPlan" varStatus="status">
			<tr>
				<td>
				<textarea readonly="readonly" rows="3" cols="20">${workPlan.replyContent}</textarea></td>
				<td>${workPlan.name}</td>
				<td>${workPlan.remainDeptName}</td>
				<td>${workPlan.personLiable.name}</td>
				<td><fmt:formatDate value="${workPlan.feedBackTime}" pattern="yyyy年MM月dd日 hh时mm分ss秒"/></td>
				<td><fmt:formatDate value="${workPlan.replyTime}" pattern="yyyy年MM月dd日 hh时mm分ss秒"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>