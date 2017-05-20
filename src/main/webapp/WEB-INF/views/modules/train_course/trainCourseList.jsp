<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训课件上传与查看管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		
	</style>
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
	<style type="text/css">
		a{
			color:#000000;
			text-decoration:none;
		}
		a:hover{
			color:#8cd29f;
			text-decoration:none;
		}
		#container{
			width:100%;
			height:100%;
			margin:10px;
			padding:20px;
			background-color:#d7d7d7;
		}
		#row{
			width:100%;
			height:100%;
		}
		.course{
			display:inline-block;
			width:25%;
			height:auto;
			margin:0 3% 20px 3%;
			
		}
		.course > a{
			display:inline-block;
			width:100%;
			height:100%;
			
		}
		.course > a >img{
			width:100%;
		}
		.course > .course-text{
			height:auto;
			padding:15px 10px;
			background-color:#FFFFFF;
			font-size:12px;
		}
		.course > .course-text > a > .course-text-title{
			display:block;
			width:100%;
			font-weight:bolder;
		}
		.course > .course-text > .course-text-description{
			display:block;
			width:100%;
			color:#999999;
			font-size:12px;
			margin-bottom:10px;
		}
		.course > .course-text > .course-text-count{
			display:inline-block;
			width:70%;
			
		}
		.course > .course-text > .course-text-count > .course-text-count-study,
		.course > .course-text > .course-text-count > .course-text-count-time{
			font-size:12px;
		}
		
		.course > .course-text > .course-text-operate{
			display:inline-block;
			width:25%;
			float:right;
			font-size:12px;
		}
		.pagination{
			text-align:center;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/train_course/trainCourse/">培训课件查看列表</a></li>
		<shiro:hasPermission name="train_course:trainCourse:edit"><li><a href="${ctx}/train_course/trainCourse/form">上传培训课件</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainCourse" action="${ctx}/train_course/trainCourse/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>课件名称：</label>
				<form:input path="courseName" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>

	<div id="container">
  		<div id="row">
  			<c:forEach items="${page.list}" var="trainCourse">
		  		 <div class="course">
		  		 	<a href="${ctx}/train_course/trainCourse2/list?id=${trainCourse.id}">
	
		  		 		<img src="http://localhost:8080${trainCourse.coverId}" />
		  		 	</a>
		  		 	<div class="course-text">
		  		 		<a href="${ctx}/train_course/trainCourse2/list?id=${trainCourse.id}">
		  		 			<span class="course-text-title">${trainCourse.courseName}</span>
		  		 		</a>
		  		 		<span class="course-text-description">${trainCourse.courseDec}</span>
		  		 		<span class="course-text-count">
		  		 			<span class="course-text-count-time">${trainCourse.courseTime}课时</span>
		  		 			<span class="course-text-count-study">${trainCourse.courseCount}学习</span>
		  		 		</span>
		  		 		<span class="course-text-operate">
		  		 			<a class="course-text-operate-modify" href="${ctx}/train_course/trainCourse/form?id=${trainCourse.id}">修改</a>
		  		 			<a class="course-text-operate-delete" href="${ctx}/train_course/trainCourse/delete?id=${trainCourse.id}" onclick="return confirmx('确认要删除该培训课件上传与查看吗？', this.href)">删除</a>
		  		 		</span>
		  		 	</div>
		  		 	
		  		 </div>
	  		 </c:forEach>
		</div>
	</div>

	<div class="pagination">${page}</div>
</body>
</html>