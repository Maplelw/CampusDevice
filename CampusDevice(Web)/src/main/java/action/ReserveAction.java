package action;

import bean.Admin;
import bean.Device;
import bean.Reservation;
import bean.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import dao.ReservationDao;
import dao.impl.ReservationDaoImpl;
import service.AdminService;
import service.impl.AdminServiceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ReserveAction extends ActionSupport
{
    private Device device;
    private User user;
    private int r_no;     //预约编号
    private String r_feedback; //拒绝预约原因
    private String startDate;
    private String endDate;
    private String feedBack; //调整时间原因
    private int page;
    private int sp=0;

    /*
     * @Description:获取已预约设备队列
     * @Param null
     * @Return: String
     */
    public String getReservation() throws Exception
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String a_no=((Admin)session.get("adm")).getA_no();
        List<Reservation> rsrvdevicelist=new ArrayList<>();
        ReservationDao reservationDao=new ReservationDaoImpl();
        int sum=0;
        try
        {
            rsrvdevicelist=adminService.getReservationByPage(a_no,page);
            sum=reservationDao.getReserveDeviceSum(a_no);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
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
        session.put("rsrvdevicelist",rsrvdevicelist);
        return "success";
    }
    /*
     * @Description: 获取某一设备详细预约信息
     * @Param null
     * @Return: String
     */
    public String getReservationDetail()
    {
        String d_no=device.getD_no();
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        session.put("d_no",d_no);
        AdminService adminService = new AdminServiceImpl();
        List<Reservation> reservationlist=adminService.getReservationDetail(d_no);
        session.put("rsrvlist",reservationlist);
        return "success";
    }
    /*
     * @Description: 获取某一设备详细预约信息按照信用分高低
     * @Param null
     * @Return: String
     */
    public String getReservationDetailBycd()
    {
        String d_no=device.getD_no();
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        List<Reservation> reservationlist=adminService.handleReservationDetailBycd(d_no);
        session.put("rsrvlist",reservationlist);
        return "success";
    }
    /*
     * @Description: 获取某一设备详细预约信息按照信用分高低
     * @Param null
     * @Return: String
     */
    public String getReservationDetailByst()
    {
        String d_no=device.getD_no();
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        List<Reservation> reservationlist=adminService.handleReservationDetailByst(d_no);
        session.put("rsrvlist",reservationlist);
        return "success";
    }

    /*
     * @Description: 同意用户的预约请求
     * @Param null
     * @Return: String
     */

    public String AgreeReservation()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        System.out.println(r_no);
        int flag=adminService.confirmBorrow(r_no);
        String condition="operateSuccess";
        if(flag==0)
        {
            condition="operateFailed";
        }
        else if(flag==-1)
        {
            condition= "damaged";
        }
        else if(flag==-2)
        {
            condition= "scrapped";
        }
        else if(flag==-3)
        {
            condition= "borrowed";
        }
        else if(flag==-4)
        {
            condition="canceled";
        }
        else if (flag==-5)
        {
            condition="handled";
        }
        session.put("condition",condition);
        return "success";
    }

    /*
     * @Description: 用户拒绝预约请求
     * @Param null
     * @Return: null
     */
    public String RefuseReservation()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        int flag=adminService.refuseBorrow(r_no,r_feedback);
        String condition="operateSuccess";
        if(flag==0)
        {
            condition="operateFailed";
        }
        else if(flag==-4)
        {
            condition="canceled";
        }
        session.put("condition",condition);
        return "success";
    }
    /*
     * @Description: 管理员编辑修改用户预约，开始协商
     * @Param null
     * @Return: String
     */
    public String editReservation()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        int flag=adminService.editReservation(r_no,startDate,endDate,feedBack);
        String condition="operateSuccess";
        if(flag==0)
        {
            condition="operateFailed";
        }
        else if(flag==-4)
        {
            condition="canceled";
        }
        session.put("condition",condition);
        return "success";
    }

    public Device getDevice()
    {
        return device;
    }
    public void setDevice(Device device)
    {
        this.device=device;
    }

    public User getUser()
    {
        return user;
    }
    public void setUser(User user)
    {
        this.user=user;
    }

    public int getR_no()
    {
        return r_no;
    }

    public void setR_no(int r_no)
    {
        this.r_no = r_no;
    }

    public String getR_feedback()
    {
        return r_feedback;
    }

    public void setR_feedback(String r_feedback)
    {
        this.r_feedback = r_feedback;
    }

    public String getStartDate()
    {
        return startDate;
    }

    public String getEndDate()
    {
        return endDate;
    }

    public void setStartDate(String startDate)
    {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate)
    {
        this.endDate = endDate;
    }

    public String getFeedBack()
    {
        return feedBack;
    }

    public void setFeedBack(String feedBack)
    {
        this.feedBack = feedBack;
    }

    public void setSp(int sp)
    {
        this.sp = sp;
    }

    public int getPage()
    {
        return page;
    }

    public int getSp()
    {
        return sp;
    }

    public void setPage(int page)
    {
        this.page = page;
    }
}
