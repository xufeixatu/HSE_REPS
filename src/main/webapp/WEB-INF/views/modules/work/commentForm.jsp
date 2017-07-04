<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
</head>
<body>
	<ul class="nav nav-tabs">
			<li class="active"><a
				href="#">点评列表</a></li>
			
	</ul>
	<br />
	<div class="control-group">点评列表：</div>
	<c:forEach items="${comments}" var="w">
		<div class="control-group">
			<label class="control-label">
				${fns:getUserById(w.reviwer.id).name}
				点评:
			</label>
			<label class="control-label">
				${w.commentTime}
			</label>
		</div>
	</c:forEach>
	<form:form action="${ctx}/work/workPlan/comment_save" method="post" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="id" />
		<div class="control-group">
			<label class="control-label">点评:</label>
			<div class="controls">
				<form:textarea path="commentContent" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">打分:</label>
			<div class="controls">
				<form:input path="score" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div class="form-actions">
			
			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="点评"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>