<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>查看并可评阅</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(
			function() {
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
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/actcard/actcard/">ACT卡列表</a></li>
		<li><a href="${ctx}/actcard/actcard/form?id=${actcard.id}">ACT卡<shiro:hasPermission
					name="actcard:actcard:edit">${not empty actcard.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="actcard:actcard:edit">查看</shiro:lacksPermission></a></li>
		<li class="active"><a
			href="${ctx}/actcard/actcard/view?id=${actcard.id}">ACT卡评阅</a></li>
	</ul>
	<form:form modelAttribute="actcardReview" action="${ctx}/actcard/actcard/review" method="post" class="form-horizontal">
		<sys:message content="${message}" />
		<fieldset>
			<legend>审批详情</legend>
			<table class="table-form">
				<tr>
					<td class="tit">属地单位：</td>
					<td colspan="5">${actcard.territorialOffice.name}</td>
				</tr>
				<tr>
					<td class="tit">所观察到的不安全行为及有污染隐患的行为所关注：</td>
					<td colspan="5">${actcard.unsafeActs}</td>
				</tr>
				<tr>
					<td class="tit">对不安全行为及隐患即刻的纠正行为和措施：</td>
					<td colspan="5">${actcard.measure}</td>
				</tr>
				<tr>
					<td class="tit">所观察到的需要鼓励的安全、环保行为：</td>
					<td colspan="5">${actcard.safetyActs}</td>
				</tr>
				<tr>
					<td class="tit">持续改进的HSE工作的其它建议：</td>
					<td colspan="5">${actcard.suggestions}</td>
				</tr>
				<tr>
					<td class="tit">填报人：</td>
					<td colspan="2">${actcard.reporter}</td>
					
				</tr>
				<tr>
					<td class="tit">填报人单位：</td>
					<td colspan="2">${actcard.reporterOffice}</td>
					<td class="tit">填报时间：</td>
					<td colspan="2"><fmt:formatDate
							value="${actcard.reportingTime}" pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td class="tit">不安全分类：</td>
					<td colspan="5">${actcard.actcardUnsafeEventId}</td>
				</tr>
				<tr>
					<td class="tit">不安全子分类：</td>
					<td colspan="5">${actcard.actcardUnsafeEventChildId}</td>
				</tr>
				<tr>
					<td class="tit">上报时图片：</td>
					<td colspan="5">${actcard.reportPic}</td>
				</tr>
				<tr>
					<td class="tit">整改人：</td>
					<td colspan="2">${actcard.solver.name}</td>
				</tr>
				<tr>
					<td class="tit">整改结果：</td>
					<td colspan="5">${actcard.rectificationResult}</td>
				</tr>
				<tr>
					<td class="tit">整改图片：</td>
					<td colspan="5">${actcard.rectificationPic}</td>
				</tr>
				<tr>
					<td class="tit">质量安全环保科回复：</td>
					<td colspan="5">${actcard.closerReport}</td>
				</tr>


			</table>
			<input id="actcard_id" name="actcard.id" type="hidden"
				value="${actcard.id}" />
			<div class="control-group">
				<label class="control-label">评阅：</label>
				<div class="controls">
					<textarea id="content" name="content" minlength="5" maxlength="255"
						class="input-xxlarge required" rows="4"></textarea>
				</div>
			</div>

		</fieldset>
		<div class="form-actions">
			<input id="btnSubmit" onclick="return submitColtrol();"
				class="btn btn-primary" type="submit" value="提交" />&nbsp; <input
				id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
		<table class="table-form">
			<c:forEach items="${actcard.actcardReviewList}" var="actcardReview">
				<tr>
					<td class="tit">评阅内容：</td>
					<td colspan="5">${actcardReview.content}</td>
				</tr>
				<tr>
					<td class="tit">评阅时间：</td>
					<td colspan="2"><fmt:formatDate
							value="${actcardReview.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td class="tit">评阅人：</td>
					<td colspan="2">${actcardReview.createBy.name}</td>
				</tr>
			</c:forEach>
		</table>
	</form:form>
</body>
</html>
