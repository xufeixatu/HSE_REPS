<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
<!-- <script type="text/javascript">
	$(document).ready(
			function() {
				//更新时回显frequency频次的选择项开始
				<c:if test="${not empty workPlan.frequency}">
				var freqs = "${workPlan.frequency}".split(",");
				$("input[name='frequency']").each(function() {
					for (var i = 0; i < freqs.length; i++) {
						if (this.value == freqs[i]) {
							this.checked = true;
							break;
						}
					}
				});
				</c:if>
				//更新时回显frequency频次的选择项结束
				$("#name").focus();
				$("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
</script> -->
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="#">分派子任务</a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="workPlan"
		action="${ctx}/work/workPlan/assigne_work" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<input type="hidden" name="child" value="true" />
		<input type="hidden" name="planType" value="${planTypeDict.id}" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">负责人:</label>
			<div class="controls">
				<sys:treeselect id="personLiableId" name="personLiable.id"
					value="${workPlan.personLiable.id}" labelName="personLiable.name"
					labelValue="${workPlan.personLiable.name}" title="用户"
					url="/sys/office/treeData?type=3" allowClear="true"
					notAllowSelectParent="true" disabled="true" />
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="work:workPlan:edit">
			
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="分配" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>

	</form:form>
	
</body>
</html>