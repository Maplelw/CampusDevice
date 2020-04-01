package action;

import bean.*;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import service.AdminService;
import java.lang.String;
import java.util.Map;
import service.impl.*;

public class MainAction extends ActionSupport
{
    private Admin adm=null;

    /*
     * @Description:管理员处理请求的execute方法
     * @Param null
     * @Return: String
     */
    public String execute()
    {
        ActionContext context = ActionContext.getContext();
        Map session = context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        Admin admin = null;
        admin=(Admin)session.get("adm");
        AdminService adminService = new AdminServiceImpl();
        String condition=null;
        if(adm!=null)
        {
            String a_no = adm.getA_no();
            String pwd = adm.getA_password();
            int flag = adminService.isAdmin(a_no,pwd);
            if(flag == 1)
            {
                admin = adminService.getPersonalInfo(a_no);
                session.put("adm", admin);
                return "success";
            }
            else
            {
                condition="error";
                session.put("condition",condition);
                return "error";
            }
        }
        else
            return "error";
    }


    public  Admin getAdm()
    {
        return adm;
    }
    public void setAdm(Admin adm)
    {
        this.adm=adm;
    }


}
