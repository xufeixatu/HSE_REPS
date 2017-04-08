<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

	<link rel="shortcut icon" href="favicon.ico">
    <link href="${ctxStatic}/hplus/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${ctxStatic}/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${ctxStatic}/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${ctxStatic}/hplus/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <style>
    	body{
    		background-color: white;
    	}
    </style>
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
	<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
	
		<c:if test="${empty menu.href}">
			<input type="hidden" name="nume_no_href" nemuhref="${ctx}/sys/menu/tree?parentId=${menu.id}" menuname="${menu.name}"/>
		</c:if>
		<c:if test="${not empty menu.href}">
			<input type="hidden" name="nume_href" nemuhref="${ctx}/${menu.href}" menuname="${menu.name}"/>
		</c:if>
	
	<c:if test="${firstMenu}">
		<c:set var="firstMenuId" value="${menu.id}"/>
	</c:if>
	<c:set var="firstMenu" value="false"/>
	</c:if>
</c:forEach>

    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i></div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" src="${ctxStatic}/hplus/img/profile_small.jpg" /></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                	<span class="block m-t-xs"><strong class="font-bold">${fns:getUser().name}</strong></span>
                                	<span class="text-muted text-xs block">超级管理员<b class="caret"></b></span>
                                </span>
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a class="J_menuItem" href="/HSE/a/sys/user/info">个人资料</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="${ctx}/logout">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <div class="logo-element">
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                        <form role="search" class="navbar-form-custom" method="post" action="http://www.zi-han.net/theme/hplus/search_results.html">
                            <div class="form-group">
                                <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                            </div>
                        </form>
                    </div>
                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-envelope"></i> <!-- <span class="label label-warning">16</span> -->
                            </a>
                            <ul class="dropdown-menu dropdown-messages">
                                <li class="m-t-xs">
                                    <div class="dropdown-messages-box">
                                        <a href="profile.html" class="pull-left">
                                            <img alt="image" class="img-circle" src="img/a7.jpg">
                                        </a>
                                        <div class="media-body">
                                            <small class="pull-right">46小时前</small>
                                            <strong>小四</strong> 这个在日本投降书上签字的军官，建国后一定是个不小的干部吧？
                                            <br>
                                            <small class="text-muted">3天前 2014.11.8</small>
                                        </div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="dropdown-messages-box">
                                        <a href="profile.html" class="pull-left">
                                            <img alt="image" class="img-circle" src="img/a4.jpg">
                                        </a>
                                        <div class="media-body ">
                                            <small class="pull-right text-navy">25小时前</small>
                                            <strong>国民岳父</strong> 如何看待“男子不满自己爱犬被称为狗，刺伤路人”？——这人比犬还凶
                                            <br>
                                            <small class="text-muted">昨天</small>
                                        </div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem" href="mailbox.html">
                                            <i class="fa fa-envelope"></i> <strong> 查看所有消息</strong>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i>
                                <!--  <span class="label label-primary">8</span>  -->
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                    <a href="mailbox.html">
                                        <div>
                                            <i class="fa fa-envelope fa-fw"></i> 您有16条未读消息
                                            <span class="pull-right text-muted small">4分钟前</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="profile.html">
                                        <div>
                                            <i class="fa fa-qq fa-fw"></i> 3条新回复
                                            <span class="pull-right text-muted small">12分钟钱</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem" href="notifications.html">
                                            <strong>查看所有 </strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="index_v1.html">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="login.html" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe id="mainFrame" class="J_iframe" name="mainFrame" width="100%" height="100%" src="/HSE/empty.jsp" frameborder="0"  seamless></iframe>
            </div>
            <div class="footer">
                <div class="pull-right">Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')}

                </div>
            </div>
        </div>
        <!--右侧部分结束-->
    </div>
    <script src="${ctxStatic}/hplus/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctxStatic}/hplus/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${ctxStatic}/hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="${ctxStatic}/hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="${ctxStatic}/hplus/js/plugins/layer/layer.min.js"></script>
    <script src="${ctxStatic}/hplus/js/hplus.min.js?v=4.1.0"></script>
    <script src="${ctxStatic}/hplus/js/contabs.min.js"></script>
    <script src="${ctxStatic}/hplus/js/plugins/pace/pace.min.js"></script>
    <script src="${ctxStatic}/createMenu/createmenu.js"></script>
    <script>
    /*
	 * 获取一级菜单数据
	 */
	
		var menunohref = $("input[name='nume_no_href']");
		var menunohreflist = [];
		for(var i=0;i<menunohref.length;i++){
			var menu = [];
			var href = $(menunohref[i]).attr("nemuhref");
			var name = $(menunohref[i]).attr("menuname");
			menu['href'] = href;
			menu['name'] = name;
			menunohreflist[i]=menu;
		}
		var menuhref = $("input[name='nume_href']");
		var menuhreflist = [];
		for(var i=0;i<menuhref.length;i++){
			var menu = [];
			var href = $(menuhref[i]).attr("menuhref");
			var name = $(menuhref[i]).attr("menuname");
			menu['href'] = href;
			menu['name'] = name;
			menuhreflist[i] = menu;
		}

	headlist = [];
	innerlist = [];
	
	for(var i=0;i<menunohreflist.length;i++){
		$.ajax({
	        type:'GET',
	        url:menunohreflist[i].href,
	        async:false,
	        success:function(data){
	        	heading = $(data).find(".accordion-heading");
				headtext = [];
				for(var j=0;j<heading.length;j++){
					var text = $(heading[j]).find("a").text();
					headtext[j] = text;
				}
				
				headlist[i] = headtext;
				
				inner = $(data).find(".accordion-inner");
				innertext = [];
				for(var j=0;j<inner.length;j++){ 
					var innera = $(inner[j]).find("a");
					var tmp = [];
					for(var k=0;k<innera.length;k++){
						var text = $(innera[k]).text();
						var href = $(innera[k]).attr("href");
						tmp[k] = new Array();
						tmp[k]["name"]= text;
						tmp[k]["href"]= href;
					}
					innertext[j] = tmp;
					tmp = new Array();
				}
				innerlist[i] = innertext;
	        }
		});
	}

	var rootul = $("#side-menu");
	for(var i=0;i<innerlist.length;i++){
		if(innerlist[i].length > 0){
			var type = 1;
		}else{
			var type = 0;
		}
		var li = createFirstMenu(rootul,menunohreflist[i]['name'],type);
		var ul_second = $("<ul></ul>").attr("class","nav nav-second-level");
		
		for(var j=0;j<headlist[i].length;j++){
			var li_second = createSecondMenu(li,ul_second,headlist[i][j]);
			var ul_third = $("<ul></ul>").attr("class","nav nav-third-level");
			
			for(var k=0;k<innerlist[i][j].length;k++){
				createThirdMenu(li_second,ul_third,innerlist[i][j][k]['href'],innerlist[i][j][k]['name']);
			}
		}
	}
	
	/*
	生成一级菜单
	*/
	function createFirstMenu(parentul,name,type){
		var span1 = $("<span></span>").attr("class","nav-label").text(name);
		var a = $("<a></a>").attr("href","#").append(span1);
		if(type == 1){
			var span2 = $("<span></span>").attr("class","fa arrow");
			a.append(span2);
		}
		
		var li = $("<li></li>").append(a);
		parentul.append(li);
		return li;
	}
	
	/*
	生成二级菜单
	*/
	function createSecondMenu(parentli,ul_second,name){
		var ul_second_span = $("<span></span>").attr("class","fa arrow");
		var ul_second_a = $("<a></a>").text(name).attr("href","#").append(ul_second_span);
		var ul_second_li = $("<li></li>").append(ul_second_a);
		ul_second.append(ul_second_li);
		parentli.append(ul_second);
		return ul_second_li;
	}
	
	/*
	生成三级菜单
	*/
	function createThirdMenu(parentli,ul_third,href,name){
		var ul_third_li_a = $("<a></a>").attr({"class":"J_menuItem","href":href}).text(name);
		var ul_third_li = $("<li></li>").append(ul_third_li_a);
		ul_third.append(ul_third_li);
		parentli.append(ul_third);
	}
	
	</script>
	
</body>

</html>
