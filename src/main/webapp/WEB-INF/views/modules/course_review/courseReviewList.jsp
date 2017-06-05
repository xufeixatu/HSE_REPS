<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
	<div>
		<form:form id="inputForm" modelAttribute="courseReview"
			action="${ctx}/course_review/courseReview/save" method="post"
			class="form-horizontal">
			<form:hidden path="id"/>
			<sys:message content="${message}" />
			<div class="control-group">
				<label class="control-label">评论内容：</label> <span> <form:textarea
						path="assessOpinion" htmlEscape="false" rows="4" maxlength="255"
						class="input-xxlarge " />
				</span> <span> <shiro:hasPermission
						name="course_review:courseReview:edit">
						<input id="btnSubmit" class="btn btn-primary" type="submit"
							value="评论" />&nbsp;</shiro:hasPermission>
				</span>
			</div>
		</form:form>
		<sys:message content="${message}" />
		<table id="contentTable"
			class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>评论内容</th>
					<th>评论人</th>
					<th>评论时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="courseReview">
					<tr>
						<td><a
							href="${ctx}/course_review/courseReview/form?id=${courseReview.id}">
								${courseReview.assessOpinion} </a></td>
						<td>${courseReview.assessById}</td>
						<td><fmt:formatDate value="${courseReview.assessTime}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="pagination">${page}</div>
</body>
</html>