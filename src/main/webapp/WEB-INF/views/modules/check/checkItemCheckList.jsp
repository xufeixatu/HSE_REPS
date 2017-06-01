<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查项检查管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        function changeSelect(checkResult, checkId) {
        	if(checkResult == '0'){
	        	 top.$.jBox.open('iframe:${ctx}/check/question/form?checkItemCheckId='+checkId,'上报问题',$(top.document).width()-220, $(top.document).height()-100,
	        	 {
	        	 	buttons:false,
					loaded:function(h) {
						$(".jbox-content", top.document).css("overflow-y","hidden");
						$("body", h.find("iframe").contents()).css("margin","10px");
					}
				});
        	}
        	$.post('${ctx}/check/checkItemCheck/save', {
		    	id: checkId,
		    	checkResult: checkResult
		    }, function(data) {
		        //location.reload();
		    });
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/check/checkItemCheck/">检查项检查</a></li>
		<shiro:hasPermission name="check:checkItemCheck:edit"><li><a href="${ctx}/check/checkItemCheck/form">检查项检查</a></li></shiro:hasPermission>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>检查内容</th>
				<th>是否符合标准</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="checkItemCheck">
			<tr>
				<td width="80%">
					${checkItemCheck.checkContent}
				</td>
				<td width="20%" align="center">
					<c:choose>
						<c:when test="${checkItemCheck.checkResult ne '-1'}">
							${fns:getDictLabel(checkItemCheck.checkResult, 'yes_no', '')}
						</c:when>
						<c:otherwise>
		 					<form:select path="checkItemCheck.checkResult" onchange="changeSelect(this.value,'${checkItemCheck.id}')" class="input-medium">
								<form:option value="-1">请选择</form:option>
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>						
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<%-- 	<form:form id="searchForm" modelAttribute="checkItemCheck" action="${ctx}/check/checkItemCheck/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/></li>
			<li class="btns"><input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></li>
		</ul>
	</form:form>	 --%>
</body>
</html>