<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作类别管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, rootId = "${not empty workType.id ? workType.id : '0'}";
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							type: getDictLabel(${fns:toJson(fns:getDictList('work_workType_type'))}, row.type)
						}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/work/workType/list?id=${workType.id}&parentIds=${workType.parentIds}">工作类别列表</a></li>
		<shiro:hasPermission name="work:workType:edit"><li><a href="${ctx}/work/workType/form?parent.id=${workType.id}">工作类别添加</a></li></shiro:hasPermission>
	</ul>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>工作类别</th><th>类别描述</th><th>备注</th><shiro:hasPermission name="work:workType:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/work/workType/form?id={{row.id}}">{{row.name}}</a></td>
			<td>{{row.type_name}}</td>
			<td>{{row.type_desc}}</td>
			<td>{{row.remarks}}</td>
			<shiro:hasPermission name="work:workType:edit"><td>
				<a href="${ctx}/work/workType/form?id={{row.id}}">修改</a>
				<a href="${ctx}/work/workType/delete?id={{row.id}}" onclick="return confirmx('要删除该机构及所有子工作类型项吗？', this.href)">删除</a>
				<a href="${ctx}/work/workType/form?parent.id={{row.id}}">添加下级机构</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>