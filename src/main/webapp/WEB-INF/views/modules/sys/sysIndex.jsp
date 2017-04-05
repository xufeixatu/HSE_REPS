<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<!-- Mirrored from www.zi-han.net/theme/hplus/ by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:16:41 GMT -->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

	<link rel="shortcut icon" href="favicon.ico">
    <link href="${ctxStatic}/hplus/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${ctxStatic}/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${ctxStatic}/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${ctxStatic}/hplus/css/style.min862f.css?v=4.1.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
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
                    <li>
                        <a href="#">
                            <i class="fa fa-home"></i>
                            <span class="nav-label">我的面板</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="#">个人信息<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/sys/user/info">个人信息</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/sys/user/modifyPwd">修改密码</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a class="J_menuItem" href="/HSE/a/../static/ckfinder/ckfinder.html">文件管理</a>
                            </li>
                        </ul>

                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa fa-bar-chart-o"></i>
                            <span class="nav-label">在线办公</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a  href="#">我的通告<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/oa/oaNotify/self">我的通告</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/oa/oaNotify">通知公告</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a  href="#">个人办公<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/act/task/todo/">我的任务</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/oa/testAudit">审批测试</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a  href="graph_morris.html">流程管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/act/process">流程管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/act/model">模型管理</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    
					<li>
                        <a href="#">
                            <i class="fa fa fa-bar-chart-o"></i>
                            <span class="nav-label">内容管理</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li>
                            	<a  href="#">内容管理<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/cms/">内容发布</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/cms/comment/?status=2">评论管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/cms/guestbook/?status=2">公共留言</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a  href="#">统计分析<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/cms/stats/article">信息量统计</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a  href="#">栏目设置<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/cms/category/">栏目管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/cms/site/">站点设置</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/cms/site/select">切换站点</a>
                                    </li>
                                </ul>
                            </li>
                         </ul>
					</li>
                    <li>
                        <a href="#"><i class="fa fa-envelope"></i> <span class="nav-label">系统设置</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                            	<a  href="#">机构用户<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/sys/user/index">用户管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/sys/office/">机构管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/sys/area/">区域管理</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                            	<a  href="#">系统设置<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/sys/menu/">菜单管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/sys/role/">角色管理</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/sys/dict/">字典管理</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                            	<a  href="#">日志查询<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/sys/log">日志查询</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/../druid">连接池监视</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-edit"></i> <span class="nav-label">代码生成</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="#">代码生成<span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/gen/genTable">业务表配置</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/gen/genScheme">生成方案配置</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">生成示例 <span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li><a class="J_menuItem" href="/HSE/a/test/testData">单表</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/test/testDataMain">主子表</a>
                                    </li>
                                    <li><a class="J_menuItem" href="/HSE/a/test/testTree">树结构</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
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
                        <!-- 
                        <li class="hidden-xs">
                            <a href="index_v1.html" class="J_menuItem" data-index="0"><i class="fa fa-cart-arrow-down"></i> 购买</a>
                        </li>
                        <li class="dropdown hidden-xs">
                            <a class="right-sidebar-toggle" aria-expanded="false">
                                <i class="fa fa-tasks"></i> 主题
                            </a>
                        </li>
                         -->
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
                <iframe id="mainFrame" class="J_iframe" name="mainFrame" width="100%" height="100%" src="" frameborder="0"  seamless></iframe>
            </div>
            <div class="footer">
                <div class="pull-right">&copy; 2014-2015 <a href="http://www.zi-han.net/" target="_blank">zihan's blog</a>
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
</body>

</html>
