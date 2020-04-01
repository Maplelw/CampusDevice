<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--引用Struts2的标签库-->
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.lang.*" %>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <title>校园实验设备借用系统</title>
    <meta charset="UTF-8">
    <meta name="description" content="loans HTML Template">
    <meta name="keywords" content="loans, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Favicon -->
    <link href="img/favicon.png" rel="shortcut icon"/>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="css/flaticon.css"/>
    <link rel="stylesheet" href="css/slicknav.min.css"/>

    <!-- Main Stylesheets -->
    <link rel="stylesheet" href="css/style1.css"/>


    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<%
    session.setAttribute("adm",null);
    String condition=null;
    if(session.getAttribute("condition")!=null)
    {
        condition=(String)session.getAttribute("condition");
    }
    else
        session.setAttribute("condition",null);
%>
<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>
<!-- Hero Section  -->
<div class="container">
    <div class="row" style="padding-top:100px">
        <div class="col-lg-7">
            <div class="hs-text">
                <h2>校园实验设备借用系统</h2>
                <!--						<p>欢迎您的使用</p>-->
                <!--						<a href="#" class="site-btn sb-dark">Find out more</a>-->
            </div>
        </div>
        <div class="col-lg-5">
            <s:form action="main" id="loginForm" method="POST" role="form" theme="simple" class="hero-form">
                <style>
                    .hero-form input
                    {
                        margin-bottom:0px;
                    }
                </style>
                <div class="text-center" style="margin-bottom: 10px">
                    <label style="color: white; font-size: 20px">管理员登陆</label>
                </div>
                <div class="form-group">
                    <input type="text"  name="adm.a_no" id="username" placeholder="学号/工号" style="border-radius: 5px"/>
                </div>
                <div class="form-group" style="margin-top: 40px">
                    <s:password  name="adm.a_password" placeholder="密码" id="password" style="border-radius: 5px;margin-bottom:0px;" onchange="encryption(this.id)" />
                    <%
                        if(condition!=null)
                        {
                            if(condition.equals("error"))
                            {
                    %>
                    <span style="font-size:14px;color: red">* 学工号或密码错误</span>
                    <%

                            }
                            session.setAttribute("condition",null);
                        }
                    %>
                </div>

                <!--						<button class="btn btn-primary btn-lg site-btn" value="登录"/>-->
                <div class="row" style="vertical-align: center">
                    <div class=" col-md-8">

                    </div>
                    <div class= "col-md-4" style="font-size: 15px">
                        <a href="forgetPassword.jsp" style="color: white; float: right; text-decoration: underline ">忘记密码？</a>
                    </div>
                </div>
                <button type="button" class="site-btn text-center" style="width:160px; margin-left: 100px;background-color:green; font-size: 15px" onclick="checkLogin()">登陆</button>
            </s:form>

        </div>
    </div>
</div>
<!--修改密码成功-->
<div class="modal fade"  data-backdrop="static" id="cahngeSuccess" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" >
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <p>密码修改成功！</p>
            </div>
        </div>
    </div>
</div>
<div class="hero-slider owl-carousel">
    <div class="hs-item set-bg" data-setbg="img/hero-slider/3.jpg"></div>
    <div class="hs-item set-bg" data-setbg="img/hero-slider/1.jpg"></div>
    <div class="hs-item set-bg" data-setbg="img/hero-slider/2.jpg"></div>
</div>
<!-- Hero Section end -->

<!--====== Javascripts & Jquery ======-->
<script src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="js/jQuery.md5.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.slicknav.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/main.js"></script>
<script>
    function encryption(x)
    {
        var y=document.getElementById(x).value;
        document.getElementById(x).value=$.md5(y);
    }
    //实现记住密码功能
    function Save()
    {
        if ($("#rememberMe").prop("checked"))
        {
            var str_username = $("#username").val();//用户名
            var str_password = $("#password").val();//密码
            $.cookie("rmbUser", "true", { expires: 7 }); //存储一个带7天期限的cookie
            $.cookie("username", str_username, { expires: 7 });
            $.cookie("password", str_password, { expires: 7 });
        }
        else
        {
            $.cookie("rmbUser", "false", { expire: -1 });
            $.cookie("username", "", { expires: -1 });
            $.cookie("password", "", { expires: -1 });
        }
    }

    $(document).ready(function ()
    {
        if ($.cookie("rmbUser") == "true")
        {
            $("#rememberMe").attr("checked", true);
            $("#username").val($.cookie("username"));
            $("#password").val($.cookie("password"));
        }
    });

    function checkLogin()
    {
        //Save();
        $("#loginForm").submit();
    }
</script>
<script type="text/javascript">
    $(function()
    {
        if (window.history && window.history.pushState) {
            $(window).on('popstate', function () {
                window.history.pushState('forward', null, '#');
                window.history.forward(1);
            });
        }
        window.history.pushState('forward', null, '#');
        window.history.forward(1);
    })
</script>
<%
    if("success".equals(condition))
    {
%>
<script>
    window.onload = function ()
    {
        $("#cahngeSuccess").modal();
    }
</script>
<%
    }
%>
</body>
</html>
