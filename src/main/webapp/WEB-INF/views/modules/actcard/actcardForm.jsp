<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>ACT卡管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treeview.jsp"%>
<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var ids = [], nodes = tree.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) {
						ids.push(nodes[i].id);
					}
					$("#actcardUnsafeEventId").val(ids);
					var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
					for(var i=0; i<nodes2.length; i++) {
						ids2.push(nodes2[i].id);
					}
					$("#officeIds").val(ids2);
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
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
						   //alert(json[i].name+" " + json[i].tId)  
						   if(json[i].name.indexOf("其他") > -1){
							   //alert(json[i].name+" " + json[i].id)
							   //alert($("#"+json[i].id+"_temp"));
							   if(!$("#"+json[i].id+"_temp")[0]){
								   $("#"+json[i].tId).append("<input type='text' mynode='mynode' id='"+json[i].id+"_temp'/>");
							   }else{
								   $("#"+json[i].id+"_temp").remove();
							   }
							   
							   //var th = $.fn.zTree.getZTreeObj(json[i].id);
							   //th.setEditable(true);
						   }
						}  
					}
			};
			
			// 默认选择节点
			var ids = "${actcard.actcardUnsafeEventId}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				
				try{tree.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree.expandAll(true);
			// 刷新（显示/隐藏）机构
			//refreshOfficeTree();
			//$("#dataScope").change(function(){
			//	refreshOfficeTree();
			//});
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/actcard/actcard/">ACT卡列表</a></li>
		<li class="active"><a
			href="${ctx}/actcard/actcard/form?id=${actcard.id}">ACT卡<shiro:hasPermission
					name="actcard:actcard:edit">${not empty actcard.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="actcard:actcard:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="actcard"
		action="${ctx}/actcard/actcard/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="act.taskId" />
		<form:hidden path="act.taskName" />
		<form:hidden path="act.taskDefKey" />
		<form:hidden path="act.procInsId" />
		<form:hidden path="act.procDefId" />
		<sys:message content="${message}" />
		<div class="control-group">

			<label class="control-label">属地单位：</label>
			<div class="controls">
				<sys:treeselect id="territorialOffice" name="territorialOffice.id"
					value="${actcard.territorialOffice.id}"
					labelName="territorialOffice.name"
					labelValue="${actcard.territorialOffice.name}" title="部门"
					url="/sys/office/treeData?type=2" cssClass="" allowClear="true"
					notAllowSelectParent="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不安全事件分类：</label>
			<div class="controls">
				<sys:treeselect id="actcardUnsafeEvent" name="actcardUnsafeEvent.id"
					value="${actcard.actcardUnsafeEvent.id}"
					labelName="actcardUnsafeEvent.name"
					labelValue="${actcard.actcardUnsafeEvent.name}" title="不安全事件分类"
					url="/actcard/actcardUnsafeEvent/treeData"
					cssClass="required recipient" cssStyle="width:150px"
					allowClear="true" notAllowSelectParent="true" smallBtn="false"
					checked="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不安全事件分类子类：</label>
			<div class="controls">
				<sys:treeselect id="actcardUnsafeEventChild"
					name="actcardUnsafeEventChild.id"
					value="${actcard.actcardUnsafeEventChild.id}"
					labelName="actcardUnsafeEventChild.name"
					labelValue="${actcard.actcardUnsafeEventChild.name}"
					title="不安全事件分类子类" url="/actcard/actcardUnsafeEvent/treeData"
					cssClass="required recipient" cssStyle="width:150px"
					allowClear="true" notAllowSelectParent="true" smallBtn="false"
					checked="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所观察到的不安全行为及有污染隐患的行为：</label>

			<div class="controls">
				<form:textarea path="unsafeActs" htmlEscape="false" rows="4"
					class="input-xxlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">对不安全行为及隐患即刻的纠正行为和措施：</label>
			<div class="controls">
				<form:textarea path="measure" htmlEscape="false" rows="4"
					class="input-xxlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所观察到的需要鼓励的安全、环保行为：</label>
			<div class="controls">
				<form:textarea path="safetyActs" htmlEscape="false" rows="4"
					class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">持续改进的HSE工作的其它建议：</label>
			<div class="controls">
				<form:textarea path="suggestions" htmlEscape="false" rows="4"
					class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填报人：</label>
			<div class="controls">
				<form:input path="reporter" htmlEscape="false" maxlength="255"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填报人单位：</label>
			<div class="controls">
				<form:input path="reporterOffice" htmlEscape="false" maxlength="255"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填报时间：</label>
			<div class="controls">
				<input name="reportingTime" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${actcard.reportingTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group" style="display: none">
			<label class="control-label">不安全分类：</label>
			<div class="controls">
				<form:input path="actcardUnsafeEventId" htmlEscape="false"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group" style="display: none">
			<label class="control-label">不安全分类子类：</label>
			<div class="controls">
				<form:input path="actcardUnsafeEventChildId" htmlEscape="false"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不安全分类:</label>
			<div class="controls">
				<div id="actcardUnsafeEventTree" class="ztree"
					style="margin-top: 3px; float: left;"></div>
				<form:hidden path="actcardUnsafeEventId" />

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">属地单位：</label>
			<div class="controls">
				<sys:treeselect id="territorialOffice" name="territorialOffice.id"
					value="${actcard.territorialOffice.id}"
					labelName="territorialOffice.name"
					labelValue="${actcard.territorialOffice.name}" title="部门"
					url="/sys/office/treeData?type=2" cssClass="required"
					allowClear="true" notAllowSelectParent="true" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上报时图片：</label>
			<div class="controls">
				<form:hidden id="reportPic" path="reportPic" htmlEscape="false"
					maxlength="1000" class="input-xlarge" />
				<sys:ckfinder input="reportPic" type="files"
					uploadPath="/actcard/actcard" selectMultiple="true" />
			</div>
		</div>


		<div class="control-group">
			<label class="control-label">整改人：</label>
			<div class="controls">
				<sys:treeselect id="solver" name="solver.id"
					value="${actcard.solver.id}" labelName="solver.name"
					labelValue="${actcard.solver.name}" title="用户"
					url="/sys/office/treeData?type=3" cssClass="" allowClear="true"
					notAllowSelectParent="true" />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">整改结果：</label>
			<div class="controls">
				<form:textarea path="rectificationResult" htmlEscape="false"
					rows="4" class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">整改图片：</label>
			<div class="controls">
				<form:hidden id="rectificationPic" path="rectificationPic"
					htmlEscape="false" maxlength="1000" class="input-xlarge" />
				<sys:ckfinder input="rectificationPic" type="files"
					uploadPath="/actcard/actcard" selectMultiple="true" />
			</div>
		</div>

		<c:if test='${actcard.state == "关闭问题"}'>
			<div class="control-group">
				<label class="control-label">质量安全环保科回复：</label>
				<div class="controls">
					<form:textarea path="closerReport" htmlEscape="false" rows="4"
						class="input-xxlarge " />
				</div>
			</div>
		</c:if>

		<!-- 
		<div class="control-group">
			<label class="control-label">关闭人：</label>
			<div class="controls">
				<sys:treeselect id="closer" name="closer.id" value="${actcard.closer.id}" labelName="closer.name" labelValue="${actcard.closer.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关闭时间：</label>
			<div class="controls">
				<input name="closeTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${actcard.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">属地单位：</label>
			<div class="controls">
				<sys:treeselect id="territorialOffice" name="territorialOffice.id" value="${actcard.territorialOffice.id}" labelName="territorialOffice.name" labelValue="${actcard.territorialOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上报时图片：</label>
			<div class="controls">
				<form:hidden id="reportPic" path="reportPic" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
				<sys:ckfinder input="reportPic" type="files" uploadPath="/actcard/actcard" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关闭人：</label>
			<div class="controls">
				<sys:treeselect id="closer" name="closer.id" value="${actcard.closer.id}" labelName="closer.name" labelValue="${actcard.closer.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		 -->



		<!-- 
		<div class="control-group">
			<label class="control-label">user_id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${actcard.user.id}" labelName="user.name" labelValue="${actcard.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">office_id：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${actcard.office.id}" labelName="office.name" labelValue="${actcard.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			<label class="control-label">不安全分类子类：</label>
				<form:input path="actcardUnsafeEventChildId" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">整改人：</label>
			<div class="controls">
				<sys:treeselect id="solver" name="solver.id" value="${actcard.solver.id}" labelName="solver.name" labelValue="${actcard.solver.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">user_id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${actcard.user.id}" labelName="user.name" labelValue="${actcard.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">office_id：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${actcard.office.id}" labelName="office.name" labelValue="${actcard.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
		-->
		<div class="form-actions">
			<shiro:hasPermission name="actcard:actcard:edit">
				<input id="btnSubmit" onclick="return submitColtrol();"
					class="btn btn-primary" type="submit" value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
	<script type="text/javascript">
	function readonlyStart(){
		//开始只读
		readonlybyid("unsafeActs");
		readonlybyid("measure");
		readonlybyid("safetyActs");
		readonlybyid("suggestions");
		readonlybyid("reporter");
		readonlybyid("reporterOffice");
		readonlybyid("reportingTime");
		$("[name='reportingTime']").attr("disabled","disabled");
		readonlybyid("actcardUnsafeEventId");
		readonlybyid("actcardUnsafeEventChildId");
		readonlybyid("territorialOfficeName");
		readonlybyid("reportPicPreview");
		$("#reportPicPreview").parent().children("a").remove();//有待检查
		$("#actcardUnsafeEventTree span").attr("disabled","disabled");
		$("#actcardUnsafeEventTree span").attr("style","readonly:readonly");
	}
	function readonlyAssign(){
		//指定责任人只读
		readonlybyid("solverName");
	}
	function hideAssign(){
		$("#solverName").parent().parent().parent().hide();
	}
	function readonlyFeedback(){
		//反馈整改情况只读
		readonlybyid("rectificationResult");
		$("#rectificationPicPreview").parent().children("a").remove();//有待检查
	}
	function hideFeedback(){
		hidegpdiv4id("rectificationResult");
		hidegpdiv4id("rectificationPic");
	}
	$(function(){//加载完成后，修改界面
		if("指定责任人" == "${actcard.state}"){
			//alert("${actcard.state}");
			readonlyStart();
			addpxing("solverName");
			hideFeedback();
		}else if("反馈整改情况" == "${actcard.state}") {
			//alert("${actcard.state}");
			readonlyStart();
			readonlyAssign();
			addxing("rectificationResult");
		}else if("关闭问题" == "${actcard.state}") {
			//alert("${actcard.state}");
			readonlyStart();
			readonlyAssign();
			readonlyFeedback();
			addxing("closerReport");
		}else{
			//开始
			hideAssign();//隐藏指定责任人
			hideFeedback();
			
		}
	});
	function submitColtrol(){
		//指定责任人\反馈整改情况\关闭问题
		if("指定责任人" == "${actcard.state}"){
			if(idIsNull("solverName")){
				addIsNotNullStr4idParent("solverName");
				return false;
			}
		}else if("反馈整改情况" == "${actcard.state}") {
			//alert("${actcard.state}");
			if(idIsNull("rectificationResult")){
				addIsNotNullStr4idParent("rectificationResult");
				return false;
			}
		}else if("关闭问题" == "${actcard.state}") {
			//alert("${actcard.state}");
			if(idIsNull("closerReport")){
				addIsNotNullStr4idParent("closerReport");
				return false;
			}
		}else{
			//提交前将各种其他保存到不安全子分类中（actcardUnsafeEventChildId）
			var str = '';
			$("[mynode='mynode']").each(function(index,element){
				str += $(this).val()+"-"+$(this).attr("id")+","
			});
			$("#actcardUnsafeEventChildId").val(str);
			//开始
			if(idIsNull("territorialOfficeName")){
				addIsNotNullStr4idParent("territorialOfficeName");
				return false;
			}
			
		}
	}
	function readonlybyid(id){
		$("#"+id).attr("readonly","readonly");
		$("#"+id).attr("disabled","disabled");
	}
	function addIsNotNullStr4idParent(id){//在父ID中添加"必填",并且注册onfocus事件用于去除必填
		$("#"+id).off('focus').on('focus',function(){
			//alert("cancelByid");
			if($("#"+id).parent().children("label:last-child").length>0){
				$("#"+id).parent().children("label:last-child").remove();
			}
			});
		if(!($("#"+id).parent().children("label:last-child").length>0)){
			$("#"+id).parent().append('<label class="error" for="reportingTime">必填信息</label>');
		}
	}
	
	function idIsNull(id){//判断ID是否为null
		return ("" == $("#"+id).val() || null ==  $("#"+id).val() ||  undefined == $("#"+id).val());
	}
	function hidegpdiv4id(id){//通过ID隐藏div
		$("#"+id).parent().parent().hide();
	}
	function addpxing(id){
		$("#"+id).parent().parent().append('<span class="help-inline"><font color="red">*</font></span>');
	} 
	function addxing(id){
		$("#"+id).parent().append('<span class="help-inline"><font color="red">*</font></span>');
	} 
	</script>
</body>
</html>