<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出培训计划数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/train/plan/trainPlan/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/train/plan/trainPlan/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/train/plan/trainPlan/import/template">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/train/plan/trainPlan/">培训计划列表</a></li>
		<shiro:hasPermission name="train:plan:trainPlan:edit"><li><a href="${ctx}/train/plan/trainPlan/form">培训计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="trainPlan" action="${ctx}/train/plan/trainPlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>受训单位：</label>
				<sys:treeselect id="objectOffice" name="objectOffice.id" value="${trainPlan.objectOffice.id}" labelName="objectOffice.name" labelValue="${trainPlan.objectOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>培训分类：</label>
				<form:select path="classify" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('train_content_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>培训课题：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>培训对象：</label>
				<form:select path="trainObject" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('train_objects_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>负责单位：</label>
				<sys:treeselect id="subjectOffice" name="subjectOffice.id" value="${trainPlan.subjectOffice.id}" labelName="subjectOffice.name" labelValue="${trainPlan.subjectOffice.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>培训频率：</label>
				<form:input path="frequency" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			
			<li><label>计划状态：</label>
				<form:radiobuttons path="status" items="${fns:getDictList('train_plan_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</li>
			
			
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>受训单位</th>
				<th>培训分类</th>
				<th>培训课题</th>
				<th>培训对象分类</th>
				<th>培训时间</th>
				<th>学时</th>
				<th>拟培人数</th>
				<th>培训方式分类</th>
				<th>计划状态</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="train:plan:trainPlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="trainPlan">
			<tr>
				<td><a href="${ctx}/train/plan/trainPlan/form?id=${trainPlan.id}">
					${trainPlan.objectOffice.name}
				</a></td>
				<td>
					${fns:getDictLabel(trainPlan.classify, 'train_content_classify', '')}
				</td>
				<td>
					${trainPlan.name}
				</td>
				<td>
					${fns:getDictLabel(trainPlan.trainObject, 'train_objects_classify', '')}
				</td>
				<td>
					<fmt:formatDate value="${trainPlan.trainTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${trainPlan.period}
				</td>
				<td>
					${trainPlan.planNumber}
				</td>
				<td>
					${fns:getDictLabel(trainPlan.trainMethod, 'train_methods_classify', '')}
				</td>
				<td>
					${fns:getDictLabel(trainPlan.status, 'train_plan_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${trainPlan.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${trainPlan.remarks}
				</td>
				<shiro:hasPermission name="train:plan:trainPlan:edit"><td>
					<c:if test ="${trainPlan.status == '0'}">
						<a href="${ctx}/train/plan/trainPlan/start?id=${trainPlan.id}">启动</a>
					</c:if>
					<c:if test ="${trainPlan.status != '1'}">
    					<a href="${ctx}/train/plan/trainPlan/form?id=${trainPlan.id}">修改</a>
						<a href="${ctx}/train/plan/trainPlan/delete?id=${trainPlan.id}" onclick="return confirmx('确认要删除该培训计划吗？', this.href)">删除</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>