<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训记录管理</title>
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
		<li class="active"><a href="${ctx}/train/record/trainRecord/">培训记录列表</a></li>
		<shiro:hasPermission name="train:record:trainRecord:edit"><li><a href="${ctx}/train/record/trainRecord/form">培训记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainRecord" action="${ctx}/train/record/trainRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>培训主题：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>受训单位：</label>
				<sys:treeselect id="objectOffice" name="objectOffice.id" value="${trainRecord.objectOffice.id}" labelName="objectOffice.name" labelValue="${trainRecord.objectOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>责任单位：</label>
				<sys:treeselect id="subjectOffice" name="subjectOffice.id" value="${trainRecord.subjectOffice.id}" labelName="subjectOffice.name" labelValue="${trainRecord.subjectOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>联系人：</label>
				<sys:treeselect id="contact" name="contact.id" value="${trainRecord.contact.id}" labelName="contact.name" labelValue="${trainRecord.contact.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			
			<li><label>是否计划：</label>
				<form:radiobuttons path="isPlan" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</li>
			
			<li><label>培训计划：</label>
				<form:select path="plan.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${trainPlanList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>培训时间：</label>
				<input name="beginTrainTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${trainRecord.beginTrainTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endTrainTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${trainRecord.endTrainTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			
			<li><label>状态:</label>
				<form:radiobuttons path="status" items="${fns:getDictList('train_record_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>培训主题</th>
				<th>培训时间</th>
				<th>责任单位</th>
				<th>受训单位</th>
				<th>培训人数</th>
				<th>培训时长</th>
				<th>联系人</th>
				<th>归档状态</th>
				<th>是否考试</th>
				<th>是否计划：培训计划</th>
				<th>备注信息(取消原因)</th>
				<th>创建时间</th>
				<shiro:hasPermission name="train:record:trainRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="trainRecord">
			<tr>
				<td><a href="${ctx}/train/record/trainRecord/form?id=${trainRecord.id}">
					${trainRecord.name}
				</a></td>
				<td>
					<fmt:formatDate value="${trainRecord.trainTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${trainRecord.subjectOffice.name}</td>
				<td>${trainRecord.objectOffice.name}</td>
				<td>${trainRecord.planNumber}</td>
				<td>${trainRecord.trainDuration}</td>
				<td>${trainRecord.contact.name}</td>
				<td>${fns:getDictLabel(trainRecord.status, 'train_record_status', '')}</td>
				<td>${fns:getDictLabel(trainRecord.isExam, 'yes_no', '')}</td>
				<td>${fns:getDictLabel(trainRecord.isPlan, 'yes_no', '')}:<a href="${ctx}/train/plan/trainPlan/form?id=${trainRecord.plan.id}">
					${trainRecord.plan.name}
				</a></td>
				<td>
					${trainRecord.remarks}
				</td>
				<td>
					<fmt:formatDate value="${trainRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="train:record:trainRecord:edit"><td>
					<c:if test="${trainRecord.status!='1'}" >
						<a href="${ctx}/train/record/trainRecord/form?id=${trainRecord.id}">修改</a>
						<a href="${ctx}/train/record/trainRecord/delete?id=${trainRecord.id}" onclick="return confirmx('确认要删除该培训记录吗？', this.href)">删除</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>