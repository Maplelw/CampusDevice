<%@ page import="bean.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
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
<%
    int startpage=(Integer)session.getAttribute("startpage");
    int endpage=(Integer)session.getAttribute("endpage");
    int pages=(Integer)session.getAttribute("page");
    int maxpage=(Integer)session.getAttribute("maxpage");
%>
<!-- ============================================================== -->
<!-- Main wrapper - style you can find in pages.scss -->
<!-- ============================================================== -->
<div id="main-wrapper">
    <!-- ============================================================== -->
    <!-- Topbar header - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <header class="topbar">
        <nav class="navbar top-navbar navbar-toggleable-sm navbar-light"  style="height: 50px">
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
                <ul class="navbar-nav mr-auto mt-md-0 ">
                    <!-- This is  -->
                    <li class="nav-item"> <a class="nav-link nav-toggler hidden-md-up text-muted waves-effect waves-dark" href="javascript:void(0)"><i class="ti-menu"></i></a> </li>
                    <li class="nav-item hidden-sm-down">
                        <form class="app-search p-l-20">
                        </form>
                    </li>
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
                    <h3 class="text-themecolor m-b-0 m-t-0">待归还设备</h3>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <div class="row">
                <!-- column -->
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-block">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <style>
                                        .table th,.table td{
                                            text-align: center;
                                            vertical-align: middle;
                                        }
                                    </style>

                                    <thead>
                                    <tr>
                                        <th>设备编号</th>
                                        <th>设备场地</th>
                                        <th>用户学号/工号</th>
                                        <th>用户姓名</th>
                                        <th>借用日期</th>
                                        <th>应还日期</th>
                                        <th>归还状态</th>
                                        <th>确认归还</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%int i=0;%>
                                    <s:iterator value="#session.borrows" var="b">
                                        <%i++;%>
                                        <tr>
                                            <td><s:property value="#b.d_no"/> </td>
                                            <td><s:property value="#b.d_saveSite"/> </td>
                                            <td><s:property value="#b.u_no"/> </td>
                                            <td><s:property value="#b.u_name"/> </td>
                                            <td><s:property value="#b.b_borrowDate"/> </td>
                                            <td><s:property value="#b.b_returnDate"/> </td>
                                            <td>
                                                <s:if test="#b.b_state==0">正常借用中</s:if>
                                                <s:elseif test="#b.b_state==-1">逾期未还</s:elseif>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#<%=i%>">
                                                    <span class="fa fa-check-square-o"></span>确认归还
                                                </button>
                                            </td>
                                        </tr>
                                        <!--确认归还模态框-->
                                        <div class="modal fade" id="<%=i%>" tabindex="-1" role="dialog" aria-labelledby="confirmReturnTitle" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="confirmReturnTitle">
                                                            确认设备归还状态
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">×</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div>
                                                            <label>归还设备状态</label>
                                                        </div>
                                                        <s:form action="return" method="POST" role="form" theme="simple">
                                                            <div style="margin-left: 20px">
                                                                <div>
                                                                    <label>
                                                                        <input type="radio" name="returnDevice.rd_deviceState" id="optionsRadios1" value="normal" style="margin-right: 5px" checked >
                                                                        正常
                                                                    </label>
                                                                </div>
                                                                <div>
                                                                    <label>
                                                                        <input type="radio" name="returnDevice.rd_deviceState" id="optionsRadios2" value="damaged" style="margin-right: 5px" />
                                                                        损坏
                                                                    </label>
                                                                </div>
                                                                <div>
                                                                    <label>
                                                                        <input type="radio" name="returnDevice.rd_deviceState" id="optionsRadios3" value="scrapped" style="margin-right: 5px" />
                                                                        报废
                                                                    </label>
                                                                </div>
                                                                <div>
                                                                    <label>
                                                                        <input type="radio" name="returnDevice.rd_deviceState" id="optionsRadios4" value="other" style="margin-right: 5px" />
                                                                        其他
                                                                    </label>
                                                                    <textarea class="form-control" name="returnDevice.rd_comment" rows="5" placeholder="请输入详细信息" ></textarea>
                                                                </div>
                                                            </div>
                                                            <s:hidden name="returnDevice.u_no" value="%{#b.u_no}"/>
                                                            <s:hidden name="returnDevice.d_no" value="%{#b.d_no}"/>
                                                            <s:hidden name="returnDevice.b_no" value="%{#b.b_no}"/>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                                <button type="subimt" class="btn btn-success">
                                                                    <span class="fa fa-check-square-o"></span> 确认归还
                                                                </button>
                                                            </div>
                                                        </s:form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </s:iterator>
                                    </tbody>
                                </table>
                                <nav aria-label="Page navigation example" class="text-center" >
                                    <ul class="pagination justify-content-center" id="mytab">
                                        <%
                                            int ii;
                                            if(startpage==1)
                                            {
                                        %>
                                        <!--向前-->
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-disabled="true">&laquo;</a>
                                        </li>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="returned.action?page=<%=pages%>&sp=<%=startpage-1%>" >&laquo;</a>
                                        </li>
                                        <%
                                            }
                                            for(ii=startpage;ii<=endpage;ii++)
                                            {
                                                if(ii==pages)
                                                {
                                        %>
                                        <li class="active page-item" aria-current="page">
                                            <a class="page-link" href="returned.action?page=<%=ii%>"><%=ii%></a>
                                        </li>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="returned.action?page=<%=ii%>"><%=ii%></a>
                                        </li>
                                        <%
                                                }
                                            }
                                            if(endpage==maxpage)
                                            {
                                        %>
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-disabled="true">&raquo;</a>
                                        </li>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="returned.action?page=<%=pages%>&sp=<%=startpage+1%>">&raquo;</a>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </nav>
                                <!-- 归还成功模态框-->
                                <div class="modal fade" data-backdrop="static" id="returnSuccess" tabindex="-1" role="dialog" aria-labelledby="returnSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="submit" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="returned.action?page=<%=pages%>">×</a></span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>归还成功！</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 归还失败模态框-->
                                <div class="modal fade" data-backdrop="static" id="returnFailed" tabindex="-1" role="dialog" aria-labelledby="returnSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="submit" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="returned.action?page=<%=pages%>">×</a></span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>归还过程中出现错误！</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 归还请求已被处理模态框-->
                                <div class="modal fade" data-backdrop="static" id="returnDone" tabindex="-1" role="dialog" aria-labelledby="returnSuccessTitle" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">
                                                </h4>
                                                <button type="submit" class="close" aria-label="Close">
                                                    <span aria-hidden="true"><a href="returned.action?page=<%=pages%>">×</a></span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <p>归还失败！请求已被处理</p>
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
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Wrapper -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- All Jquery -->
<!-- ============================================================== -->
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
<!-- ============================================================== -->
<!-- Style switcher -->
<!-- ============================================================== -->
<script src="assets/plugins/styleswitcher/jQuery.style.switcher.js"></script>

<script type="text/javascript">
    function other()
    {
        $("#otherDetail").attr("readOnly",false);
    }
    function normal()
    {
        otherDetail.value="";
        $("#otherDetail").attr("readOnly",true);
    }
</script>
<%
    String condition=(String)session.getAttribute("condition");
    if(condition!=null)
    {
        switch (condition)
        {
            case "operateSuccess":
%>
<script>
    window.onload = function () {
        $("#returnSuccess").modal();
    }
</script>
<%
        break;
    case "operateFailed":
%>
<script>
    window.onload = function ()
    {
        $("#returnFailed").modal();
    }
</script>
<%
        break;
    case "done":
%>
<script>
    window.onload = function ()
    {
        $("#returnDone").modal();
    }
</script>
<%
            default:
                break;
        }
    }
    session.setAttribute("condition",null);
%>
</body>
</html>
