<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训需求管理</title>
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
		<li class="active"><a href="${ctx}/train/matrix/trainNeedMatrix/matrix">培训需求矩阵</a></li>
		<li><a href="${ctx}/train/matrix/trainNeedMatrix/">培训需求列表</a></li>
		<shiro:hasPermission name="train:matrix:trainNeedMatrix:edit"><li><a href="${ctx}/train/matrix/trainNeedMatrix/form">培训需求添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainNeedMatrix" action="${ctx}/train/matrix/trainNeedMatrix/matrix" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>版本号：</label>
				<form:select path="version" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('train_matrix_version')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>岗位：</label>
				<form:select path="trainJob.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${trainJobList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>知识内容：</label>
				<form:select path="trainContent.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${trainContentList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
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
				<td>人员分类</td>
				<td>序号</td>
				<td>HSE培训管理信息</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>${fns:getDictLabel(trainContent.classify, 'train_content_classify', '')}</td>
				</c:forEach>
			</tr>
			<tr>
				<td>人员分类</td>
				<td>序号</td>
				<td>HSE培训管理信息</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>${trainContent.name}</td>
				</c:forEach>
			</tr>
			<tr>
				<td>课程基本信息</td>
				<td>1</td>
				<td>初次培训课时要求（小时）</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>${trainContent.firstPeriod}</td>
				</c:forEach>
			</tr>
			<tr>
				<td>课程基本信息</td>
				<td>2</td>
				<td>复培课时/频率（小时/N年）</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>${trainContent.nextPeriod}</td>
				</c:forEach>
			</tr>
			<tr>
				<td>课程基本信息</td>
				<td>3</td>
				<td>培训组织单位</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>${trainContent.organizer}</td>
				</c:forEach>
			</tr>
			<tr>
				<td>课程基本信息</td>
				<td>4</td>
				<td>培训完成要求（职前/职后）</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>${fns:getDictLabel(trainContent.requirement, 'train_content_requirement', '')}</td>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${trainJobList}" var="trainJob">
			<tr>
				<td>${fns:getDictLabel(trainJob.classify, 'train_job_classify', '')}</td>
				<td>${trainJob.sn}</td>
				<td>${trainJob.name}</td>
				<c:forEach items="${trainContentList}" var="trainContent">
					<td>
						<c:forEach items="${trainNeedMatrixList}" var="trainNeedMatrix">
							<c:if test="${trainNeedMatrix.trainContent.sn == trainContent.sn && trainNeedMatrix.trainJob.sn == trainJob.sn}">
								<shiro:hasPermission name="train:matrix:trainNeedMatrix:edit">
							    	<a href="${ctx}/train/matrix/trainNeedMatrix/form?id=${trainNeedMatrix.id}">R</a>
								</shiro:hasPermission>
							</c:if>
						</c:forEach>
					</td>
				</c:forEach>
				
			</tr>
		</c:forEach>
		
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>