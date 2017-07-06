<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>查看并可评阅</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treeview.jsp" %>
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
				
				
				//开始树形复选
				var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
						data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
							tree.checkNode(node, !node.checked, true, true);
							return false;
						}}};
				
				// 用户-菜单
				var zNodes=[
						<c:forEach items="${actcardUnsafeEventList}" var="actcardUnsafeEvent">{id:"${actcardUnsafeEvent.id}", pId:"${not empty actcardUnsafeEvent.parent.id?actcardUnsafeEvent.parent.id:0}", name:"${not empty actcardUnsafeEvent.parent.id?actcardUnsafeEvent.name:'不安全事件列表'}"},
			            </c:forEach>];
				if("指定责任人" == "${actcard.state}" || 
						"反馈整改情况" == "${actcard.state}" ||
						"已关闭" == "${actcard.state}"||
						"关闭问题" == "${actcard.state}"){
					
					var setting = {view:{selectedMulti:false},
							data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
								tree.checkNode(node, !node.checked, true, true);
								return false;
							}}};
					// 用户-菜单
					var zNodes=[
							<c:forEach items="${actcardUnsafeEventList2}" var="actcardUnsafeEvent">{id:"${actcardUnsafeEvent.id}", pId:"${not empty actcardUnsafeEvent.parent.id?actcardUnsafeEvent.parent.id:0}", name:"${not empty actcardUnsafeEvent.parent.id?actcardUnsafeEvent.name:'不安全事件列表'}"},
				            </c:forEach>];
				}
				// 初始化树结构
				var tree = $.fn.zTree.init($("#actcardUnsafeEventTree"), setting, zNodes);
				// 不选择父节点
				tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
				//
				//
				tree.setting.callback = {
						onCheck : function(event, treeId, treeNode){
							//alert(treeNode.tId + ", " + treeNode.name);
							var treeObj = $.fn.zTree.getZTreeObj(treeId);
							var nodes = treeObj.transformToArray(treeNode);
							
							json = eval(nodes)  
							for(var i=0; i<json.length; i++)  
							{  
							   if(json[i].name.indexOf("其他") > -1){
								   if(!$("#"+json[i].id+"_temp")[0]){
									   $("#"+json[i].tId).append("<input type='text' mynode='mynode' id='"+json[i].id+"_temp'/>");
								   }else{
									   $("#"+json[i].id+"_temp").remove();
								   }
							   }
							}  
						}
				};
				tree.expandAll(true); 
				
				
				$("#reportPicPreview").parent().children("a").remove();//取消图片的上传
				$("#rectificationPic").parent().children("a").remove();//取消图片的上传
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
	<form:form modelAttribute="actcard" action="${ctx}/actcard/actcard/review" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
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
					<td colspan="5">
						<div class="control-group">
							<div class="controls">
								<div id="actcardUnsafeEventTree" class="ztree" style="margin-top:3px;float:left;"></div>
							</div>
						</div>
					
					</td>
				</tr>
				<tr>
					<td class="tit">上报时图片：</td>
					<td colspan="5">
						<div class="controls">
							<form:hidden id="reportPic" path="reportPic" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
							<sys:ckfinder input="reportPic" type="files" uploadPath="/actcard/actcard" readonly="readonly" selectMultiple="false"/>
						</div>
					</td>
					
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
					<td colspan="5">
						<div class="controls">
							<form:hidden id="rectificationPic" path="rectificationPic" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
							<sys:ckfinder input="rectificationPic" type="files" uploadPath="/actcard/actcard" readonly="readonly" selectMultiple="false"/>
						</div>
					</td>
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