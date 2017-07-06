<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课件类别管理管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
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
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>

	<%
		System.out.println("hello>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	%>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/course_catalog/courseCatalog/">课件类别管理列表</a></li>
		<shiro:hasPermission name="course_catalog:courseCatalog:edit"><li><a href="${ctx}/course_catalog/courseCatalog/form">课件类别管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="courseCatalog" action="${ctx}/course_catalog/courseCatalog/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>课件类别：</label>
				<form:input path="catalogName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>课件类别名称</th>
				<th>课件类别描述</th>
				<th>排序</th>
				<shiro:hasPermission name="course_catalog:courseCatalog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/course_catalog/courseCatalog/form?id={{row.id}}">
				{{row.catalogName}}
			</a></td>
			<td>
				{{row.catalogDesc}}
			</td>
			<td>
				{{row.sort}}
			</td>
			<shiro:hasPermission name="course_catalog:courseCatalog:edit"><td>
   				<a href="${ctx}/course_catalog/courseCatalog/form?id={{row.id}}">修改</a>
				<a href="${ctx}/course_catalog/courseCatalog/delete?id={{row.id}}" onclick="return confirmx('确认要删除该课件类别管理及所有子课件类别管理吗？', this.href)">删除</a>
				<a href="${ctx}/course_catalog/courseCatalog/form?parent.id={{row.id}}">添加下级课件类别管理</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>