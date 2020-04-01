<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.lang.*" %>
<%@ page import="bean.Admin" %>
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
    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">
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
<!-- Preloader - style you can find in spinners.css -->
<!-- ============================================================== -->
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
                    <h3 class="text-themecolor m-b-0 m-t-0">用户信息</h3>
                </div>
            </div>
            <div class="row" style="margin-left:0;margin-bottom: 10px">
                <button id="edit" type="button" class="btn btn-info m-l-5"><span class="fa fa-edit"></span>&nbsp;&nbsp;编辑</button>
                <button id="grant" type="button" class="btn btn-info" style="margin-left: 5px; display: none"><span class="fa fa-check"></span>&nbsp;&nbsp;授权</button>
            </div>
            <!--是否选中用户提示框-->
            <div class="modal fade" id="isChoose" tabindex="-1" role="dialog" aria-labelledby="isChooseTitle" aria-hidden="true">
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
                            <p>请选择所要授予权限的用户</p>
                        </div>
                    </div>
                </div>
            </div>

            <!--授权成功提示模态框-->
            <div class="modal fade" id="grantSuccess" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="grantSuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close"  aria-label="Close">
                                <span aria-hidden="true"><a href="grant.action?page=<%=pages%>">×</a> </span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>授权成功！</p>
                        </div>
                    </div>
                </div>
            </div>
            <!--授权失败提示模态框-->
            <div class="modal fade" id="grantFailed" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="grantSuccessTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                            </h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true"><a href="grant.action?page=<%=pages%>">×</a></span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>授权失败！该用户可能已被授权！</p>
                        </div>
                    </div>
                </div>
            </div>
            <s:form action="grantUser" method="POST" theme="simple" role="form">
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
                                                height: 17px;
                                            }
                                        </style>
                                        <thead>
                                        <tr>
                                            <th style="width:0px">
                                                <input id="chooseAll" type="checkbox" onclick="checkAll()" style="margin-bottom:-5px;visibility: hidden; width: 18px; height: 18px">
                                            </th>
                                            <th>用户学号/工号</th>
                                            <th>用户姓名</th>
                                            <th>用户手机号</th>
                                            <th>用户邮箱</th>
                                            <th>当前身份</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <s:iterator value="#session.users" var="user">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" name="checkbox" value="<s:property value="#user.u_no"/>" onclick="setAll()" style="visibility: hidden; width: 18px; height: 18px" class="checkNum">
                                                </td>
                                                <td><s:property value="#user.u_no"/> </td>
                                                <td><s:property value="#user.u_name"/> </td>
                                                <td><s:property value="#user.u_phone"/> </td>
                                                <td><s:property value="#user.u_email"/> </td>
                                                <td><s:property value="#user.u_type"/> </td>
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
                                                <a class="page-link" href="grant.action?page=<%=pages%>&sp=<%=startpage-1%>" >&laquo;</a>
                                            </li>
                                            <%
                                                }
                                                for(i=startpage;i<=endpage;i++)
                                                {
                                                    if(i==pages)
                                                    {
                                            %>
                                            <li class="active page-item" aria-current="page">
                                                <a class="page-link" href="grant.action?page=<%=i%>"><%=i%></a>
                                            </li>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <li class="page-item">
                                                <a class="page-link" href="grant.action?page=<%=i%>"><%=i%></a>
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
                                                <a class="page-link" href="grant.action?page=<%=pages%>&sp=<%=startpage+1%>">&raquo;</a>
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
                    <!--授权提示模态框-->
                </div>
                <div class="modal fade" id="grantModal" tabindex="-1" role="dialog" aria-labelledby="grantTitle" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="grantTitle">
                                    授权
                                </h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body" style="margin-bottom: -20px">
                                <p>是否确认将该用户设置为管理员？</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default openEdit" data-dismiss="modal">取消</button>
                                <button type="submit" class="btn btn-success">确认</button>
                            </div>
                        </div>
                    </div>
                </div>
            </s:form>

            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- footer -->
        <!-- ============================================================== -->
        <footer class="footer text-center">
            © 2019 Admin by Shankupaolu
        </footer>
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
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
<!-- ============================================================== -->
<!-- Style switcher -->
<!-- ============================================================== -->
<script src="assets/plugins/styleswitcher/jQuery.style.switcher.js"></script>
<script type="text/javascript">
    function operate()
    {
        var cks=document.getElementsByName("checkbox");
        for(i=0;i<cks.length;i++){
            cks[i].checked="";
            cks[i].style.visibility="visible";
        }
        chooseAll.checked="";
        chooseAll.style.visibility="visible";
        grant.style.display="";
        edit.innerHTML="<span class='fa fa-edit'></span>&nbsp;&nbsp;取消编辑";
    };
    function canceledit()
    {
        var cks=document.getElementsByName("checkbox");
        for(i=0;i<cks.length;i++){
            cks[i].style.visibility="hidden";
        }
        chooseAll.style.visibility="hidden";
        grant.style.display="none";
        edit.innerHTML="<span class='fa fa-edit'></span>&nbsp;&nbsp;编辑";
        //chooseAll.style.display="none";
    };
    $(function ()
    {
        var flag=false;
        $("#edit").click(function ()
        {
            if(flag=!flag)
            {
                operate()
            }
            else
                {
                canceledit()
            }
        })
    });
    $(function ()
    {
        $('#grant').click(function ()
        {
            var cks=document.getElementsByName("checkbox");
            var flag=false;
            for(i=0;i<cks.length;i++){
                if(cks[i].checked){
                    flag=true;
                    break;
                }
            }
            if(flag===false){
                $('#isChoose').modal("show");
            }
            else{
                $('#grantModal').modal("show");
            }
        })
    })
    /*全选*/
    function checkAll()
    {
        var allcheck=document.getElementById("chooseAll");
        var choice=document.getElementsByName("checkbox");

        for(var i=0;i<choice.length;i++)
        {
            choice[i].checked=chooseAll.checked;
        }
    };
    function setAll()
    {
        if(!$(".checkNum").checked)
        {
            $("#chooseAll").prop("checked",false); // 子复选框某个不选择，全选也被取消
        }

        var choicelength=$("input[type='checkbox'][class='checkNum']").length;
        var choiceselect=$("input[type='checkbox'][class='checkNum']:checked").length;

        if(choicelength===choiceselect){ //子复选框全部被选择，全选也被选择
            $("#chooseAll").prop("checked",true);
        }
    }
    $('.form_date').datetimepicker({
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
</script>
<%
    String condition=(String)session.getAttribute("condition");
    if(condition!=null)
    {
    if(condition.equals("success"))
    {
%>
<script>
        window.onload = function ()
        {
            $("#grantSuccess").modal();
        }
</script>
<%
    }
    else if(condition.equals("error"))
    {
%>
<script>
        window.onload = function ()
        {
            $("#grantFailed").modal();
        }
</script>
<%
    }
    }
    session.setAttribute("condition",null);
%>
</body>

</html>
