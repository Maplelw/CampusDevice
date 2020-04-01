<%@ page import="bean.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title>校园实验设备借用系统</title>
    <!-- Bootstrap Core CSS -->
    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <!-- You can change the theme colors from here -->
    <link href="css/colors/blue.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="fix-header card-no-border">

<!-- ============================================================== -->
<!-- Main wrapper - style you can find in pages.scss -->
<!-- ============================================================== -->
<div id="main-wrapper">
    <!-- ============================================================== -->
    <!-- Topbar header - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <header class="topbar">
        <nav class="navbar top-navbar navbar-toggleable-sm navbar-light" style="height: 50px">
            <!-- ============================================================== -->
            <!-- Logo -->
            <!-- ============================================================== -->
            <div class="navbar-header">
                <p style="font-size:20px;margin-top:10px;">校园实验设备借用系统</p>
            </div>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <div class="navbar-collapse">
                <!-- ============================================================== -->
                <!-- toggle and nav items -->
                <!-- ============================================================== -->
                <ul class="navbar-nav mr-auto  m-l-20" style="margin-top:15px; margin-left: 20px">
                    <a href="findrsrv.action?page=1">
                        <button type="button" class="btn btn-circle btn-default" style="background-color: white;border:1px solid gainsboro">
                            <span class="fa fa-arrow-left" style="color: gray;font-size:18px"></span>
                        </button>
                    </a>
                </ul>
                <!-- ============================================================== -->
                <!-- User profile and search -->
                <!-- ============================================================== -->
                <ul class="navbar-nav my-lg-0">
                    <li class="nav-item row">
                        <a class="nav-link">
                            <img src="assets/images/user1.jpg" alt="user" class="profile-pic m-r-10"/>
                            <span id="userDisplay">
                                <s:set var="adm" value="#session.adm"/>
                                <s:property value="#adm.a_name"/>
                                <s:property value="#adm.a_type"/>
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- ============================================================== -->
    <!-- End Topbar header -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <aside class="left-sidebar">
        <!-- Sidebar scroll-->
        <div class="scroll-sidebar">
            <!-- Sidebar navigation-->
            <nav class="sidebar-nav">
                <ul id="sidebarnav">
                    <li>
                        <a href="PersonalData.jsp" class="waves-effect"><i class="fa fa-user m-r-10" aria-hidden="true"></i>个人资料</a>
                    </li>
                    <li>
                        <a href="returned.action?page=1" class="waves-effect"><i class="fa fa-table m-r-10" aria-hidden="true"></i>设备归还</a>
                    </li>
                    <li>
                        <a href="findrsrv.action?page=1" class="waves-effect"><i class="fa fa-envelope-open-o m-r-10" aria-hidden="true"></i>设备预约</a>
                    </li>
                    <li>
                        <a href="feedback.action?page=1" class="waves-effect"><i class="fa fa-globe m-r-10" aria-hidden="true"></i>用户反馈</a>
                    </li>
                    <li>
                        <a href="device.action?page=1" class="waves-effect"><i class="fa fa-columns m-r-10" aria-hidden="true"></i>管理设备</a>
                    </li>
                    <li>
                        <a href="overdue.action?page=1" class="waves-effect"><i class="fa fa-calendar-minus-o m-r-10" aria-hidden="true"></i>逾期未还记录</a>
                    </li>
                    <%
                        String type=((Admin)session.getAttribute("adm")).getA_type();
                        if(type.equals("校统管"))
                        {
                    %>
                    <li>
                        <a href="grant.action?page=1" class="waves-effect"><i class="fa fa-address-book-o m-r-10" aria-hidden="true"></i>用户授权</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
                <div class="text-center m-t-30">
                    <a href="login.jsp" class="btn btn-danger">退出登录</a>
                </div>
            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
    </aside>
    <!-- ============================================================== -->
    <!-- End Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Page wrapper  -->
    <!-- ============================================================== -->
    <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="row page-titles">
                <div class="col-md-6 col-8 align-self-center">
                    <h3 class="text-themecolor m-b-0 m-t-0">详细预约信息</h3>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <div class="row" style="margin-left:0;">
                <s:form action="detailbyst" method="POST" theme="simple" role="form">
                    <s:set var="d_no" value="#session.d_no"/>
                    <s:hidden name="device.d_no" value="%{#d_no}"/>
                    <button type="submit" class="btn btn-info" style="margin-left:770px;margin-bottom: 5px;margin-top: 0">
                        <span class="fa fa-calendar"></span> 按借用日期排序
                    </button>
                </s:form>
                <s:form action="detailbycd" method="POST" theme="simple" role="form">
                    <s:set var="d_no" value="#session.d_no"/>
                    <s:hidden name="device.d_no" value="%{#d_no}"/>
                    <button type="submit" class="btn btn-info" style="margin-left:10px;margin-bottom: 5px;margin-top: 0">
                        <span class="fa fa-address-card-o"></span> 按信用分排序
                    </button>
                </s:form>
                <!-- column -->
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-block">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <style>
                                        .table th,.table td
                                        {
                                            text-align: center;
                                            vertical-align: middle;
                                        }
                                    </style>
                                    <thead>
                                    <tr>
                                        <th>预约者姓名</th>
                                        <th>预约者学号/工号</th>
                                        <th>身份类型</th>
                                        <th>借用起始日期</th>
                                        <th>借用归还日期</th>
                                        <th>信用分</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        int i=0;
                                        String x="",y="",z="";
                                    %>
                                    <s:iterator value="#session.rsrvlist" var="rl">
                                        <%
                                            //模态框id
                                            i++;
                                            x="x"+i;
                                            y="y"+i;
                                            z="z"+i;
                                        %>
                                        <tr>
                                            <td><s:property value="#rl.u_name"/> </td>
                                            <td><s:property value="#rl.u_no"/> </td>
                                            <td><s:property value="#rl.u_type"/> </td>
                                            <td><s:property value="#rl.r_startDate"/> </td>
                                            <td><s:property value="#rl.r_returnDate"/> </td>
                                            <td><s:property value="#rl.u_creditGrade"/> </td>
                                            <td>
                                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#<%=y%>">
                                                    <span class="fa fa-times"></span> 拒绝
                                                </button>
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#<%=x%>">
                                                    <span class="fa fa-check-square-o"></span> 同意
                                                </button>
                                                <button type="button" class="btn btn-custom" data-toggle="modal" data-target="#<%=z%>">
                                                    <span class="fa fa-bell-o"></span> 调整时间</button>
                                            </td>
                                        </tr>

                                        <!--同意模态框-->
                                        <div class="modal fade" id="<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="agreeTitle">
                                                            同意申请
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">×</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>是否确认同意该预约申请</p>
                                                    </div>
                                                    <s:form method="POST" action="agreersrv" theme="simple" role="form">
                                                        <s:hidden name="r_no" value="%{#rl.r_no}"/>
                                                        <div class="modal-footer">
                                                            <button type="submit" class="btn btn-success">确认</button>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                        </div>
                                                    </s:form>
                                                </div>
                                            </div>
                                        </div>
                                        <!--拒绝模态框-->
                                        <div class="modal fade" id="<%=y%>" tabindex="-1" role="dialog" aria-labelledby="refuseTitle" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="refuseTitle">
                                                            拒绝申请
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">×</span>
                                                        </button>
                                                    </div>
                                                    <s:form action="refusersrv" method="POST" theme="simple" role="form">
                                                        <s:hidden name="r_no" value="%{#rl.r_no}"/>
                                                        <div class="modal-body">
                                                            <textarea class="form-control" rows="5" name="r_feedback" placeholder="请输入具体的拒绝理由" style="margin-top: 10px"></textarea>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                            <button type="submit" class="btn btn-success" >确认拒绝</button>
                                                        </div>
                                                    </s:form>
                                                </div>
                                            </div>
                                        </div>
                                        <!--调整时间模态框-->
                                        <div class="modal fade" id="<%=z%>" tabindex="-1" role="dialog" aria-labelledby="modifyTimeTitle" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="modifyTimeTitle">
                                                            调整借用时间段
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">×</span>
                                                        </button>
                                                    </div>
                                                    <s:form id="myForm" theme="simple" method="POST" action="editrsrv" role="form">
                                                        <s:hidden name="r_no" value="%{#rl.r_no}"/>
                                                        <div class="modal-body" style="margin-bottom: -20px">
                                                            <div class="form-group">
                                                                <label class="col-md-12">调整时间理由</label>
                                                                <div class="col-md-12">
                                                                    <textarea class="form-control" name="feedBack" rows="3" placeholder="请输入调整时间的具体理由"></textarea>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="col-md-12">借用起始日期</label>
                                                                <div class="col-md-12">
                                                                    <style>
                                                                        .iCalendar
                                                                        {
                                                                            background-image: url("assets/images/calendar.png");
                                                                            background-position-x: 400px;
                                                                            background-position-y:center;
                                                                            background-repeat: no-repeat;
                                                                        }
                                                                        input[readonly],.form-control[readonly]{background-color: #FFFFFF;}
                                                                    </style>
                                                                    <input type="text" data-inline="true" class="iCalendar form-control date form_date" name="startDate" id="startdate"
                                                                           data-date-format="yyyy-mm-dd" onfocus="hideStip()" readonly>
                                                                    <span id="emptyStip" style="font-size:14px;color: red; margin-left: 5px;display: none">*起始日期不能为空</span>
                                                                    <span id="nowtip" style="font-size:14px;color: red; margin-left: 5px;display: none">*起始日期不能早于或等于当前日期</span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="col-md-12">借用结束日期</label>
                                                                <div class="col-md-12">
                                                                    <style>
                                                                        .iCalendar
                                                                        {
                                                                            background-image: url("assets/images/calendar.png");
                                                                            background-position-x: 400px;
                                                                            background-position-y:center;
                                                                            background-repeat: no-repeat;
                                                                        }
                                                                        input[readonly],.form-control[readonly]{background-color: #FFFFFF;}
                                                                    </style>
                                                                    <input type="text" data-inline="true" class="iCalendar form-control date form_date" name="endDate" id="enddate"
                                                                           data-date-format="yyyy-mm-dd" onfocus="hideEtip()" readonly>
                                                                    <span id="datetip" style="font-size:14px;color: red; margin-left: 5px;display: none">* 结束日期不得早于或等于起始日期</span>
                                                                    <span id="emptyEtip" style="font-size:14px;color: red; margin-left: 5px;display: none">* 结束日期不能为空</span>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                            <button type="button" class="btn btn-success" onclick="checkForm()">确认</button>
                                                        </div>
                                                    </s:form>
                                                </div>
                                            </div>
                                        </div>
                                    </s:iterator>
                                    </tbody>
                                </table>
                                <!--操作失败提示框-->
                                <div class="modal fade" data-backdrop="static" id="deviceBorrowed" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>操作失败！该预约设备已借出</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--操作失败提示框-->
                                <div class="modal fade" data-backdrop="static" id="deviceScraped" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>操作失败！该预约设备已报废</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--操作失败提示框-->
                                <div class="modal fade" data-backdrop="static" id="deviceDamaged" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>操作失败！该预约设备已损坏</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!--操作失败提示框-->
                                <div class="modal fade" data-backdrop="static" id="deviceHandled" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>操作失败！请求已被处理！</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--操作失败提示框-->
                                <div class="modal fade" data-backdrop="static" id="deviceCanceled" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>操作失败！用户已取消预约</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--操作成功提示框-->
                                <div class="modal fade" data-backdrop="static" id="operateSuccess" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>操作成功！</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--操作失败提示框-->
                                <div class="modal fade" data-backdrop="static" id="operateFailed" tabindex="-1" role="dialog" aria-labelledby="operateSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="button" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="findrsrv.action?page=1">×</a> </span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>请求已被处理！</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <footer class="footer text-center">
            © 2019 Admin by Shankupaolu
        </footer>
        <!-- End footer -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
</div>
<!-- End Wrapper -->
<!-- All Jquery -->
<script src="assets/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="assets/plugins/bootstrap/js/tether.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<!-- slimscrollbar scrollbar JavaScript -->
<script src="js/jquery.slimscroll.js"></script>
<!--Wave Effects -->
<script src="js/waves.js"></script>
<!--Menu sidebar -->
<script src="js/sidebarmenu.js"></script>
<!--stickey kit -->
<script src="assets/plugins/sticky-kit-master/dist/sticky-kit.min.js"></script>
<!--Custom JavaScript -->
<script src="js/custom.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<!--中文引用-->
<script type="text/javascript" src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<!-- ============================================================== -->
<!-- Style switcher -->
<!-- ============================================================== -->
<script src="assets/plugins/styleswitcher/jQuery.style.switcher.js"></script>

<script type="text/javascript">
    $('.form_date').datetimepicker(
        {
            language : 'zh-CN',
            format : 'yyyy-mm-dd',//日期格式
            //language:  'fr',
            weekStart: 1,
            todayBtn:  1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        })
    /*月份日期小于10在前面加0便于比较*/
    function num(s)
    {
        return s < 10 ? '0' + s: s;
    }
    var startdate=document.getElementById("startdate");
    var enddate=document.getElementById("enddate");
    var emptyStip=document.getElementById("emptyStip");
    var nowtip=document.getElementById("nowtip");
    var emptyEtip=document.getElementById("emptyEtip");
    /*点击确认按钮后，判断日期是否为空，以及起始日期是否早于当前日期，起始日期是否晚于等于结束日期*/
    function checkForm()
    {
        var checkempty=true;
        var checknow=true;
        var checkdate=true;
        if((startdate.value==="")||(enddate.value==="")){
            if(startdate.value==="")
                emptyStip.style.display="";
            if(enddate.value==="")
                emptyEtip.style.display="";
            checkempty=false;
        }
        else
        {
            var date=new Date();
            var sysdate=date.getFullYear() + "-" + num((date.getMonth() + 1)) + "-" + num(date.getDate());
            var sdate = $("#startdate").data("datetimepicker").getDate();
            var edate=$("#enddate").data("datetimepicker").getDate();
            var sformatted = sdate.getFullYear() + "-" + num((sdate.getMonth() + 1)) + "-" + num(sdate.getDate());
            var eformatted = edate.getFullYear() + "-" + num((edate.getMonth() + 1)) + "-" + num(edate.getDate());

            if(sformatted<sysdate)
            {
                nowtip.style.display="";
                checknow=false;
            }

            if(sformatted>=eformatted)
            {
                datetip.style.display="";
                checkdate=false;
            }
            if(checknow==true && checkdate==true && checkempty==true)
                $("#myForm").submit();
        }
    }
    /*点击输入框后提示消失*/
    function hideStip()
    {
        emptyStip.style.display="none";
        datetip.style.display="none";
        nowtip.style.display="none";
    }
    function hideEtip()
    {
        emptyEtip.style.display="none";
        datetip.style.display="none";
    }
</script>
<%
    String condition=(session.getAttribute("condition")).toString();
    if(condition!=null)
    {
        switch (condition)
        {
            case "handled":
%>
<script>
    window.onload=function()
    {
        $("#deviceHandled").modal();
    }
</script>
<%
        break;
    case "borrowed":
%>
<script>
    window.onload=function()
    {
        $("#deviceBorrowed").modal();
    }
</script>
<%
        break;
    case "canceled":
%>
<script>
    window.onload=function()
    {
        $("#deviceCanceled").modal();
    }
</script>
<%
        break;
    case "scrapped":
%>
<script>
    window.onload = function ()
    {
        $("#deviceScraped").modal();
    }
</script>
<%
        break;
    case "damaged":
%>
<script>
    window.onload = function ()
    {
        $("#deviceDamaged").modal();
    }
</script>
<%
        break;
    case "operateSuccess":
%>
<script>
    window.onload = function ()
    {
        $("#operateSuccess").modal();
    }
</script>
<%
        break;
    case "operateFailed":
%>
<script>
    window.onload = function ()
    {
        $("#operateFailed").modal();
    }
</script>
<%
                break;
            default:
                break;
        }
    }
    session.setAttribute("condition",null);
%>
</body>
</html>

