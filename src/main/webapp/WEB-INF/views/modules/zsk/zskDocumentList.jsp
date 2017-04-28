<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文档管理</title>
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
		<li class="active"><a href="${ctx}/zsk/zskDocument/">文档列表</a></li>
		<shiro:hasPermission name="zsk:zskDocument:edit"><li><a href="${ctx}/zsk/zskDocument/form">文档添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="zskDocument" action="${ctx}/zsk/zskDocument/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>文件名称：</label>
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
				<th>文件名称</th>
				<th>更新时间</th>
				<th>文件描述信息</th>
				<th>文件类型</th>
				<th>版本号码</th>
				<th>修改原因</th>
				<th>修改内容</th>
				<th>备注信息</th>
				<shiro:hasPermission name="zsk:zskDocument:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zskDocument">
			<tr>
				<td><a href="${ctx}/zsk/zskDocument/form?id=${zskDocument.id}">
					${zskDocument.fileName}
				</a></td>
				<td>
					<fmt:formatDate value="${zskDocument.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${zskDocument.descInfo}
				</td>
				<td>
					${zskDocument.docType}
				</td>
				<td>
					${zskDocument.versionNo}
				</td>
				<td>
					${zskDocument.modifyReason}
				</td>
				<td>
					${zskDocument.modifyContent}
				</td>
				<td>
					${zskDocument.remarks}
				</td>
				<shiro:hasPermission name="zsk:zskDocument:edit"><td>
    				<a href="${ctx}/zsk/zskDocument/form?id=${zskDocument.id}">修改</a>
					<a href="${ctx}/zsk/zskDocument/delete?id=${zskDocument.id}" onclick="return confirmx('确认要删除该文档吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>