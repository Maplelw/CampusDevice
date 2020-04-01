<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.lang.*" %>
<%@ page import="bean.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <link href="css/fileinput.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/theme.min.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <!-- You can change the theme colors from here -->
    <link href="css/colors/blue.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

    <script src="https://cdn.bootcss.com/bootstrap-fileinput/5.0.6/js/fileinput.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/5.0.6/js/locales/zh.js"></script>

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
        <nav class="navbar top-navbar navbar-toggleable-sm navbar-light" style="height: 50px">
            <!-- ============================================================== -->
            <!-- Logo -->
            <!-- ============================================================== -->
            <div class="navbar-header" style="line-height: 54px">
                <p style="font-size:20px;margin-top:10px;">校园实验设备借用系统</p>
            </div>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <div class="navbar-collapse" style="vertical-align: center">
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
                        if("校统管".equals(type))
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
                    <h3 class="text-themecolor m-b-0 m-t-0">设备信息</h3>
                </div>
            </div>
            <div class="row" style="margin-left:0;margin-bottom: 10px">
                <button type="button" class="btn btn-info" style="margin-right: 5px" data-toggle="modal" data-target="#entryDevice"><span class="fa fa-upload"></span>&nbsp;&nbsp;录入设备</button>
                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#inputDevice" style="margin-right: 5px"><span class="fa fa-file-excel-o"></span>&nbsp;&nbsp;批量导入</button>
                <button id="edit" type="button" class="btn btn-info"><span class="fa fa-edit"></span>&nbsp;&nbsp;编辑</button>
                <button id="modifyD" type="button" class="btn btn-info" style="margin-left:625px;display: none">修改设备</button>
            </div>
            <!--批量导入设备模态框-->
            <div class="modal fade" id="inputDevice" tabindex="-1" role="dialog" aria-labelledby="inputTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="inputTitle">
                                批量导入设备
                            </h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <s:form action="upload" method="POST" enctype="multipart/form-data" theme="simple">
                            <div class="modal-body">
                                <s:file name="upload" id="f_upload"  class="file" data-show-preview="false" data-show-upload="false"
                                        data-show-remove="false"  data-browse-label="浏览" />
                                    <%--                                <s:file name="upload" id="f_upload" class="fileupload"/>--%>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="submit" class="btn btn-success">确认导入</button>
                            </div>
                        </s:form>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <s:form action="changedevice" id="formID" method="POST" theme="simple" role="form">
                <div class="row">
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
                                            .table tr
                                            {
                                                height: 20px;
                                            }
                                        </style>
                                        <thead>
                                        <tr>
                                            <th style="width:0px">
                                                <input id="chooseAll" type="checkbox" onclick="checkAll()" style="margin-bottom:-5px;visibility: hidden; width: 18px; height: 18px">
                                            </th>
                                            <th scope="col">仪器标号</th>
                                            <th scope="col">仪器名称</th>
                                            <th scope="col">型号</th>
                                            <th scope="col">存放地</th>
                                            <th scope="col">出厂号</th>
                                            <th scope="col">状态</th>
                                            <th scope="col">入库日期</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <s:iterator value="#session.devices" var="d">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" name="checkbox" value="<s:property value="#d.d_no" />" onclick="setAll()" style="visibility: hidden; width: 18px; height: 18px" class="checkNum">
                                                </td>
                                                <td><s:property value="#d.d_no"/> </td>
                                                <td><s:property value="#d.d_name"/> </td>
                                                <td><s:property value="#d.d_model"/> </td>
                                                <td><s:property value="#d.d_saveSite"/> </td>
                                                <td><s:property value="#d.d_factoryNo"/> </td>
                                                <td><s:property value="#d.d_state"/> </td>
                                                <td><s:property value="#d.d_storeDate"/> </td>
                                            </tr>
                                        </s:iterator>
                                        </tbody>
                                    </table>
                                    <nav aria-label="Page navigation example" class="text-center" >
                                        <ul class="pagination justify-content-center" id="mytab">
                                            <%
                                                int i;
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
                                                <a class="page-link" href="device?page=<%=pages%>&sp=<%=startpage-1%>" >&laquo;</a>
                                            </li>
                                            <%
                                                }
                                                for(i=startpage;i<=endpage;i++)
                                                {
                                                    if(i==pages)
                                                    {
                                            %>
                                            <li class="active page-item" aria-current="page">
                                                <a class="page-link" href="device?page=<%=i%>"><%=i%></a>
                                            </li>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <li class="page-item">
                                                <a class="page-link" href="device?page=<%=i%>"><%=i%></a>
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
                                                <a class="page-link" href="device?page=<%=pages%>&sp=<%=startpage+1%>">&raquo;</a>
                                            </li>
                                            <%
                                                }
                                            %>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--修改设备模态框-->
                <div class="modal fade" id="modifyDevice" tabindex="-1" role="dialog" aria-labelledby="modifyTitle" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="modifyTitle">
                                    修改设备状态
                                </h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body" style="margin-bottom: -35px">
                                <div class="form-group">
                                    <label class="col-md-12">修改设备状态</label>
                                    <div class="col-md-12">
                                        <select class="form-control" name="d_state">
                                            <option>在库</option>
                                            <option>损坏</option>
                                            <option>报废</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="submit" name="button" value="change" class="btn btn-success">确认修改</button>
                            </div>

                        </div>
                    </div>
                </div>
            </s:form>
            <!--设备批量导入成功提示模态框-->
            <div class="modal fade" data-backdrop="static" id="inputDeviceSuccess" tabindex="-1" role="dialog" aria-labelledby="inputSuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备批量导入成功！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备批量导入标题错误提示模态框-->
            <div class="modal fade" data-backdrop="static" id="inputDeviceTitleValid" tabindex="-1" role="dialog" aria-labelledby="inputSuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备批量导入失败！文件标题有误</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备批量导入设备状态错误提示模态框-->
            <div class="modal fade" data-backdrop="static" id="inputDeviceStateValid" tabindex="-1" role="dialog" aria-labelledby="inputSuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备批量导入失败！设备状态有误</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备批量导入设备编号重复提示模态框-->
            <div class="modal fade" data-backdrop="static" id="inputDeviceNoValid" tabindex="-1" role="dialog" aria-labelledby="inputSuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备批量导入失败！设备编号重复！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备状态修改成功提示模态框-->
            <div class="modal fade"  data-backdrop="static" id="modifyDeviceSuccess" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备状态修改成功！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备状态修改失败提示模态框-->
            <div class="modal fade"  data-backdrop="static" id="modifyDeviceFailed" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" >
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备状态修改过程中出现问题！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备录入成功提示模态框-->
            <div class="modal fade"  data-backdrop="static" id="enterDeviceSuccess" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备录入成功！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--设备录入失败提示模态框-->
            <div class="modal fade"  data-backdrop="static" id="enterDeviceFailed" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" >
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>设备录入失败！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--文件格式错误提示模态框-->
            <div class="modal fade"  data-backdrop="static" id="formatValid" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" >
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>文件上传失败！格式错误</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--文件为空错误提示模态框-->
            <div class="modal fade"  data-backdrop="static" id="filenull" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" >
                            </h4>
                            <button type="button" class="close" aria-label="Close">
                                <span aria-hidden="true">
                                    <a href="device.action?page=<%=pages%>">×</a>
                                </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>上传文件不能为空！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--是否选中修改设备提示模态框-->
            <div class="modal fade" id="isChooseModify" tabindex="-1" role="dialog" aria-labelledby="isChooseTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                                提示
                            </h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>请选择所要修改的设备</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--录入设备模态框-->
            <div class="modal fade" id="entryDevice" tabindex="-1" role="dialog" aria-labelledby="entryTitle" aria-hidden="false">
                <div class="modal-dialog" style="min-width: 10px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTitle">
                                录入设备
                            </h4>
                            <span id="p0" style="color:red;font-size: 14px;margin-left: -200px;visibility: hidden">(*表示所填信息不能为空!)</span>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <s:form action="enterdevice" id="enterForm" method="POST" role="form" theme="simple" >
                            <div class="modal-body" style="margin-bottom: -10px;margin-top: -10px">
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">设备编号<span id="t1" style="color:red; font-size:14px;margin-left: 20px;visibility:hidden">* 设备编号最长不能超过20个字符</span></label>
                                    <div class="col-md-12" style="margin-left:-10px;margin-top: -5px">
                                        <span id="p1" style="color: red;visibility: hidden">*</span>
                                        <input type="text" placeholder="" id="d_no" name="device.d_no" class="form-control form-control-line" onclick="cleanp1()" onclick="cleant1()" style="width: 425px;min-height: 10px;height: 35px">
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">设备名称<span id="t2" style="color:red; font-size:14px;margin-left: 20px;visibility:hidden">* 设备名称最长不能超过20个字符</span></label>
                                    <div class="col-md-12" style="margin-left:-10px;margin-top: -5px">
                                        <span id="p2" style="color: red;visibility: hidden">*</span>
                                        <input type="text" placeholder="" id="d_name" name="device.d_name" class="form-control form-control-line" onclick="cleanp2()" onclick="cleant2()" style="width: 425px;min-height: 10px;height: 35px">
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">入库日期</label>
                                    <div class="col-md-12" style="margin-left:-10px;margin-top: -5px">
                                        <style>
                                            .iCalendar
                                            {
                                                background-image: url("assets/images/calendar.png");
                                                background-position-x: 390px;
                                                background-position-y:center;
                                                background-repeat: no-repeat;
                                            }
                                            input[readonly],.form-control[readonly]{background-color: #FFFFFF;}
                                        </style>
                                        <span id="p3" style="color: red;visibility: hidden">*</span>
                                        <input type="text" data-inline="true"  class="iCalendar form-control date form_date" name="device.d_storeDate" id="d_storeDate"
                                               data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd" style="width: 425px;min-height: 10px;height: 35px" readonly>
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">设备型号<span id="t4" style="color:red; font-size:14px;margin-left: 20px;visibility:hidden">* 设备型号最长不能超过20个字符</span></label>
                                    <div class="col-md-12" style="margin-left:-10px;margin-top: -5px">
                                        <span id="p4" style="color: red;visibility: hidden">*</span>
                                        <input type="text" name="device.d_model" id="d_model" class="form-control form-control-line" onclick="cleanp4()" onclick="cleant4()" style="width: 425px;min-height: 10px;height: 35px">
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">设备状态</label>
                                    <div class="col-md-12" style="width: 455px;min-height: 10px;height: 35px;margin-top: -5px">
                                        <select class="form-control" name="device.d_state">
                                            <option>在库</option>
                                            <option>损坏</option>
                                            <option>报废</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">设备场地<span id="t5" style="color:red; font-size:14px;margin-left: 20px;visibility:hidden" >* 设备场地名称最长不能超过30个字符</span></label>
                                    <div class="col-md-12" style="margin-left:-10px;margin-top: -5px">
                                        <span id="p5" style="color: red; visibility: hidden">*</span>
                                        <input type="text" placeholder="" name="device.d_saveSite" id="d_saveSite" class="form-control form-control-line" onclick="cleanp5()" onclick="cleant5()" style="width: 425px;min-height: 10px;height: 35px">
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-md-12">设备出厂号<span id="t6" style="color:red; font-size:14px;margin-left: 20px;visibility:hidden" >* 设备出厂号最长不能超过40个字符</span></label>
                                    <div class="col-md-12" style="margin-left:-10px;margin-top: -5px">
                                        <span id="p6" style="color: red; visibility: hidden">*</span>
                                        <input type="text" placeholder="" name="device.d_factoryNo" id="d_factoryNo" class="form-control form-control-line" onclick="cleanp6()" onclick="cleant6()" style="width: 425px;min-height: 10px;height: 35px">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="height: 50px">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-success" onclick="checkEnter()">确认录入</button>
                            </div>
                        </s:form>
                    </div>
                </div>
            </div>

            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->
        </div>
        <footer class="footer text-center">
            © 2019 Admin by Shankupaolu
        </footer>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
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

<script src="js/piexif.min.js"></script>
<script src="js/purify.min.js"></script>
<script src="js/fileinput.min.js"></script>
<script src="js/zh.js"></script>
<script src="js/theme.min.js"></script>

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

<!--Custom JavaScript -->
<script src="js/custom.min.js"></script>
<!-- ============================================================== -->
<!-- Style switcher -->
<!-- ============================================================== -->
<script src="assets/plugins/styleswitcher/jQuery.style.switcher.js"></script>
<script type="text/javascript">
    function operate()
    {
        var cks=document.getElementsByName("checkbox");
        for(i=0;i<cks.length;i++)
        {
            cks[i].checked="";
            cks[i].style.visibility="visible";
        }
        chooseAll.checked="";
        chooseAll.style.visibility="visible";
        modifyD.style.display="";
        edit.innerHTML="<span class='fa fa-edit'></span>&nbsp;&nbsp;取消编辑";
        // chooseAll.innerHTML="全选";
        // chooseAll.style.display="";
    };
    function canceledit()
    {
        var cks=document.getElementsByName("checkbox");
        for(i=0;i<cks.length;i++)
        {
            cks[i].style.visibility="hidden";
        }
        chooseAll.style.visibility="hidden";
        modifyD.style.display="none";
        edit.innerHTML="<span class='fa fa-edit'></span>&nbsp;&nbsp;编辑";
        // chooseAll.style.display="none";
    };
    /*编辑按钮*/
    $(function ()
    {
        var flag=false;
        $("#edit").click(function ()
        {
            if(flag=!flag){
                operate()
            }
            else{
                canceledit()
            }
        })
    });
    /*全选*/
    function checkAll()
    {
        var allcheck=document.getElementById("chooseAll");
        var choice=document.getElementsByName("checkbox");

        for(var i=0;i<choice.length;i++){
            choice[i].checked=chooseAll.checked;
        }
    };
    function setAll()
    {
        if(!$(".checkNum").checked){
            $("#chooseAll").prop("checked",false); // 子复选框某个不选择，全选也被取消
        }

        var choicelength=$("input[type='checkbox'][class='checkNum']").length;
        var choiceselect=$("input[type='checkbox'][class='checkNum']:checked").length;

        if(choicelength===choiceselect){ //子复选框全部被选择，全选也被选择
            $("#chooseAll").prop("checked",true);
        }
    }

    /*日期选择器*/
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
        });
    /*判断修改设备前是否选中了设备*/
    $(function ()
    {
        $('#modifyD').click(function ()
        {
            var cks=document.getElementsByName("checkbox");
            var flag=false;
            for(i=0;i<cks.length;i++)
            {
                if(cks[i].checked)
                {
                    flag=true;
                    break;
                }
            }
            if(flag===false)
            {
                $('#isChooseModify').modal("show");
            }
            else
            {
                $('#modifyDevice').modal("show");
            }
        })
    })
    var d_no=document.getElementById("d_no");
    var d_name=document.getElementById("d_name");
    var d_storeDate=document.getElementById("d_storeDate");
    var d_model=document.getElementById("d_model");
    var d_saveSite=document.getElementById("d_saveSite");
    var d_factoryNo=document.getElementById("d_factoryNo");

    var p0=document.getElementById("p0");
    var p1=document.getElementById("p1");
    var p2=document.getElementById("p2");
    var p3=document.getElementById("p3");
    var p4=document.getElementById("p4");
    var p5=document.getElementById("p5");
    var p6=document.getElementById("p6");
    var t1=document.getElementById("t1");
    var t2=document.getElementById("t2");
    var t4=document.getElementById("t4");
    var t5=document.getElementById("t5");
    var t6=document.getElementById("t6");

    function checkEnter()
    {
        var b1=true;
        var b2=true;
        var b3=true;
        var b4=true;
        var b5=true;
        var b6=true;

        var f1=true;
        var f2=true;
        var f4=true;
        var f5=true;
        var f6=true;


        if(d_no.value==="")
        {
            p1.style.cssText="color: red";
            p0.style.cssText="color:red;font-size: 14px;margin-left: -200px;";
            b1=false;
        }
        else
        {
            p1.style.cssText="color: red;visibility: hidden";
            p0.style.cssText="color: red;font-size: 14px;margin-left: -200px;visibility: hidden";
        }
        if((d_no.value).length>20)
        {
            t1.style.cssText="color:red; font-size:14px;margin-left: 20px";
            f1=false;
        }
        else
        {
            t1.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
        }
        if(d_name.value==="")
        {
            p2.style.cssText="color: red";
            p0.style.cssText="color:red;font-size: 14px;margin-left: -200px;";
            b2=false;
        }
        else
        {
            p2.style.cssText="color: red;visibility: hidden";
            p0.style.cssText="color: red;font-size: 14px;margin-left: -200px;visibility: hidden";
        }
        if((d_name.value).length>20)
        {
            t2.style.cssText="color:red; font-size:14px;margin-left: 20px";
            f2=false;
        }
        else
        {
            t2.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
        }
        if(d_storeDate.value==="")
        {
            p3.style.cssText="color: red";
            p0.style.cssText="color:red;font-size: 14px;margin-left: -200px;";
            b3=false;
        }
        else
        {
            p3.style.cssText="color: red;visibility: hidden";
            p0.style.cssText="color: red;font-size: 14px;margin-left: -200px;visibility: hidden";
        }
        if(d_model.value==="")
        {
            p4.style.cssText="color: red";
            p0.style.cssText="color:red;font-size: 14px;margin-left: -200px;";
            b4=false;
        }
        else
        {
            p4.style.cssText="color: red;visibility: hidden";
            p0.style.cssText="color: red;font-size: 14px;margin-left: -200px;visibility: hidden";
        }
        if((d_model.value).length>20)
        {
            t4.style.cssText="color:red; font-size:14px;margin-left: 20px";
            f4=false;
        }
        else
        {
            t4.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
        }
        if(d_saveSite.value==="")
        {
            p5.style.cssText="color: red";
            p0.style.cssText="color:red;font-size: 14px;margin-left: -200px;";
            b5=false;
        }
        else
        {
            p5.style.cssText="color: red;visibility: hidden";
            p0.style.cssText="color: red;font-size: 14px;margin-left: -200px;visibility: hidden";
        }
        if((d_saveSite.value).length>30)
        {
            t5.style.cssText="color:red; font-size:14px;margin-left: 20px";
            f5=false;
        }
        else
        {
            t5.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
        }
        if(d_factoryNo.value==="")
        {
            p6.style.cssText="color: red";
            p0.style.cssText="color:red;font-size: 14px;margin-left: -200px;";
            b6=false;
        }
        else
        {
            p6.style.cssText="color: red;visibility: hidden";
            p0.style.cssText="color: red;font-size: 14px;margin-left: -200px;visibility: hidden";
        }
        if((d_factoryNo.value).length>40)
        {
            t6.style.cssText="color:red; font-size:14px;margin-left: 20px";
            f6=false;
        }
        else
        {
            t6.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
        }
        if(b1==true && b2==true && b3==true && b4==true &&b5==true && b6==true && f1==true && f2==true && f4==true &&f5==true && f6==true)
        {
            $("#enterForm").submit();
        }
    }
    function cleanp0()
    {
        p0.style.cssText="color: red;visibility: hidden";
    }
    function cleanp1()
    {
        p1.style.cssText="color: red;visibility: hidden";
    }
    function cleanp2()
    {
        p2.style.cssText="color: red;visibility: hidden";
    }
    function cleanp3()
    {
        p3.style.cssText="color: red;visibility: hidden";
    }
    function cleanp4()
    {
        p4.style.cssText="color: red;visibility: hidden";
    }
    function cleanp5()
    {
        p5.style.cssText="color: red;visibility: hidden";
    }
    function cleanp6()
    {
        p6.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
    }
    function cleant1()
    {
        t1.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
    }
    function cleant2()
    {
        t2.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
    }
    function cleant4()
    {
        t4.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
    }
    function cleant5()
    {
        t5.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
    }
    function cleant6()
    {
        t6.style.cssText="color:red; font-size:14px;margin-left: 20px;visibility: hidden";
    }
</script>
<%
    String condition=(String)session.getAttribute("condition");
    if(condition!=null)
    {
        switch (condition)
        {
            case "uploadSuccess":
%>
<script>
    window.onload = function ()
    {
        $("#inputDeviceSuccess").modal();
    }
</script>
<%
        break;
    case "tileValid":
%>
<script>
    window.onload = function ()
    {
        $("#inputDeviceTitleValid").modal();
    }
</script>
<%
        break;
    case "stateValid":
%>
<script>
    window.onload = function ()
    {
        $("#inputDeviceStateValid").modal();
    }
</script>
<%
        break;
    case "null":
%>
<script>
    window.onload = function ()
    {
        $("#filenull").modal();
    }
</script>
<%
        break;
    case "deviceNoValid":
%>
<script>
    window.onload = function ()
    {
        $("#inputDeviceNoValid").modal();
    }
</script>
<%
        break;
    case "changeSuccess":
%>
<script>
    window.onload = function ()
    {
        $("#modifyDeviceSuccess").modal();
    }
</script>
<%
        break;
    case "changeFailed":
%>
<script>
    window.onload = function ()
    {
        $("#modifyDeviceFailed").modal();
    }
</script>
<%
        break;
    case "formatValid":
%>
<script>
    window.onload = function ()
    {
        $("#formatValid").modal();
    }
</script>
<%
        break;
    case "enterFailed":
%>
<script>
    window.onload = function () {
        $("#enterDeviceFailed").modal();
    }
</script>
<%
        break;
    case "enterSuccess":
%>
<script>
    window.onload = function ()
    {
        $("#enterDeviceSuccess").modal();
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
