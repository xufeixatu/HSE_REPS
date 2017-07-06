<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 获取当前user对象 -->
<c:set value="${fns:getUser()}" var="user"/>
<c:set value="${fns:getOfficeById('4eb71afc7bd34163a381eb3e37d05fdc')}" var="office_quality"/>
<html>
<head>
<title>工作计划管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row,
						manager:function(){
							return true;
						}
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a
			href="${ctx}/work/workPlan/workList/?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>
		<shiro:hasPermission name="work:workPlan:edit">
			<li><a
					href="${ctx}/work/workPlan2/dept_remain_list?planType=${planTypeDict.value}">待受理${planTypeDict.label}列表</a></li>
			<li><a
					href="${ctx}/work/workPlan2/dept_remainned_list?planType=${planTypeDict.value}">已受理${planTypeDict.label}列表</a></li>
			<li><a
					href="${ctx}/work/workPlan2/dept_clos_remainned_feedback_list?planType=${planTypeDict.value}">待关闭${planTypeDict.label}受理反馈列表</a></li>
			<li class="active"><a
					href="${ctx}/work/workPlan2/dept_closed_remain_feedback_list?planType=${planTypeDict.value}">已关闭${planTypeDict.label}受理反馈列表</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="workPlan"
		action="${ctx}/work/workPlan/" method="post"
		class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>标题：</label> <form:input path="name"
					htmlEscape="false" maxlength="100" class="input-medium" /></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="treeTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>工作项</th>
				<th>责任单位</th>
				<th>责任人</th>
				<th>工作状态</th>
				<th>结束状态</th>
				<shiro:hasPermission name="work:workPlan:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/work/workPlan/exec_form?id={{row.id}}&planType=${planTypeDict.value}&noedit=true">
					{{row.name}}
				</a>
			</td>
			<td>
				{{row.remainDeptName}}
			</td>
			<td>
				{{row.remainName}}
			</td>
			<td>
				{{row.workState}}
			</td>
			<td>
				{{row.endState}}
			</td>
			<shiro:hasPermission name="work:workPlan:edit"><td>
				{{#manager}}   				
				<a href="${ctx}/work/workPlan2/dept_workplan_comment_form?id={{row.id}}&remainId={{row.remainId}}&planType=${planTypeDict.value}">点评</a>
				{{/manager}}   
				<a href="${ctx}/work/workPlan2/dept_workplan_comment_detail?remainId={{row.remainId}}&planType=${planTypeDict.value}">【查看点评】</a>
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>