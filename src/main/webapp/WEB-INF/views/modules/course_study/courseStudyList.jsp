<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<!-- <!-- <<<<<<< HEAD --> -->
	<title>学习记录管理</title>
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
		<li class="active"><a href="${ctx}/course_study/courseStudy/">学习记录列表</a></li>
		<shiro:hasPermission name="course_study:courseStudy:edit"><li><a href="${ctx}/course_study/courseStudy/form">学习记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="courseStudy" action="${ctx}/course_study/courseStudy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>status</th>
				<th>duration</th>
				<th>study_start_time</th>
				<th>study_end_time</th>
				<th>打分</th>
				<th>grade_date</th>
				<th>学习者</th>
				<th>创建时间</th>
				<shiro:hasPermission name="course_study:courseStudy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="courseStudy">
			<tr>
				<td><a href="${ctx}/course_study/courseStudy/form?id=${courseStudy.id}">
					${courseStudy.status}
				</a></td>
				<td>
					${courseStudy.duration}
				</td>
				<td>
					<fmt:formatDate value="${courseStudy.studyStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${courseStudy.studyEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${courseStudy.grade}
				</td>
				<td>
					<fmt:formatDate value="${courseStudy.gradeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${courseStudy.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${courseStudy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="course_study:courseStudy:edit"><td>
    				<a href="${ctx}/course_study/courseStudy/form?id=${courseStudy.id}">修改</a>
					<a href="${ctx}/course_study/courseStudy/delete?id=${courseStudy.id}" onclick="return confirmx('确认要删除该学习记录吗？', this.href)">删除</a>

				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>