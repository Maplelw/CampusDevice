package action;

import bean.Admin;
import bean.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import service.AdminService;
import service.impl.AdminServiceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class GrantAction extends ActionSupport
{
    private int page;
    private int sp=0;
    private String[] checkbox;

    public String getUsers()
    {
        ActionContext context = ActionContext.getContext();
        Map session = context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService=new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        List<User> users=new ArrayList<>();
        users=adminService.getUsers(page);
        int sum=adminService.getUserSum();
        System.out.println(sum);
        if(sp==0)
        {
            int startpage = 0;
            int endpage = 0;
            if(page>1)
            {
                if(page*6>=sum)
                {
                    startpage=page-3;
                    endpage =page;
                }
                else if((page+1)*6>=sum)
                {
                    startpage =page-2;
                    endpage =page+1;
                }
                else
                {
                    startpage=page-1;
                    endpage =page+2;
                }
                if(startpage<1)
                    startpage=1;
            }
            else
            {
                startpage =1;
                if(sum<=6)
                    endpage =1;
                else if(sum<=12)
                    endpage =2;
                else if(sum<=18)
                    endpage =3;
                else
                    endpage =4;
            }
            session.put("startpage", startpage);
            session.put("endpage", endpage);
        }
        else
        {
            session.put("startpage",sp);
            int ep=0;
            if (sp*6>=sum)
                ep=sp;
            else if ((sp+1)*6>=sum)
                ep=sp+1;
            else if ((sp+2)*6>=sum)
                ep=sp+2;
            else
                ep=sp+3;
            session.put("endpage",ep);
        }
        if(sum==0)
            session.put("maxpage",1);
        else if(sum%6==0)
            session.put("maxpage",sum/6);
        else
            session.put("maxpage",sum/6+1);
        session.put("page",page);
        session.put("users",users);
        return "success";
    }

    public String grantUser()
    {
        ActionContext context = ActionContext.getContext();
        Map session = context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        String condition="success";
        AdminService adminService=new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        int flag=0;
        try
        {
            for(String u_no: checkbox)
            {
                flag=adminService.grantUser(u_no);
                if(flag==0)
                {
                    condition="error";
                    session.put("condition",condition);
                    return "success";
                }
            }
            session.put("condition",condition);
            return "success";
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return "error";
    }

    public int getSp()
    {
        return sp;
    }

    public int getPage()
    {
        return page;
    }

    public void setSp(int sp)
    {
        this.sp = sp;
    }

    public void setPage(int page)
    {
        this.page = page;
    }

    public String[] getCheckbox()
    {
        return checkbox;
    }

    public void setCheckbox(String[] checkbox)
    {
        this.checkbox = checkbox;
    }
}
