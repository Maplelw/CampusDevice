package servlet.user;

import com.alibaba.fastjson.JSONObject;
import service.UserService;
import service.impl.UserServiceImpl;
import utils.HttpUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CancelReservationServlet", urlPatterns = "/user/cancelReservation")
public class CancelReservationServlet extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        //设置编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        //获取参数
        int r_no = Integer.parseInt(request.getParameter("r_no"));

        //返回操作结果
        PrintWriter printWriter = response.getWriter();
        UserService userService = new UserServiceImpl();
        printWriter.write(userService.cancelReservation(r_no).toJSONString());
        printWriter.flush();
        printWriter.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost(request, response);
    }
}
