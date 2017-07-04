<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>risk管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/risk/riskAccess/excel");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			$("#btnImportHistroy").click(function(){
				$.jBox($("#importBox2").html(), {title:"导入历史数据", buttons:{"关闭":true}, 
					bottomText:"导入历史数据，请选择年份！"});
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

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/risk/riskAccess/list?riskType=0">健康安全辨识汇总</a></li>
	</ul>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/risk/riskAccess/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/risk/riskAccess/exceltemplate">下载模板</a>
		</form>
	</div>
	<div id="importBox2" class="hide">
		<form:form id="importForm2"   modelAttribute="riskAccess"  action="${ctx}/risk/riskAccess/importHistroy" method="post" 
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入年度风险，请稍等...');"><br/>
			<input  name="riskType" type="hidden" value="0"/>
			<input id="years"  name="years"  type="text"  maxlength="20" class="input-medium Wdate" style="width:163px;"
				value=""${riskAccess.years}"
					onclick="WdatePicker({dateFmt:'yyyy'});"/>
			<input id="btnImportHistorySubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		</form:form>
	</div>
	<form:form id="searchForm" modelAttribute="riskAccess" action="${ctx}/risk/riskAccess/" method="post" class="breadcrumb form-search">
		<input  name="riskType" type="hidden" value="0"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>编号：</label>
				<form:input path="number" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>年份：</label>
				<input id="years"  name="years"  type="text"  maxlength="20" class="input-medium Wdate" style="width:163px;"
				value=""${riskAccess.years}"
					onclick="WdatePicker({dateFmt:'yyyy'});"/>
			</li>
			<li><label>属地单位：</label>
				<form:select path="unit" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>场所、设备：</label>
				<form:input path="placeDevice" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>是否重大：</label>
				<form:radiobuttons path="isHeaverisk" items="${fns:getDictList('risk_heave_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>风险等级：</label>
				<form:select path="riskLevel" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('risk_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入关键环节"/>
				<input id="btnImportHistroy" class="btn btn-primary" type="button" value="导入往年"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>年份</th>
				<th>属地单位</th>
				<th>辨识人</th>
				<th>辨识日期</th>
				<th>作业活动名称/活动、物料、产品、服务</th>
				<th>危害因素</th>
				<th>时态</th>
				<th>状态</th>
				<th>可能导致的后果</th>
				<th>是非判断</th>
				<th>风险等级</th>
				<th>是否重大风险</th>
				<shiro:hasPermission name="risk:riskAccess:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="riskAccess">
			<tr>
				<td><a href="${ctx}/risk/riskAccess/form?id=${riskAccess.id}">
					${riskAccess.years}
				</a></td>
				<td>
					${riskAccess.unit}
				</td>
				<td>
					${riskAccess.recognizeBy}
				</td>
				<td>
					<fmt:formatDate value="${riskAccess.recognizeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
	
				<td>
					${riskAccess.placeDevice}
				</td>
				<td>
					${riskAccess.riskFactors}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.tense, 'risk_tense_type', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.status, 'risk_status_type', '')}
				</td>
				<td>
					${riskAccess.result}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.judgeTf, 'risk_is_flag', '')}
				</td>

				<td>
					${fns:getDictLabel(riskAccess.riskLevel, 'risk_level', '')}
				</td>
				<td>
					${fns:getDictLabel(riskAccess.isHeaverisk, 'risk_heave_flag', '')}
				</td>
				<shiro:hasPermission name="risk:riskAccess:edit"><td>
				             <a href="${ctx}/risk/riskAccess/analyse?id=${riskAccess.id}">分析</a>
    				<a href="${ctx}/risk/riskAccess/form?id=${riskAccess.id}">修改</a>
					<a href="${ctx}/risk/riskAccess/delete?id=${riskAccess.id}" onclick="return confirmx('确认要删除该risk吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>