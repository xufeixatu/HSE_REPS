<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>ACT卡管理</title>
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
		<li class="active"><a href="${ctx}/actcard/actcard/">ACT卡列表</a></li>
		<shiro:hasPermission name="actcard:actcard:edit"><li><a href="${ctx}/actcard/actcard/form">ACT卡申请提交</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="actcard" action="${ctx}/actcard/actcard/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>不安全行为：</label>
				<form:input path="unsafeActs" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>纠正措施：</label>
				<form:input path="measure" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>鼓励行为：</label>
				<form:input path="safetyActs" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>改进建议：</label>
				<form:input path="suggestions" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>填报人：</label>
				<form:input path="reporter" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>填报人单位：</label>
				<sys:treeselect id="reporterOffice" name="reporterOffice.id" value="${actcard.reporterOffice.id}" labelName="reporterOffice.name" labelValue="${actcard.reporterOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>填报时间：</label>
				<input name="reportingTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${actcard.reportingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>关闭人：</label>
				<form:input path="closer.id" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>关闭时间：</label>
				<input name="closeTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${actcard.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>状态：</label>
				<form:input path="state" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>属地单位</th>
				<th>填报人</th>
				<th>填报人单位</th>
				<th>填报时间</th>
				<th>整改结果</th>
				<th>关闭人</th>
				<th>关闭时间</th>
				<th>状态</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>不安全分类</th>
				<th>不安全分类子类</th>
				<shiro:hasPermission name="actcard:actcard:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="actcard">
			<tr>
				<td><a href="${ctx}/actcard/actcard/form?id=${actcard.id}">
					${actcard.territorialOffice.name}
				</a></td>
				<td>
					${actcard.actcardUnsfeEvent.name}
				</td>
				<td>
					${actcard.actcardUnsafeEventChild.name}
				</td>
				<td>
					${actcard.reporter}
				</td>
				<td>
					${actcard.reporterOffice.name}
				</td>
				<td>
					<fmt:formatDate value="${actcard.reportingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${actcard.rectificationResult}
				</td>
				<td>
					${actcard.closer.id}
				</td>
				<td>
					<fmt:formatDate value="${actcard.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${actcard.state}
				</td>
				<td>
					<fmt:formatDate value="${actcard.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${actcard.remarks}
				</td>
				
				<shiro:hasPermission name="actcard:actcard:edit"><td>
    				<a href="${ctx}/actcard/actcard/form?id=${actcard.id}">修改</a>
					<a href="${ctx}/actcard/actcard/delete?id=${actcard.id}" onclick="return confirmx('确认要删除该ACT卡吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>