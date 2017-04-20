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
			href="${ctx}/work/workPlan/workList?planType=${planTypeDict.value}">${planTypeDict.label}列表</a></li>
		<shiro:hasPermission name="work:workPlan:edit">
			<c:if test="${user.name eq office_quality.primaryPerson.name or user.name eq office_quality.deputyPerson}">
				<li><a
					href="${ctx}/work/workPlan/pending_list?planType=${planTypeDict.value}">待审核${planTypeDict.label}列表</a></li>
			</c:if>
			<li class="active"><a
					href="${ctx}/work/workPlan/remain_list?planType=${planTypeDict.value}">待受理${planTypeDict.label}列表</a></li>
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
				<th>级别</th>
				<th>频次</th>
				<th>计划完成时间</th>
				<th>责任单位</th>
				<th>责任人</th>
				<th>状态</th>
				<shiro:hasPermission name="work:workPlan:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/work/workPlan/detail?id={{row.id}}&planType=${planTypeDict.value}">
					{{row.name}}
				</a>
			</td>
			<td>
				{{row.workLevel}}
			</td>
			<td>
				{{row.frequency}}
			</td>
			<td>
				{{row.planedFinishTime}}
			</td>
			<td>
				{{row.depts.name}}
			</td>
			<td>
				{{row.personLiable.name}}
			</td>
			<td>
				{{row.workState}}
			</td>
			<shiro:hasPermission name="work:workPlan:edit"><td>
   				<a href="${ctx}/work/workPlan/remain_form?id={{row.id}}&planType=${planTypeDict.value}&currentRemainDeptId={{row.currentRemainDeptId}}">受理</a>
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>