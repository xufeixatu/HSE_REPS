<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训课件上传与查看管理</title>
	<meta name="decorator" content="default"/>

	<style type="text/css"> 
			*{margin:0;padding:0;list-style-type:none;}
			body{color:#666;font:12px/1.5 Arial;}
			/* star */
			#star{position:relative;width:600px;margin:20px auto;height:24px;color:#FFFFFF;top:20px}
			#star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
			#star ul{margin:0 10px;}
			#star li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(http://localhost:8080/HSE/images/star.png) no-repeat;}
			#star strong{color:#f60;padding-left:10px;}
			#star li.on{background-position:0 -28px;}
			#star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(http://localhost:8080/HSE/images//icon.gif) no-repeat;padding:7px 10px 0;}
			#star p em{color:#f60;display:block;font-style:normal;}
			</style>

	
	<script type="text/javascript">
	
	
	  window.onload = function (){
		var oStar = document.getElementById("star");
		var aLi = oStar.getElementsByTagName("li");
		var oUl = oStar.getElementsByTagName("ul")[0];
		var oSpan = oStar.getElementsByTagName("span")[0];
		var oP = oStar.getElementsByTagName("p")[0];
		var i = iScore = iStar = 0;

		for (i = 1; i <= aLi.length; i++){
			aLi[i - 1].index = i;
			
			//鼠标移过显示分数
			aLi[i - 1].onmouseover = function (){
				fnPoint(this.index);
				//浮动层显示
				oP.style.display = "block";
				//计算浮动层位置
				oP.style.left = oUl.offsetLeft + this.index * this.offsetWidth - 104 + "px";
				//匹配浮动层文字内容
				oP.innerHTML = "<em><b>" + this.index + "</b> 分 "
			};
			
			//鼠标离开后恢复上次评分
			aLi[i - 1].onmouseout = function (){
				fnPoint();
				//关闭浮动层
				oP.style.display = "none"
			};
			
			//点击后进行评分处理
			aLi[i - 1].onclick = function (){
				iStar = this.index;
				oP.style.display = "none";
				oSpan.innerHTML = "<strong>" + (this.index) + "</strong> 分 ";
			/* 	//打分之前刷新
				$("strong").html(""); */
				//获取请求参数
				var str = $("strong").text();
				//alert(str);
				//发送ajax请求
				 $.ajax({
		             type: "post",
		             url: "${ctx}/course_study/courseStudy/setGrade",
		             data: {"id":"${courseStudy.id}", "grade":str},
		             dataType: "html",
		         
		             success: function(data){
		                  alert(data);	
		                         
		                      },
		             error:function(){
		            	 alert("打分失败");
		             }
		             
		         });
			}
		}
		
		//评分处理
		function fnPoint(iArg){
			//分数赋值
			iScore = iArg || iStar;
			for (i = 0; i < aLi.length; i++) aLi[i].className = i < iScore ? "on" : "";	
		}
		
	};

	
		$(document).ready(function() {
			 var getprogressvalue = $("#progress-value").attr('value');
		     $("#progress-value").css("width",getprogressvalue+"%");
		});
		function page(n,s){
			$("#pageNo").val(n);0
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function ArrayIndexOf(arr, element) {
	        for (var i = 0; i < arr.length; i++) { 
	           if (arr[i] == element) {
	                return i;    
	            }   0.
	            
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
 		} */
	     
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
		/* 评论 */
		.media{
			 -moz-border-radius: 15px;   
			  -webkit-border-radius: 15px;
			  border-radius:15px;
		}
		.hd{
		    padding-left:11px;
			font-size: 15px;
    		font-weight: bold;
    		position: absolute;
            padding-top: 8px;
		}
		.cmt-post{
			border-bottom: 1px solid #d9dde1;
			height: 120px;
            padding-top: 9px;
		}
		 .clearfix{
		    color: #93999f;
		    font-size: 12px;
		     margin-top: 13px;
   			 padding-left: 42px;
		}
		#btnSubmit{
			position: absolute;
		    margin: 60px 33px;
		    width: 100px;
		    border-radius: 10px;			
		}
	</style>
</head>
<body class="wrapper">
	<ol class="breadcrumb">
	    <li><a href="#">培训管理</a></li>
	    <li>>></li>
	    <li class="active">查看课件</li>
	</ol>
	
	<!-- 图片 -->
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
<!-- <<<<<<< HEAD -->
					<div id="star">
						<ul>
							<li><a href="javascript:;">1</a><>
							<li><a href="javascript:;">2</a><>
							<li><a href="javascript:;">3</a><>
							<li><a href="javascript:;">4</a><>
							<li><a href="javascript:;">5</a><>
						</ul>
						<span></span>
						<p></p>
					</div>
				</ul>
			</div>
		</div>
	</div>
    <!--    中间部分 -->	
   <div class="course-description">
		<ul id="myTab" class="nav nav-tabs">
		    <li class="active">
		        <a href="#introduce" data-toggle="tab">课程介绍</a>
		    </li>
		    <li><a href="#chapter" data-toggle="tab">课程目录</a></li>
			<li><a href="#appraise" data-toggle="tab" >课程评价</a></li>
		</ul>
		
		<div id="myTabContent" class="tab-content">
		    <div class="tab-pane fade in active" id="introduce">
		        <ul>
		        	<li>【学习目标】
		        		<ul><li>${trainCourse.courseDec}</li></ul>
		        	</li>
		        	<li>【课程大纲】
		       	     <%--    	<c:forEach items="${trainCourse.attachName}" var="videoName">
		       	        		${videoName}
		       	        	</c:forEach> --%>
<%-- 		    这里是之前最开始使用的采用截取上传文件名的部分用来显示的代码，现在更改为可以为视频文件设置文件名，所以这段代码删除    
						<ol>
				        	<c:set var="testString" value="${trainCourse.docId}"/>
							
							<c:forTokens items="${testString}" delims="|" var="videoHref">
								<li>
									<!-- 字符串截取获取最后的文件名，并显示 -->
									<c:set var="videoHrefString" value="${videoHref}"/>			
																		
									<c:set var="videoId" value="${fn:split(videoHrefString, '/')}" />
									<c:forEach items="${videoId}" var="videoName" begin="8" >
										<c:out value="${tools:urlDecode(videoName)}"></c:out>
									</c:forEach>								
								</li>
							</c:forTokens>				        		
		        		</ol>--%> 
		        	</li>
		    	</ul>
		    </div>
		    
		  <div class="tab-pane fade" id="chapter">
		  	<ul>		        
				<c:set var="testString" value="${trainCourse.docId}"/>
							
				<c:forTokens items="${testString}" delims="|" var="videoHref">
					<li>
						<span class="chapter-time">5:20</span>
						<span class="chapetr-item">
							<!-- 这里是视频跳转的位置，如果需要使用插件来进行播放，请修改href的跳转位置。 -->
							<a href="${ctx}/train_course/trainCourse3/list?id=${trainCourse.id}">
								
										<!-- 字符串截取获取最后的文件名，并显示 -->
										<c:set var="videoHrefString" value="${videoHref}"/>													
										<c:set var="videoId" value="${fn:split(videoHrefString, '/')}" />
										<c:forEach items="${videoId}" var="videoName" begin="8" >
											<c:out value="${tools:urlDecode(videoName)}"></c:out>
										</c:forEach>
							</a>
						</span>
						<span class="chapter-circle-finish"></span>
						</li>
				</c:forTokens>			
		       </ul>
		   </div>
		    		
		  <!--   评价 -->

		<%--   <div>${courseReview.courseId}</div> --%>
		  	<div class="tab-pane fade course_review" id="appraise">
		  	<form:form id="inputForm" modelAttribute="courseReview"
				action="${ctx}/course_review/courseReview/save1" method="post"
				class="form-horizontal">
		 	<%-- <input name="courseId" value="${courseReview.courseId}" /> --%>
		 	<form:hidden path="courseId"  value="${courseReview.courseId}"/>
			<form:hidden path="id"/>
			<sys:message content="${message}" />
			<div class="control-group">
				<span> <form:textarea
						path="assessOpinion" htmlEscape="false" rows="4" maxlength="255"
						class="input-xxlarge " />
				</span> 
				<div hidden="hidden" class="control-group">
				<label class="control-label">评论人：</label>
				<div class="controls">
					<form:input path="assessById" htmlEscape="false" maxlength="64" class="input-xlarge required" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
				<div hidden="hidden" class="control-group">
				<label class="control-label">评论时间：</label>
				<div class="controls">
					<input name="assessTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${courseReview.assessTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
						
				<span> <shiro:hasPermission
					name="course_review:courseReview:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit"
						value="发表" />&nbsp;</shiro:hasPermission>
				</span>
			</div>
		 </form:form>
		<sys:message content="${message}" />
		  	
		  	
		  	  <div class="cmt-wrap">
                 <ul class="cmt-list">
                 	<c:forEach items="${page1.list}" var="courseReview">
                    <li class="cmt-post" >
                      <c:if test="courseReview.courseId=="></c:if>
    				<div class="inner">
	    			  	<div class="media"  style="display:inline;">
	                   <a href="/u/1968386/courses" target="_blank"><img src="http://img.mukewang.com/555869eb0001716101800180-40-40.jpg" width="32" height="32" style="border-radius:37px 37px;"></a>
        			    </div>
    				
    					<div class="hd" style="display:inline">
                          <a href="javascript:void();" class="name disabled">${courseReview.assessById}</a>
    					</div>
    					<p class="cmt-txt" style="padding: 5px 41px;padding-top: 16px;">${courseReview.assessOpinion}</p>
    					<div class="ft clearfix">
						<span><fmt:formatDate value="${courseReview.assessTime}"
								pattern="yyyy-MM-dd HH:mm:ss" /></span>
						   </div>
						</div>
    		    	</li>
    		    	</c:forEach>
		  	    </ul>
		  	</div>	  			 
     	</div>
		</div>	
	</div>
	 <div class="pagination">${page}</div>
</body>
</html>

