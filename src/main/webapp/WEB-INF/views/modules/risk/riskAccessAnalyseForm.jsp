<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分析</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/risk/riskAccess/form?id=${riskAccess.id}">健康安全危害分析<shiro:hasPermission name="risk:riskAccess:edit">${not empty riskAccess.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="risk:riskAccess:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<sys:message content="${message}"/>	
	<form:form id="inputForm" modelAttribute="riskAccess" action="${ctx}/risk/riskAccess/report" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input  type="hidden"  name="riskType"  value="2" />	
		<div class="control-group">
			<label class="control-label">场所、设备：</label>
			<div class="controls">
				<form:input path="placeDevice" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">安全风险名称：</label>
			<div class="controls">
				<form:input path="riskName" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">作业活动名称：</label>
			<div class="controls">
				<form:input path="workName" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div> 
		<div class="control-group">
			<label class="control-label">危险源：</label>
			<div class="controls">
				<form:input path="riskFactors" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">时态：</label>
			<div class="controls">
				<form:radiobuttons path="tense" items="${fns:getDictList('risk_tense_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('risk_status_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">可能导致的后果：</label>
			<div class="controls">
				<form:textarea path="result" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
	          <div class="control-group">
			<label class="control-label">是非判断：</label>
			<div class="controls">
				<form:radiobuttons path="judgeTf" items="${fns:getDictList('risk_is_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
	        </div>
	        
		<div class="control-group">
			<label class="control-label">评价方法：</label>
			<div class="controls">
				<form:radiobuttons path="accessMothed" items="${fns:getDictList('risk_access_mothed')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>

	    <script>
	        $(function () {
	            $("#lec").show();
	            $(".controls span").click(function () {
	    if($(this).index()==1){
	    	$("#lec").hide();
	    	$("#ms").show();
	    }
	    if($(this).index()==0){
	    	$("#ms").hide();
	    	$("#lec").show();
	    }
	    	
	            })
	        })
	    </script>

		<!-- 	lec法则  开始-->
	<div id="lec" class="control-group"  hidden="hidden"  >
			<table style="width: 500px;" class="table  table-striped table-hover table-bordered">				
				<thead class="controls">
					<tr>
						<th>	<label class="control-label">L(可能性)</label></th>
						<th>	<label class="control-label">E(频繁程度)</label></th>
						<th>	<label class="control-label">C(可能导致后果)</label></th>
					</tr>
				</thead>
				<tbody class="controls">
					<tr>
						<td>
							<form:select path="lscore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_lscore')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
						<td>
							<form:select path="escore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_escore')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
						<td>
							<form:select path="cscore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_cscore')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
					</tr>
	
				</tbody>
			</table>
		</div>
	<!-- 	lec法则  结束-->
	<!-- 	ms法则  开始-->
	<div id="ms" class="control-group"  hidden="hidden"  >
			<table style="width: 500px;" class="table  table-striped table-hover table-bordered">				
				<thead class="controls">
					<tr>
						<th><label class="control-label">是否有人身伤害</label></th>
						<th><label class="control-label">E(事故发生频繁程度)</label></th>
						<th><label class="control-label">M(控制措施的状态)</label></th>
						<th><label class="control-label">S(事故后果)</label></th>
					</tr>
				</thead>
				<tbody class="controls">
					<tr>
						<td>
							<form:select path="mlscore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_mlscore')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
						<td>
							<form:select path="escore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_escore')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
						<td>
							<form:select path="mscore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_mscore')}"
								itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
						<td>
							<form:select path="sscore" class="input-xlarge ">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('risk_sscore')}"
								itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</td>
					</tr>
	
				</tbody>
			</table>
		</div>
	<!-- 	ms法则  结束-->
	
	             <div >
	             
	             </div>
		<div class="control-group">
			<label class="control-label">可能导致的事故：</label>
			<div class="controls">
				<form:textarea path="affect" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">触发原因：</label>
			<div class="controls">
				<form:textarea path="reason" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="risk:riskAccess:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="报备"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>