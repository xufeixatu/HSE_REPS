
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课件评论管理</title>
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
		<li class="active"><a href="${ctx}/course_review/courseReview/">课件评论列表</a></li>
		<shiro:hasPermission name="course_review:courseReview:edit"><li><a href="${ctx}/course_review/courseReview/form">课件评论添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="courseReview" action="${ctx}/course_review/courseReview/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<!-- <ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul> -->
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>评论人ID</th>
				<th>评论内容</th>
				<th>评论时间</th>
				<shiro:hasPermission name="course_review:courseReview:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="courseReview">
			<tr>
				<td><a href="${ctx}/course_review/courseReview/form?id=${courseReview.id}">
					${courseReview.assessById}
				</a></td>
				<td>
					${courseReview.assessOpinion}
				</td>
				<td>
					<fmt:formatDate value="${courseReview.assessTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="course_review:courseReview:edit"><td>
    				<a href="${ctx}/course_review/courseReview/form?id=${courseReview.id}">修改</a>
					<a href="${ctx}/course_review/courseReview/delete?id=${courseReview.id}" onclick="return confirmx('确认要删除该课件评论吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<div class="pagination">${page}</div>
</body>
</html>