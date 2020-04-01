package action;

import bean.Admin;
import bean.Borrow;
import bean.ReturnDevice;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import dao.BorrowDao;
import dao.impl.BorrowDaoImpl;
import service.AdminService;
import service.impl.AdminServiceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ReturnAction extends ActionSupport
{
    private ReturnDevice returnDevice;
    private int page;
    private int sp=0;
    /*
     * @Description: 获取带确认归还设备信息
     * @Param null
     * @Return: String
     */
    public String getTobereturned()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String a_no=((Admin)session.get("adm")).getA_no();
        List<Borrow> borrows= new ArrayList<Borrow>();
        borrows=adminService.getBorrow(a_no,page);
        BorrowDao borrowDao=new BorrowDaoImpl();
        int sum=borrowDao.getTobeReturnedSum(a_no);
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
        session.put("borrows",borrows);
        return "success";
    }

    /*
     * @Description: 管理员确认归还完好设备
     * @Param null
     * @Return: null
     */
    public String confirmReturn()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        int flag=adminService.confirmReturn(returnDevice);
        String condition="operateSuccess";
        if(flag==0)
        {
            condition="operateFailed";
        }
        else if(flag==-1)
        {
            condition="done";
        }
        session.put("condition",condition);
        return "success";
    }
    public ReturnDevice getReturnDevice()
    {
        return returnDevice;
    }

    public void setReturnDevice(ReturnDevice returnDevice)
    {
        this.returnDevice = returnDevice;
    }
    public void setPage(int page)
    {
        this.page=page;
    }
    public int getPage()
    {
        return page;
    }

    public int getSp()
    {
        return sp;
    }

    public void setSp(int sp)
    {
        this.sp = sp;
    }

}
