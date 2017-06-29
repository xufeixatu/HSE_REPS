<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
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
	//否决的方法
	function reject(){
		location = "${ctx}/work/workPlan/reject?id=${workPlan.id}&planType=${planTypeDict.value}";
	}

	//修改的方法
	function save(){
		var f = $("form")[0];
		f.submit();
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="#">受理工作任务</a></li>
	</ul>
	<br />
	<%@include file="/inc/detail.jsp" %>
	
	<form:form action="${ctx}/work/workPlan/remain_save" method="post" id="auditingForm" modelAttribute="workPlan" class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="currentRemainDeptId"/>
		<input type="hidden" name="planType" value="company" />
		<form:hidden path="depts"/>
		<div class="control-group">
			<label class="control-label">接受工作留言:</label>
			<div class="controls">
				<form:textarea path="remainDesc" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " cssClass="required"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit1" class="btn btn-primary" type="submit"
				value="受理"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>