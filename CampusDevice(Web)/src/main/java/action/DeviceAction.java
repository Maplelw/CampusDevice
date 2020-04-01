package action;

import bean.Admin;
import bean.Device;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import service.AdminService;
import service.impl.AdminServiceImpl;

import java.util.ArrayList;
import java.util.Map;

public class DeviceAction extends ActionSupport
{
    private Device device;
    private int page;   //从jsp页面传来的参数
    private int sp=0;
    private String[] checkbox;  //待修改设备的信息
    private String d_state; //修改的设备状态
    private String button;//选项
    /*
     * @Description: 管理员获取设备资料
     * @Param null
     * @Return:ArrayList<Device>
     */
    public String getDevices()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String a_no=((Admin)session.get("adm")).getA_no();
        ArrayList<Device> devices=new ArrayList<Device>();
        devices=adminService.getDevices(a_no,page);
        int sum=adminService.getDeviceSum(a_no);
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
        session.put("devices",devices);
        return "success";
    }

    /*
     * @Description: 管理员录入设备
     * @Param null
     * @Return: null
     */
    public String enterDevice()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String a_no=((Admin)session.get("adm")).getA_no();
        device.setA_no(a_no);
        boolean flag=adminService.enterDevice(device);
        String condition=null;
        if(flag)
        {
            condition="enterSuccess";
        }
        else
        {
            condition="enterFailed";
        }
        session.put("condition",condition);
        return "success";
    }

    /*
     * @Description: 管理员修改设备状态
     * @Param null
     * @Return: String
     */
    public String changeDevice()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String condition=null;
        int flag=0;
        try
        {
            for (String s : checkbox)
            {
                flag = adminService.changeDeviceState(s, d_state);
                if (flag == 0)
                {
                    condition="changeFailed";
                    session.put("condition",condition);
                    return "success";
                }
            }
            condition="changeSuccess";

            session.put("condition",condition);
            return "success";
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return "error";
    }

    public Device getDevice()
    {
        return device;
    }
    public void setDevice(Device device)
    {
        this.device=device;
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

    public void setCheckbox(String[] checkbox)
    {
        this.checkbox = checkbox;
    }

    public String[] getCheckbox()
    {
        return checkbox;
    }

    public String getD_state()
    {
        return d_state;
    }

    public void setD_state(String d_state)
    {
        this.d_state = d_state;
    }

    public String getButton()
    {
        return button;
    }

    public void setButton(String button)
    {
        this.button = button;
    }
}