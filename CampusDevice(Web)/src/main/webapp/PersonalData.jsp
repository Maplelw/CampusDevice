<%@ page import="bean.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
    //toString方法要求字符串不为空
    String condition=(String)session.getAttribute("condition");
    Admin adm=(Admin)session.getAttribute("adm");
    String phone=adm.getA_phone();
    String email=adm.getA_email();
    System.out.println(phone+email);
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
                    <h3 class="text-themecolor m-b-0 m-t-0">个人资料</h3>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <!-- Row -->
            <div class="row">
                <!-- Column -->
                <div class="col-lg-5 col-xlg-3 col-md-4">
                    <div class="card" >
                        <div class="card-block" style="text-align: center">
                            <img src="assets/images/logo.jpg" width="300px"/>
                            <p style="font-size: 30px;font-weight: bold;margin-top: 10px">湖大微设备</p>
                        </div>
                    </div>
                </div>
                <!-- Column -->
                <!-- Column -->
                <div class="col-lg-7 col-xlg-9 col-md-8">
                    <div class="card">
                        <div class="card-block">
                            <div class="form-horizontal form-material">
                                <div class="form-group">
                                    <label class="col-md-12">姓名</label>
                                    <div class="col-md-12">
                                        <input type="text" placeholder="<s:property value="#adm.a_name"/>" class="form-control form-control-line" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">工号</label>
                                    <div class="col-md-12">
                                        <input type="email" placeholder="<s:property value="#adm.a_no"/>" class="form-control form-control-line" name="example-email" id="example-email" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">手机号码</label>
                                    <div class="col-md-12">
                                        <input type="text" placeholder="<s:property value="#adm.a_phone"/>" class="form-control form-control-line" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">邮箱</label>
                                    <div class="col-md-12">
                                        <input type="text" placeholder="<s:property value="#adm.a_email"/>" class="form-control form-control-line" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12">权限</label>
                                    <div class="col-md-12">
                                        <input type="text" placeholder="<s:property value="#adm.a_type"/>" class="form-control form-control-line" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <div class="text-center">
                                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#editData">
                                                <span class="fa fa-edit"></span>编辑个人资料
                                            </button>
                                        </div>
                                        <!--修改个人资料模态框-->
                                        <div class="modal" id="editData" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
                                            <style>
                                                .clsEdit{}
                                                .openEdit{}
                                                .span{}
                                                .span:hover{
                                                    color:greenyellow;
                                                }
                                            </style>
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <s:form id="myForm" action="edit" method="POST" theme="simple" role="form">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalTitle">
                                                                编辑个人资料
                                                            </h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">×</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body" style="margin-bottom: -15px">
                                                            <div class="form-group" style="margin-bottom: 10px">
                                                                <label class="col-md-12" style="font-family:'Georgia'; margin-left: 0">姓名</label>
                                                                <div class="col-md-12">
                                                                    <input type="text" placeholder="<s:property value="#adm.a_name"/>" class="form-control form-control-line" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="form-group" style="margin-bottom: 15px">
                                                                <label for="example-email" class="col-md-12"style="margin-left: 0px">工号</label>
                                                                <div class="col-md-12">
                                                                    <input type="email" placeholder="<s:property value="#adm.a_no"/>" class="form-control form-control-line" name="example-email" id="" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="form-group" style="margin-bottom: 15px">
                                                                <label class="col-md-12 row" style="margin-left: 0px">密码</label>
                                                                <div class="col-md-12">
                                                                    <input type="password" value="password" class="form-control form-control-line" style="width: 420px" readonly>
                                                                    <span class="fa fa-pencil clsEdit span" data-toggle="modal" data-target="#modifyPassword" style="padding-bottom: -100px"></span>
                                                                </div>
                                                            </div>
                                                            <div class="form-group" style="margin-bottom: 15px">
                                                                <label class="col-md-12 row" style="margin-left: 0px">手机</label>
                                                                <div class="col-md-12">
                                                                    <input type="text" id="newPhone" name="newPhone" placeholder="<s:property value="#adm.a_phone"/>" class="form-control form-control-line" style="width: 420px" onclick="cleanpp()" onblur="checkPhone()" readonly>
                                                                    <span class="fa fa-pencil span" id="changeTel" style="padding-bottom: -100px"></span>
                                                                </div>
                                                                <span id="pp" style="font-size:12px;color: red; margin-left: 20px;visibility: hidden">* 请输入正确的手机号</span>
                                                            </div>
                                                            <div class="form-group" style="margin-bottom: 15px">
                                                                <label class="col-md-12 row" style="margin-left: 0px">邮箱</label>
                                                                <div class="col-md-12">
                                                                    <input type="text" id="newEmail"  name="newEmail"  placeholder="<s:property value="#adm.a_email"/>" class="form-control form-control-line" style="width: 420px" onclick="cleanep()" onblur="checkEmail()" readonly>
                                                                    <span class="fa fa-pencil span" id="changeEmail" style="padding-bottom: -100px"></span>
                                                                </div>
                                                                <span id="ep" style="font-size:12px;color: red; margin-left: 20px;visibility: hidden">* 请输入正确的邮箱</span>

                                                            </div>
                                                            <div class="form-group" style="margin-bottom: 15px">
                                                                <label class="col-md-12" style="margin-left: 0px">权限</label>
                                                                <div class="col-md-12">
                                                                    <input type="text" placeholder="<s:property value="#adm.a_type"/>" class="form-control form-control-line" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                            <button type="button" class="btn btn-success" onclick="checkEdit()">保存</button>
                                                        </div>
                                                    </s:form>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Column -->
            </div>
            <!-- Row -->
            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->

        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
    </div>
    <!--修改密码模态框-->
    <div class="modal fade" id="modifyPassword" tabindex="-1" role="dialog" aria-labelledby="modifyPasswordTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="modifyPasswordTitle">
                        修改密码
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" class="openEdit">×</span>
                    </button>
                </div>
                <s:form id="pform" action="changepassword" method="POST" theme="simple" role="form">
                    <div class="modal-body" style="margin-bottom: -35px">
                        <div class="form-group">
                            <label class="col-md-12">原密码</label>
                            <div class="col-md-12">
                                <input type="password" id="oldPassword" name="oldPassword" class="form-control form-control-line" onchange="encryption(this.id)"  onclick="cleanfp()"/>
                                <span id="fp" style="font-size:14px;color: red; margin-left: 5px;visibility:hidden;">* 原密码错误！</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">新密码</label>
                            <div class="col-md-12">
                                <input type="password" name="newPassword" id="newPassword" class="form-control form-control-line" onblur="checknewpwd()" onclick="cleansp()"/>
                                <span id="sp" style="font-size:14px;color: red; margin-left: 5px;visibility:hidden;">* 密码应该大于6位！</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-12">确认密码</label>
                            <div class="col-md-12">
                                <input type="password" name="secondPassword" id="secondPassword" class="form-control form-control-line" onblur="checkscdwpwd()" onclick="cleantp()"/>
                                <span id="tp" style="font-size:14px;color: red; margin-left: 5px;visibility:hidden;">* 两次输入的密码不相同！</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default openEdit" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-success" onclick="checkPassword()">确认修改</button>
                    </div>
                </s:form>
            </div>
        </div>
    </div>
    <!--修改成功提示框-->
    <div class="modal fade" id="modifySuccess" tabindex="-1" role="dialog" aria-labelledby="modifySuccessTitle" aria-hidden="true">
        <style>
            .clsEdit{}
            .openEdit{}
        </style>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" class="openEdit">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>修改成功！</p>
                </div>
            </div>
        </div>
    </div>
    <!--保存成功提示框-->
    <div class="modal fade" id="editSuccess" tabindex="-1" role="dialog" aria-labelledby="modifySuccessTitle" aria-hidden="true">
        <style>
            .clsEdit{}
            .openEdit{}
        </style>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>修改成功！</p>
                </div>
            </div>
        </div>
    </div>
    <!--修改失败提示框-->
    <div class="modal fade" id="modifyFailed" tabindex="-1" role="dialog" aria-labelledby="modifySuccessTitle" aria-hidden="true">
        <style>
            .clsEdit{}
            .openEdit{}
        </style>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" class="openEdit">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>修改失败！</p>
                </div>
            </div>
        </div>
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
<script type="text/javascript" src="js/jQuery.md5.js"></script>
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
<script>
    function encryption(x)
    {
        var y=document.getElementById(x).value;
        document.getElementById(x).value=$.md5(y);
    }
</script>
<script type="text/javascript">
    var p_phone="<%=phone%>";
    var p_email="<%=email%>";
    /*模态框嵌套控制*/
    $(function ()
    {
        $('.clsEdit').click(function ()
        {
            $('#editData').modal('hide');
        })
        $('.openEdit').click(function ()
        {
            $('#editData').modal('show');
        })
        $("#modifyPassword,#modifySuccess").on("hidden.bs.modal", function ()
        {
            $("body").addClass("modal-open");
        })
    });

    /*编辑手机、邮箱*/
    $(function ()
    {
        var span1=document.getElementById("changeTel");
        span1.onclick=function()
        {
            event.stopPropagation();
            $("#newPhone").removeAttr("readonly");
            $("#newPhone").removeAttr("placeholder");
            $("#newPhone").focus();
        }
    })
    $(function ()
    {
        var span2=document.getElementById("changeEmail");
        span2.onclick=function()
        {
            event.stopPropagation();
            $("#newEmail").removeAttr("readonly");
            $("#newEmail").removeAttr("placeholder");
            $("#newEmail").focus();
        }
    })

    function checknewpwd()
    {
        if((newPassword.value).length<=6)
        {
            sp.style.visibility="visible";
        }
        else
        {
            sp.style.visibility="hidden";
        }
    }
    function checkscdwpwd()
    {
        if(!((newPassword.value)===(secondPassword.value)))
        {
            tp.style.visibility="visible";
        }
        else
        {
            tp.style.visibility="hidden";
        }
    }
    function checkPassword()
    {
        var checkp1=true;
        var checkp2=true;
        if(!((newPassword.value)===(secondPassword.value)))
        {
            checkp1=false;
        }
        if((newPassword.value).length<=6)
        {
            checkp2=false;
        }
        if(checkp1==true && checkp2==true)
            $("#pform").submit();
    }

    function checkEmail()
    {
        var email = $('#newEmail').val();
        var regex = /^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;
        if(email==="")
        {
            var em=document.getElementById("newEmail");
            $("#newEmail").attr("readonly",true);
            em.setAttribute("placeholder",p_email);
        }
        if ((!email.match(regex))&&(email!=""))
        {
            ep.style.visibility="visible";
        }
        else
        {
            ep.style.visibility="hidden";
        }
    }

    function checkEdit()
    {
        var checkemail=true;
        var checkphone=true;
        var email = $('#newEmail').val();
        var regex = /^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;
        if((!email.match(regex))&&(email!=""))
        {
            checkemail=false;
        }
        if(((newPhone.value).length!==11)&&(newPhone.value!=""))
        {
            checkphone=false;
        }
        if(checkphone==true && checkemail==true)
            $("#myForm").submit();
    }

    function checkPhone()
    {
        var email = $('#newEmail').val();
        var regex = /^(13[0-9]{9})|(15[0-9]{9})|(17[0-9]{9})|(18[0-9]{9})|(19[0-9]{9})$/;
        if (newPhone.value==="")
        {
            $('#newPhone').attr("readonly",true);
            $('#newPhone').attr("placeholder",p_phone);
        }
        if(((newPhone.value).length!==11)&&(newPhone.value!=""))
        {
            pp.style.visibility="visible";
        }
        else
        {
            pp.style.visibility="hidden";
        }
    }
    function cleanfp()
    {
        fp.style.visibility="hidden";
    }

    function cleansp()
    {
        sp.style.visibility="hidden";
    }

    function cleantp()
    {
        tp.style.visibility="hidden";
    }

    function cleanpp()
    {
        pp.style.visibility="hidden";
    }

    function cleanep()
    {
        ep.style.visibility="hidden";
    }
</script>
<%
    switch (condition)
    {
        case "success":
%>
<script>
    window.onload = function ()
    {
        $("#modifySuccess").modal();
    }
</script>
<%
        break;
    case "editsuccess":
%>
<script>
    window.onload = function ()
    {
        $("#editSuccess").modal();
    }
</script>
<%
        break;
    case "error":
%>
<script>
    fp.style.visibility="visible";
    window.onload = function ()
    {
        $("#modifyPassword").modal();
    }
</script>
<%
        break;
    case "failed":
%>
<script>
    window.onload = function ()
    {
        $("#modifyFailed").modal();
    }
</script>
<%      break;
}
    session.setAttribute("condition",null);
%>
</body>
</html>