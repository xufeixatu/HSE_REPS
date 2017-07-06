<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训课件上传与查看管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			 var getprogressvalue = $("#progress-value").attr('value');
		     $("#progress-value").css("width",getprogressvalue+"%");
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function ArrayIndexOf(arr, element) {
	        for (var i = 0; i < arr.length; i++) { 
	           if (arr[i] == element) {
	                return i;    
	            }   
	        }   
	        return -1; 
	       }  
	     function GetTds() {
	          var tbl = document.getElementById("tblMain");
	          var tds = tbl.getElementsByTagName("td");
	             return tds;
	               }  
	     function InitEvent() {
	          var tds=GetTds();
	             for (var i = 0; i < tds.length; i++) {
	                  var td = tds[i];
	                     td.onmouseover = TdOnclick;
	                         td.style.cursor = "pointer";
	                             }  
	                          }  
	     function TdOnclick() {
	          var tds = GetTds();
	          var index = ArrayIndexOf(tds, this);   
	          for (var i = 0; i <=index; i++) {    
	          	   var td = tds[i];    
	          	   td.innerHTML = "★";
	          	   $(td).css("color","#fdec0b");
	          	}   
	          for (var j = index + 1; j < tds.length; j++) {
	               var td = tds[j];    
	               td.innerHTML = "☆";
	               $(td).css("color","#FFFFFF");
	                }  
	            } 
/*  		function decode(text){
 			text = decodeURI(text);
 			return text;
 		}
	     */
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
		.course-detail{
			height:400px;
			background-color:#3f2f6e;
			padding:1%;
		}
		.course-detail > img{
			width:46%;
			height:96%;
			display:inline-block;
			float:left;
			margin-left: 5px;
			margin-top: 10px;
			margin-bottom: 20px;
		}
		.course-detail-text{
			width:46%;
			height:98%;
			position:relative;
			float:right;
		}
		.course-detail-text > .course-detail-text-title{
			width:100%;
			color:#FFFFFF;
			font-size:36px;
			display:block;
			margin-top:40px;
		}
		
		.course-detail-text-progress{
			width:100%;
			background-color:#cccccc;
			height:5px;
		}
		.course-detail-text-progress-bar{
			width:50%;
			height:100%;
			background-color:#eead4f;
		}
		.course-detail-text-status{
			margin-top:60px;
			width:100%;
			height:100px;
			background-color:#514375;
			
		}
		.course-detail-text-status-study-number,.course-detail-text-status-study-text,
		.course-detail-text-status-time-number,.course-detail-text-status-time-text{
			color:#FFFFFF;
		}
		.course-detail-text-status-time{
			width:40%;
			height:100%;
			float:left;
		}
		.course-detail-text-status-study{
			width:60%;
			height:100%;
			float:right;
		}
		.course-detail-text-status-time-number{
			display:block;
			text-align:center;
			border-right:1px solid #999999;
			margin-top:16%;
		}
		.course-detail-text-status-time-text{
			display:block;
			text-align:center;
			border-right:1px solid #999999;
		}
		.course-detail-text-status-study-number{
			display:block;
			text-align:center;
			margin-top:16%;
		}
		.course-detail-text-status-study-text{
			display:block;
			text-align:center;
		}
		.course-detail-text-progress-bar-text{
			display:block;
			width:100%;
			color:#FFFFFF;
			text-align:center;
		}
		.course-detail-text-operate{
			position:absolute;
			bottom:0px;
			width:100%; 
		}
		.course-detail-text-operate > ul{
			list-style:none;
			margin:0px;
			padding:0px;
			width:100%;
			height: 83px;
		}
		.course-detail-text-operate > ul li{
			float:left;
		}
		.course-detail-text-operate > ul li.continue{
			width:40%;
			height:50px;
		}
		.course-detail-text-operate > ul li.continue a{
			display:block;
			width:100%;
			height: 111%;
			line-height:300%;
			font-size: 20px;
    		letter-spacing: 5px;
		}
 		.course-detail-text-operate > ul li.focus{
		    width: 13%;
		    height: 111%;
		    padding: 4px 13px;
		    line-height: 42px;
		    margin-left: 47px;
		    margin-top: 6px;
		} 
		.course-detail-text-operate > ul li.recommend{
			padding:4px 13px;
			height: 111%;
		}
 		.course-detail-text-operate > ul li.focus a, 
		.course-detail-text-operate > ul li.recommend a{
			text-align:center;
			color:#FFFFFF;
			font-size:16px;
		}
		#tblMain{
			font-size: 32px;
			line-height: 48px;
		}
		#tblMain tr td{
			color:#FFFFFF;
		}
		
		.course-description{
			padding:20px;
			background-color:#FFFFFF;
		}
		#introduce > ul{
			margin-left:0;
			padding-bottom:20px;
		}
		
		#introduce > ul > li{
			font-size:24px;
			font-weight:bolder;
			margin-top:20px;
			color:#000000;
			line-height:24px;
		}
		#introduce > ul > li >ul li{
			font-size:12px;
			font-weight:400;
			padding:5px;
			color:#666666;
		}
		#introduce > ul > li >ol li{
			font-size:12px;
			font-weight:400;
			padding:5px;
			padding-left:10px;
			color:#666666;
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
			display:inline-block;
			font-size:12px;
			color:#999999;
			width:10%;
		}
		.chapetr-item{
			display:inline-block;
			font-size:12px;
			color:#333333;
			font-weight:bolder;
			width:50%;
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
</head>
<body class="wrapper">
	<ol class="breadcrumb">
	    <li><a href="#">培训管理</a></li>
	    <li>>></li>
	    <li class="active">查看课件</li>
	</ol>
	
	<div class="course-detail">
		<img alt="封面" src="http://localhost:8080/${trainCourse.coverId}">
		<div class="course-detail-text">
			<span class="course-detail-text-title">${trainCourse.courseName}</span>
			<div class="course-detail-text-status">
				<div class="course-detail-text-status-time">
					<span class="course-detail-text-status-time-number">${trainCourse.courseTime}</span>
					<span class="course-detail-text-status-time-text">总课时</span>
				</div>
				<div class="course-detail-text-status-study">
					<span class="course-detail-text-status-study-number">${trainCourse.courseCount}</span>
					<span class="course-detail-text-status-study-text">学习人数</span>
				</div>
			</div>
			<div class="course-detail-text-progress">
			    <div class="course-detail-text-progress-bar" role="progressbar" id="progress-value" value="40"></div>
			    <span class="course-detail-text-progress-bar-text">40% 完成</span>
			</div>
			<div class="course-detail-text-operate">
				<ul>
					<li class="continue">
						<a href="${ctx}/train_course/trainCourse3/list?id=${trainCourse.id}"   class="btn btn-success">继续学习</a>
					</li>
					<li class="focus">
						<a>星级评分</a>
					</li>
					<li class="star" onmouseover="InitEvent()">
						<table id="tblMain"><tr><td>☆</td><td>☆</td><td>☆</td><td>☆</td><td>☆</td></tr>
	    				</table>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="course-description">
		<ul id="myTab" class="nav nav-tabs">
		    <li class="active">
		        <a href="#introduce" data-toggle="tab">
		                                         课程介绍
		        </a>
		    </li>
		    <li>
		    	<a href="#chapter" data-toggle="tab">
					课程目录
				</a>
			</li>
		</ul>
		<div id="myTabContent" class="tab-content">
		    <div class="tab-pane fade in active" id="introduce">
		        <ul>
		        	<li>【学习目标】
		        		<ul>
		        			<li>${trainCourse.courseDec}</li>
		        		</ul>
		        	</li>
		        	<li>【课程大纲】
		        		<ol>
				        	<c:set var="testString" value="${trainCourse.docId}"/>
							
							<c:forTokens items="${testString}" delims="|" var="videoHref">
								<li>
									<!-- 字符串截取获取最后的文件名，并显示 -->
									<c:set var="videoHrefString" value="${videoHref}"/>			
																		
									<c:set var="videoId" value="${fn:split(videoHrefString, '/')}" />
									<c:forEach items="${videoId}" var="videoName" begin="8" >
									
<!-- 									<script type="text/javascript">

										/* videoName = decodeURI(videoName); */
										
									</script> -->
									${videoName}
<%--  									<%=java.net.URLDecoder.decode("%E7%9F%A5%E8%AF%86%E5%B0%B1%E6%98%AF%E5%8A%9B%E9%87%8F.mp4","UTF-8")%>
									<%=java.net.URLDecoder.decode("videoName","UTF-8")%> --%>
									</c:forEach>								
								</li>
							</c:forTokens>				        		
		        		</ol>
		        	</li>
		        </ul>
		    </div>
		    <div class="tab-pane fade" id="chapter">
		        <ul>		        
					<c:set var="testString" value="${trainCourse.docId}"/>
							
					<c:forTokens items="${testString}" delims="|" var="videoHref">
						<li>
							<span class="chapter-time">05:20</span>
							<span class="chapetr-item">
							<!-- 这里是视频跳转的位置，如果需要使用插件来进行播放，请修改href的跳转位置。 -->
							<a href="${ctx}/train_course/trainCourse3/list?id=${trainCourse.id}">
							
									<!-- 字符串截取获取最后的文件名，并显示 -->
									<c:set var="videoHrefString" value="${videoHref}"/>													
									<c:set var="videoId" value="${fn:split(videoHrefString, '/')}" />
									<c:forEach items="${videoId}" var="videoName" begin="8" >
										${videoName}
									</c:forEach>
								</a>
							</span>
							<span class="chapter-circle-finish"></span>
						</li>
					</c:forTokens>			
		        </ul>
		    </div>
		</div>
	</div>
	<div class="pagination">${page}</div>
</body>
</html>