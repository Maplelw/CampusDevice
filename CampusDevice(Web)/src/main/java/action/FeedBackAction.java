package action;

import bean.*;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import service.AdminService;
import java.lang.String;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import service.impl.*;

public class FeedBackAction extends ActionSupport
{
    private String m_content;
    private int f_no;
    private int page;
    private int sp=0;

    /*
     * @Description: 查看反馈信息
     * @Param null
     * @Return: null
     */
    public String GetFeedback()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        List<FeedBack> feedBacks=new ArrayList<FeedBack>();
        feedBacks=adminService.getFeedBackByPage(page);
        int sum=adminService.getFeedbackSum();
        if(sp==0){
            int startpage = 0;
            int endpage = 0;
            if(page>1){
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
        session.put("feedbacks",feedBacks);
        return "success";
    }
    /*
     * @Description: 管理员回复用户信息
     * @Param m_content f_no
     * @Return: String
     */
    public String respondToUserFeedback()
    {
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();  //获得会话对象，用来保存当前登录用户的信息
        AdminService adminService = new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String condition="replySuccess";
        try
        {
            int flag=adminService.respondToUserFeedback(m_content,f_no);
            if(flag==0)
            {
                condition="replyError";
                session.put("condition",condition);
                return "success";
            }
            else
            {
                session.put("condition",condition);
                return "success";
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return "error";
    }

    public int getF_no()
    {
        return f_no;
    }

    public String getM_content()
    {
        return m_content;
    }

    public void setM_content(String m_content)
    {
        this.m_content = m_content;
    }

    public void setF_no(int f_no)
    {
        this.f_no = f_no;
    }

    public int getSp()
    {
        return sp;
    }

    public int getPage()
    {
        return page;
    }

    public void setPage(int page)
    {
        this.page = page;
    }

    public void setSp(int sp)
    {
        this.sp = sp;
    }
}
