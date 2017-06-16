<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

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
			$("a,input[type='checkbox'],span[arrow='true']").bind("click", function(event){event.stopPropagation();});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row,
						edit:function(){
							return row.workStateId != '45d756f45bb04155adb95e66b6a0d1c1' && 
								   row.workStateId != '0374ed53f5034055943e0381aca4c22a';
						},
						no_edit:function(){
							return row.workStateId == '45d756f45bb04155adb95e66b6a0d1c1' || 
								   row.workStateId == '0374ed53f5034055943e0381aca4c22a';
						},
						pass:function(){
							return row.workStateId == '0374ed53f5034055943e0381aca4c22a' && 
							 	   row.endStateId == null;
						},
						start_time:function(){
							return row.startTime != null && row.startTime != "";
						},
						required_finish_time:function(){
							
							return row.requiredFinishTime != null && row.requiredFinishTime != "";
						},
						frequency:function(){
							return row.frequency != null && row.frequency != "";
						},
						other:function(){
							return (row.startTime == null || row.startTime == "") &&
								   (row.requiredFinishTime == null || row.requiredFinishTime == "") &&
								   (row.frequency == null || row.frequency == "");
						},
						show_dept:function(){
							return ${workPlan.planType eq 'compnay'};
						},
						current_year:function(){
							var y = new Date().getFullYear();
							return y + "-" + "12-31 23:59:59";
						}
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		//选择或取消所有选项
		function selectAll(me){
			var ids = $("input[name='ids']");
			for(var i = 0 ; i < ids.length ; i++){
				ids[i].checked = me.checked;
			}
		}
		//批量提交
		function submitAll(me){
			var ids = $("input[name='ids']");
			var str = "";
			for(var i = 0 ; i < ids.length ; i++){
				if(ids[i].checked){
					str += "&ids=" + ids[i].value;
				}
			}
			me.href += str;
			return confirmx('确认要提交该工作计划吗？', me.href);
		}
		//显示隐藏详细行
		function expandDetail(id){
			var o = $('#ex_' + id);
			var s = $('#s_' + id);
			if(o.attr('style') == "display:none"){
				o.attr('style','display:block');
				s.attr('src','/HSE/static/images/open.jpg');
			}else{
				o.attr('style','display:none');
				s.attr('src','/HSE/static/images/close.jpg');
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="${ctx}/work/workPlan/?planType=${planTypeDict.value}">新增${planTypeDict.label}列表</a></li>
		<shiro:hasPermission name="work:workPlan:edit">
			<li><a
				href="${ctx}/work/workPlan/form?planType=${planTypeDict.value}">${planTypeDict.label}添加</a></li>
				<li><a
				href="${ctx}/work/workPlan/form?planType=${planTypeDict.value}">${planTypeDict.label}行动计划</a></li>
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
			<li class="btns">
				<a href="#">下载工作计划模板</a></li>
			<li class="btns">
				<a href="#">导入工作计划EXCEL文件</a></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	
	<table id="treeTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" name="selectAll" onclick="selectAll(this);"/></th>
				<th>工作项</th>
				<th>级别</th>
				<th>时间要求</th>
				<th>状态</th>
				<c:if test="${workPlan.planType eq 'company'}">
					<th>责任单位</th>
				</c:if>
				<th>责任人</th>
				<shiro:hasPermission name="work:workPlan:edit">
					<th>操作</th>
				</shiro:hasPermission>

			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}" onclick="expandDetail('{{row.id}}')">
			<td name="first">
				<img id="s_{{row.id}}" src="/HSE/static/images/close.jpg"></img>&nbsp;&nbsp;{{#edit}}<input type="checkbox" name="ids" value="{{row.id}}"/>{{/edit}}
			</td>
			<td>{{#edit}}
					<a href="${ctx}/work/workPlan/form?id={{row.id}}&planType=${planTypeDict.value}&noedit=false">
						{{row.name}}
					</a>
				{{/edit}}
				{{#no_edit}}
					<a href="${ctx}/work/workPlan/form?id={{row.id}}&planType=${planTypeDict.value}&noedit=true">
						{{row.name}}
					</a>
				{{/no_edit}}
			</td>
			<td>
				{{row.workLevel}}
			</td>
			{{#frequency}}
			<td>
				{{row.frequency}} 月执行工作计划
			</td>
			{{/frequency}}
			{{#start_time}}
			<td>
				{{row.startTime}}
				至
				{{row.planedFinishTime}}
			</td>
			{{/start_time}}
			{{#required_finish_time}}
			<td>
				要求 {{row.requiredFinishTime}} 前完成
			</td>
			{{/required_finish_time}}
			{{#other}}
			<td>
				要求 {{current_year}} 完成
			</td>
			{{/other}}
			<td>
				{{row.workState}}
			</td>
			{{#show_dept}}
			<td>
				{{row.depts.name}}
			</td>
			{{/show_dept}}
			<td>
				{{row.personLiable.name}}
			</td>
			<shiro:hasPermission name="work:workPlan:edit"><td>
			{{#edit}}
   				<a href="${ctx}/work/workPlan/form?id={{row.id}}&planType=${planTypeDict.value}">修改</a>
				<a href="${ctx}/work/workPlan/delete?id={{row.id}}&planType=${planTypeDict.value}" onclick="return confirmx('确认要删除该工作计划及所有子工作计划吗？', this.href)">删除</a>
				<a href="${ctx}/work/workPlan/form?parent.id={{row.id}}&planType=${planTypeDict.value}">添加子工作</a> 
				<a href="${ctx}/work/workPlan/submitPlan?id={{row.id}}&planType=${planTypeDict.value}" onclick="return submitAll(this)">提交</a>				
			{{/edit}}
			{{#pass}}
				<a href="${ctx}/work/workPlan/assigned_work?id={{row.id}}&planType=${planTypeDict.value}">分配任务</a>	
			{{/pass}}
			</td></shiro:hasPermission>
			
		</tr>
		<tr id="ex_{{row.id}}" style="display:none">
			<td colspan="100">
				<a href="#" style="font-weight:900px">最新交流</a><br/>
				最新反馈消息：{{row.newFeedback}}<br/>
				单位：{{row.feebackPeopleId}} 反馈人：{{row.remain_dept_id}} 反馈时间：{{row.feedbackTime}}<br/>
				
				最新回复消息：{{row.newReply}}<br/>
				回复人：{{row.replyPeopleId}} 回复时间：{{row.replyTime}}<br/>
			</td>
		</tr>
	</script>
	
</body>
</html>