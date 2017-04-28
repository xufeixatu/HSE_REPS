<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>历史文档查看管理</title>
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
		<li class="active"><a href="${ctx}/zsk/zskHistoryVersion/">历史文档查看列表</a></li>
		<shiro:hasPermission name="zsk:zskHistoryVersion:edit"><li><a href="${ctx}/zsk/zskHistoryVersion/form">历史文档查看添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="zskHistoryVersion" action="${ctx}/zsk/zskHistoryVersion/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>文档编号：</label>
				<form:input path="documentId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>文件名：</label>
				<form:input path="fileName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>文档编号</th>
				<th>文件名</th>
				<th>更新时间</th>
				<th>描述信息</th>
				<th>文件类型</th>
				<th>版本号</th>
				<th>修改内容</th>
				<th>删除标记</th>
				<th>备注信息</th>
				<shiro:hasPermission name="zsk:zskHistoryVersion:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zskHistoryVersion">
			<tr>
				<td><a href="${ctx}/zsk/zskHistoryVersion/form?id=${zskHistoryVersion.id}">
					${zskHistoryVersion.documentId}
				</a></td>
				<td>
					${zskHistoryVersion.fileName}
				</td>
				<td>
					<fmt:formatDate value="${zskHistoryVersion.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${zskHistoryVersion.descInfo}
				</td>
				<td>
					${zskHistoryVersion.docType}
				</td>
				<td>
					${zskHistoryVersion.versionNo}
				</td>
				<td>
					${zskHistoryVersion.modifyContent}
				</td>
				<td>
					${fns:getDictLabel(zskHistoryVersion.delFlag, 'del_flag', '')}
				</td>
				<td>
					${zskHistoryVersion.remarks}
				</td>
				<shiro:hasPermission name="zsk:zskHistoryVersion:edit"><td>
    				<a href="${ctx}/zsk/zskHistoryVersion/form?id=${zskHistoryVersion.id}">修改</a>
					<a href="${ctx}/zsk/zskHistoryVersion/delete?id=${zskHistoryVersion.id}" onclick="return confirmx('确认要删除该历史文档查看吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>