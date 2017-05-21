<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训内容管理</title>
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
		<li class="active"><a href="${ctx}/train/matrix/trainContent/">培训内容列表</a></li>
		<shiro:hasPermission name="train:matrix:trainContent:edit"><li><a href="${ctx}/train/matrix/trainContent/form">培训内容添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainContent" action="${ctx}/train/matrix/trainContent/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>知识内容：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>培训分类：</label>
				<form:select path="classify" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('train_content_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>组织单位：</label>
				<form:input path="organizer" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li><label>完成要求：</label>
				<form:radiobuttons path="requirement" items="${fns:getDictList('train_content_requirement')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>知识内容</th>
				<th>序号</th>
				<th>培训分类</th>
				<th>初培课时</th>
				<th>复培课时/频率</th>
				<th>组织单位</th>
				<th>完成要求</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="train:matrix:trainContent:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="trainContent">
			<tr>
				<td><a href="${ctx}/train/matrix/trainContent/form?id=${trainContent.id}">
					${trainContent.name}
				</a></td>
				<td>
					${trainContent.sn}
				</td>
				<td>
					${fns:getDictLabel(trainContent.classify, 'train_content_classify', '')}
				</td>
				<td>
					${trainContent.firstPeriod}
				</td>
				<td>
					${trainContent.nextPeriod}
				</td>
				<td>
					${trainContent.organizer}
				</td>
				<td>
					${fns:getDictLabel(trainContent.requirement, 'train_content_requirement', '')}
				</td>
				<td>
					<fmt:formatDate value="${trainContent.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${trainContent.remarks}
				</td>
				<shiro:hasPermission name="train:matrix:trainContent:edit"><td>
    				<a href="${ctx}/train/matrix/trainContent/form?id=${trainContent.id}">修改</a>
					<a href="${ctx}/train/matrix/trainContent/delete?id=${trainContent.id}" onclick="return confirmx('确认要删除该培训内容吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>