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
</head>
<body class="wrapper">
	<ol class="breadcrumb">
	    <li><a href="#">培训管理</a></li>
	    <li>>></li>
	    <li class="active"><a href="#">查看课件</a></li>
	    <li>>></li>
	    <li class="active">${trainCourse.courseName}</li>
	</ol>
	<!-- 播放视频 -->
	<div class="course-detail">
		<video width="1140" style="margin-top:-2px;   height: 305px;    padding-left: 12px;"  controls >
<!-- 		$('#videoArea').bind('course-detail',function() { return false; }); -->
<%-- 			<c:set var="testString" value="${trainCourse.docId}"/>
			
			<c:forTokens items="${testString}" delims="|" var="videoHref">
			
			<!-- 字符串截取获取最后的文件名，并显示 -->
			<c:set var="videoHrefString" value="${videoHref}"/>													
			<c:forEach items="${videoHrefString}" var="videoName" begin="5" > --%>
				<source src="http://localhost:8080/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4"  type="video/mp4" />
<%-- 			
			</c:forEach>
			</c:forTokens>	 --%>
		</video>
   </div> 

	<!-- 目录 -->
	<div class="course-description">
		<p>
			课程目录
		</p>   
	 	<div id="chapter">
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
</body>
</html>