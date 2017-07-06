<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查记录管理</title>
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
		<li class="active"><a href="${ctx}/check/inspct/">检查记录列表</a></li>
		<shiro:hasPermission name="check:inspct:edit"><li><a href="${ctx}/check/inspct/form">检查记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="inspct" action="${ctx}/check/inspct/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>检查部门：</label>
				<sys:treeselect id="checkOffice" name="checkOffice.id" value="${inspct.checkOffice.id}" labelName="checkOffice.name" labelValue="${inspct.checkOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>检查类别：</label>
				<sys:treeselect id="checkTypeClass" name="checkTypeClass.id" value="${inspct.checkTypeClass.id}" 
					labelName="checkTypeClass.name" labelValue="${inspct.checkTypeClass.name}"
					title="检查类别" url="/check/checkTypeClass/treeData" extId="${inspct.checkTypeClass.id}" cssClass="input-small" allowClear="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>检查部门</th>
				<th>检查人</th>
				<th>检查时间</th>
				<th>受检部门</th>
				<th>检查类别</th>
				<th>上报问题</th>
				<shiro:hasPermission name="check:inspct:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="inspct">
			<tr>
				<td>
					${inspct.checkOfficeName}
				</td>
				<td>
					${inspct.checkUserName}
				</td>
				<td>
					<fmt:formatDate value="${inspct.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${inspct.inspectionOfficeName}
				</td>
				<td>
					${inspct.typeName}
				</td>
				<td>
					共【${inspct.aLLQuestionCount}】已整改【${inspct.solvedQuestionCount}】
				</td>
				<shiro:hasPermission name="check:inspct:edit"><td>
					<a href="${ctx}/check/checkItemCheck?inspctId=${inspct.id}">进入检查</a>
					<%-- <a href="${ctx}/check/checkItemCheck">查看具体检查项</a>
    				<a href="${ctx}/check/inspct/form?id=${inspct.id}">修改</a> --%>
    				<c:if test="${fns:getUser().admin}">
						<a href="${ctx}/check/inspct/delete?id=${inspct.id}" onclick="return confirmx('确认要删除该检查记录管理吗？', this.href)">删除</a>
					</c:if>	
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>