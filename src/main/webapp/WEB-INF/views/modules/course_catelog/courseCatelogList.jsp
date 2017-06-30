<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>



<html>
<head>

	<title>课件目录管理</title>
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
	</script>
	
	
	<style>
		body{
			background-color:#d7d7d7;
			padding:10px;
		}
		ul{
			list-style:none;
		}
		.breadcrumb{
			background-color:#FFFFFF;
		}
		.course-detail {
  	     background-color: #fff;
    	 padding: 1%;
    	 width:100%;
    	 height:300px;
		}
	
	
		<!--目录-->
		.course-description{
			padding:20px;
			background-color:#FFFFFF;
		}
		.course-description > p{
			    color: #5b4883;
			    font-size: 17px;
			    padding: 22px 33px;
			    font-weight: bold;
			    border-bottom: 4px solid rgba(18, 83, 119, 0.88);
			    padding-bottom: 8px;
		}
		#chapter{
			margin-top:20px;
			overflow:hidden;
		}
		#chapter ul li{
			position:relative;
			padding: 5px;
		}
		
		.chapter-circle{
			display:inline-block;
			width:10px;
			height:10px;
			border:1px solid #000000;
			border-radius:10px;
			font-size:12px;
			position:absolute;
			right:30px;
			top:5px;
		}
		.chapter-time{
			    display: inline-block;
			    font-size: 19px;
			    color: rgba(62, 57, 57, 0.97);
			    width: 13%;
		}
		.chapetr-item{
		    display: inline-block;
		    font-size: 16px;
		    color: black;
		    width: 50%;
		}	
		.chapter-circle-finish{
			display:inline-block;
			width:11px;
			height:11px;
			border:1px solid #FFFFFF;
			border-radius:11px;
			font-size:12px;
			
			position:absolute;
			right:30px;
			top:7px;
			background-color:#38bd60;
		}
		.chapter-circle-finish:before{
			content:"已完成";
			display:inline-block;
			width:100px;
			margin-left:-40px;
			color:#38bd60;
			position:absolute;
			top:-5px;
		}
				
	</style>
	<script>
	
 		//ckplayer监听时间函数 
		function loadedHandler(){
		  if(CKobject.getObjectById('ckplayer_a1').getType()){
		    CKobject.getObjectById('ckplayer_a1').addListener('play',playHandler);
		    CKobject.getObjectById('ckplayer_a1').addListener('time',timeHandler); 
		  }
		  else{
		    CKobject.getObjectById('ckplayer_a1').addListener('play','playHandler');
		     CKobject.getObjectById('ckplayer_a1').addListener('time','timeHandler'); 
		  }
		}
		
		//获取当前时间
		function timeHandler(t){
		  if(t>-1){
		    /*   CKobject._K_('nowTime').innerHTML='当前播放的时间点是(此值精确到小数点后三位，即毫秒)：'+t; */
		  }
		} 
		
		//监听当前的播放按键，并且显示当前的视频的总时长
		function playHandler(){
		      CKobject.getObjectById('ckplayer_a1').removeListener('play','playHandler');
/* 			CKobject._K_('totalTime').innerHTML='当前播放视频时长是(秒)：'+ getTotalTime(); */
			CKobject._K_('chapterTime').innerHTML=getTotalTime();
			$("#chapter-time").innerHtml=getTotalTime();
			$("#chapterTime").innerHtml=getTotalTime();
		}
		
		//通过getstatus函数来获取totaltime参数	
		function getTotalTime(){
			var a=CKobject.getObjectById('ckplayer_a1').getStatus();
			return a['totalTime'];
		}
	
	</script>
</head>

<body class="wrapper">
	<ol class="breadcrumb">
	    <li><a href="#">培训管理</a></li>
	    <li>>></li>
	    <li class="active"><a href="#">查看课件</a></li>
<!-- 	    <li>>></li>
	    <li class="active" type = "hidden" >trainCourse.courseName</li> -->
	</ol>
	<!-- 播放视频 -->
			<div id="a1"></div>		
<!-- 			<div id="nowTime"></div>
			<div id="totalTime"></div> -->
			<script type="text/javascript" src="http://localhost:8080/HSE/ckplayer/ckplayer.js" charset="utf-8"></script>
			<script type="text/javascript">
				var flashvars={
					p:0,
					e:1,
					i: 'http://www.ckplayer.com/static/images/cqdw.jpg' 
					};
				 var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always'};//这里定义播放器的其它参数如背景色（跟flashvars中的b不同），是否支持全屏，是否支持交互 
				
				 
				 //其中http://img.ksbbs.com/asset/Mon_1605/0ec8cc80112a2d6.mp4为视频地址
				 //
				// var videoName  = "http://img.ksbbs.com/asset/Mon_1605/0ec8cc80112a2d6.mp4";
				var videoName ="${courseCatelog.attachId}";
				var video=[ "http://localhost:8080" + videoName + '->video/mp4'];
				var support=['all'];
				CKobject.embedHTML5('a1','ckplayer_a1',1100,500,video,flashvars,support);				
				
			</script>
	<!-- 目录 -->
	<div class="course-description">
		<p>
			课程目录
		</p>   
	 	<div id="chapter">
	        <ul>		        
				<c:forEach items="${courseCatelogList}" var="courseCatelog" varStatus="status">	        
					<li>
						<span class="chapter-time">${status.index + 1}</span>
						<span class="chapetr-item">
							<!-- 这里是视频跳转的位置，如果需要使用插件来进行播放，请修改href的跳转位置。 -->
							<a href="${ctx}/course_catelog/courseCatelog/list?id=${courseCatelog.id}">		
								${courseCatelog.attachName}
							</a>
						</span>
						<c:set var = "study_status" value="${courseStudy.status}"/>
						<c:if test="${study_status == 1}">
							<span class="chapter-circle-finish"></span>
						</c:if>
<%--  						<c:if test="${study_status != 1}">
							<span class="chapter-circle-unfinish"></span>
						</c:if>  --%>
					</li>
				</c:forEach> 
	        </ul>
	    </div>
	</div>
</body>



<%-- <body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/course_catelog/courseCatelog/">课件目录列表</a></li>
		<shiro:hasPermission name="course_catelog:courseCatelog:edit"><li><a href="${ctx}/course_catelog/courseCatelog/form">课件目录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="courseCatelog" action="${ctx}/course_catelog/courseCatelog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>附件名称：</label>
				<form:input path="attachName" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>附件名称</th>
				<th>附件id</th>
				<shiro:hasPermission name="course_catelog:courseCatelog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="courseCatelog">
			<tr>
				<td><a href="${ctx}/course_catelog/courseCatelog/form?id=${courseCatelog.id}">
					${courseCatelog.attachName}
				</a></td>
				<td>
					${courseCatelog.attachId}
				</td>
				<shiro:hasPermission name="course_catelog:courseCatelog:edit"><td>
    				<a href="${ctx}/course_catelog/courseCatelog/form?id=${courseCatelog.id}">修改</a>
					<a href="${ctx}/course_catelog/courseCatelog/delete?id=${courseCatelog.id}" onclick="return confirmx('确认要删除该课件目录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body> --%>
</html>