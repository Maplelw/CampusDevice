<%@ page import="utils.MessageUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.lang.*"%>
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
    String condition=null;
    if(session.getAttribute("condition")!=null)
    {
        condition=(String)session.getAttribute("condition");
    }
    else
        session.setAttribute("condition",null);
    String code=(String)session.getAttribute("inputVerifyCode");
%>
<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-7"  style="padding-top:100px">
            <div class="hs-text">
                <h2>校园实验设备借用系统</h2>
            </div>
        </div>
        <div class="col-lg-5" style="padding-top: 30px">
            <div class="hero-form">
                <style>
                    .hero-form
                    {
                        padding-top: 50px;
                        padding-bottom: 50px;
                    }
                    .hero-form input
                    {
                        margin-bottom:0px;
                    }
                </style>
                <div class="text-center" style="margin-bottom: 10px">
                    <label style="color: white; font-size: 20px">重置密码</label>
                </div>
                <s:form action="forgetpwd" id="myform" method="post" theme="simple" role="form">
                    <div class="form-group">
                        <input type="text" placeholder="手机号" id="phone" name="phoneNumber" style="border-radius: 5px" onblur="checkphone()" oninput="OnInput (event)" onpropertychange="OnPropChanged (event)" onclick="cleanphonetip()">
                        <span id="phonetip" style="font-size:14px;color: red; margin-left: 5px;visibility: hidden">* 请输入正确的手机号</span>
                    </div>
                    <div class="row form-group">
                        <input type="text" placeholder="验证码" id="verifycode" name="verifyCode" style="border-radius: 5px; width:230px; margin-left: 15px" onclick="cleancodetip()">
                        <button type="submit" class="btn" name="button" value="getMsg" id="getMsg" style="margin-left: 10px; width: 135px; height: 50px; background-color:darkblue;color: white; font-size: 15px;font-weight: bold" disabled>
                            获取验证码
                        </button>
                        <span id="codetip" style="font-size:14px;color: red;margin-left: 17px;visibility: hidden">* 验证码错误！</span>
                    </div>
                    <div class="form-group">
                        <input type="password" id="newPassword" placeholder="新密码" name="newPassword" style="border-radius: 5px" onblur="checknewpwd()" onclick="cleanpwdlength()">
                        <span id="pwdlength" style="font-size:14px;color: red; margin-left: 5px;visibility: hidden">* 密码长度应大于6位</span>
                    </div>
                    <div class="form-group">
                        <input type="password" placeholder="确认密码" id="secondPassword" name="secondPassword" style="border-radius: 5px" onblur="checkscdwpwd()" onclick="cleandefferent()">
                        <span id="different" style="font-size:14px;color: red; margin-left: 5px;visibility: hidden">* 两次密码不同！</span>
                    </div>
                    <button type="button" name="button" value="submit" class="site-btn text-center" style="background-color:green; font-size: 15px;align-content: center;width: 160px;margin-left: 120px" onclick="checkSubmit()">提交</button>
                </s:form>
                <div class="row">
                    <div class= "col-md-4" style="font-size: 15px;">
                        <a href="login.jsp" style="color: white; float: left;margin-left: 10px;text-decoration:underline">返&nbsp;&nbsp;&nbsp;回</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--修改密码失败-->
<div class="modal fade"  data-backdrop="static" id="changeError" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
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
                <p>密码修改失败！原密码即为正确密码</p>
            </div>
        </div>
    </div>
</div>
<!--修改密码失败-->
<div class="modal fade"  data-backdrop="static" id="sendSuccess" tabindex="-1" role="dialog" aria-labelledby="replySuccessTitle" aria-hidden="true">
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
                <p>验证码发送成功！</p>
            </div>
        </div>
    </div>
</div>

<div class="hero-slider owl-carousel">
    <div class="hs-item set-bg" data-setbg="img/hero-slider/1.jpg"></div>
    <div class="hs-item set-bg" data-setbg="img/hero-slider/2.jpg"></div>
    <div class="hs-item set-bg" data-setbg="img/hero-slider/3.jpg"></div>
</div>
<!-- Hero Section end -->

<!--====== Javascripts & Jquery ======-->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.slicknav.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
    var countdown = 60;
    function settime()
    {
        if(countdown === 0)
        {
            getMsg.removeAttribute("disabled");
            getMsg.innerHTML = "获取验证码";
            countdown = 60;
            return;
        } else
        {
            getMsg.setAttribute("disabled", true);
            getMsg.innerHTML = countdown + "s后重新获取";
            countdown--;
        }
        setTimeout(function() {
            settime()
        }, 1000)
    };
</script>
<%
    if("sendsuccess".equals(condition))
    {
        String phoneNumber=(String)session.getAttribute("phoneNumber");
%>
<script type="text/javascript">
    var p_phone="<%=phoneNumber%>";
    window.onload = function ()
    {
        $("#sendSuccess").modal();
    }
    var phone=document.getElementById("phone");
    phone.setAttribute("value",p_phone);
    settime();
</script>

<%
    }
    if("nophone".equals(condition))
    {
%>
<script type="text/javascript">
    phonetip.style.visibility="visible";
</script>
<%
}
else
{
%>
<script type="text/javascript">
    phonetip.style.visibility="hidden";
</script>
<%
        session.setAttribute("condition",null);
    }
%>
<script type="text/javascript">
    var vc="<%=code%>";
    function checkphone()
    {
        if((phone.value).length!==11)
        {
            phonetip.style.visibility="visible";
        }
        else
        {
            phonetip.style.visibility="hidden";
        }
    }
    function checkSubmit()
    {
        var pl = true;
        var dif = true;
        var cp=true;
        if ((newPassword.value).length <= 6)
        {
            pwdlength.style.visibility = "visible";
            pl = false;
        }
        else
        {
            pwdlength.style.visibility = "hidden";
        }
        if (!((newPassword.value) === (secondPassword.value)))
        {
            different.style.visibility = "visible";
            dif = false;
        }
        else
        {
            different.style.visibility = "hidden";
        }
        if(((verifycode.value).length===6)&&((verifycode.value)==vc))
        {
            codetip.style.visibility="hidden";
        }
        else
        {
            codetip.style.visibility="visible";
            cp=false;
        }
        if(pl==true && dif==true && cp==true)
        {
            $("#myform").submit();
        }
    }
    function cleanphonetip()
    {
        phonetip.style.visibility="hidden";
    }
    function cleanpwdlength()
    {
        pwdlength.style.visibility="hidden";
    }
    function cleandefferent()
    {
        different.style.visibility="hidden";
    }
    function cleancodetip()
    {
        codetip.style.visibility="hidden";
    }
    /*手机号输入正确获取验证码按钮有效*/
    function OnInput (event)
    {
        if((event.target.value).length===11)
        {
            $('#getMsg').attr("disabled",false);
        }
        else
        {
            $('#getMsg').attr("disabled",true);
        }

    }

    function OnPropChanged (event)
    {
        if (event.propertyName.toLowerCase () === "value")
        {
            if((event.target.value).length===11)
            {
                $('#getMsg').attr("disabled",false);
            }
            else
            {
                $('#getMsg').attr("disabled",true);
            }
        }
    };


</script>
<%
    if ("error".equals(condition))
    {
%>
<script>
    window.onload = function ()
    {
        $("#changeError").modal();
    }
</script>
<%
    }
    session.setAttribute("condition",null);
%>
</body>
</html>
