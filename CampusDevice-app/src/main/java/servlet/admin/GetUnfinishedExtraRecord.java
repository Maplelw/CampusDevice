package servlet.admin;

import com.alibaba.fastjson.JSONObject;
import service.AdminService;
import service.impl.AdminServiceImpl;
import utils.HttpUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/admin/getUnfinishedExtraRecord")
public class GetUnfinishedExtraRecord extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JSONObject info = new JSONObject();
        PrintWriter printWriter = response.getWriter();

        String code = request.getParameter("code");
        int page = Integer.parseInt(request.getParameter("page"));
        AdminService adminService = new AdminServiceImpl();

        //向微信服务器接口发送code，获取用户唯一标识openid, 返回参数
        JSONObject result = JSONObject.parseObject(HttpUtils.sendGet(code));
        //请求成功,获取用户openid
        if (result.containsKey("openid"))
        {
            String wechatID = (String) result.get("openid");
            info = adminService.getUnfinishedExtraRecord(wechatID, page ,10);
        }
        //请求失败，返回错误信息
        else
        {
            info.put("errMsg", result.get("errmsg"));
            info.put("flag", "0");
        }

        printWriter.write(info.toJSONString());

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
