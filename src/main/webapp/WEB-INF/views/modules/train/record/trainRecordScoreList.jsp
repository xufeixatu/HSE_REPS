<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>受培人员成绩管理</title>
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
		<li class="active"><a href="${ctx}/train/record/trainRecordScore/">受培人员成绩列表</a></li>
		<shiro:hasPermission name="train:record:trainRecordScore:edit"><li><a href="${ctx}/train/record/trainRecordScore/form">受培人员成绩添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainRecordScore" action="${ctx}/train/record/trainRecordScore/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>培训记录：</label>
				<form:input path="record.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>受培人员：</label>
				<sys:treeselect id="user" name="user.id" value="${trainRecordScore.user.id}" labelName="user.name" labelValue="${trainRecordScore.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>培训记录</th>
				<th>受培人员</th>
				<th>培训成绩</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="train:record:trainRecordScore:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="trainRecordScore">
			<tr>
				<td><a href="${ctx}/train/record/trainRecordScore/form?id=${trainRecordScore.id}">
					${trainRecordScore.record.name}
				</a></td>
				<td>
					${trainRecordScore.user.name}
				</td>
				<td>
					${trainRecordScore.score}
				</td>
				<td>
					<fmt:formatDate value="${trainRecordScore.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${trainRecordScore.remarks}
				</td>
				<shiro:hasPermission name="train:record:trainRecordScore:edit"><td>
    				<a href="${ctx}/train/record/trainRecordScore/form?id=${trainRecordScore.id}">修改</a>
					<a href="${ctx}/train/record/trainRecordScore/delete?id=${trainRecordScore.id}" onclick="return confirmx('确认要删除该受培人员成绩吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>