package action;

import bean.Admin;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import dao.AdminDao;
import dao.impl.AdminDaoImpl;
import org.apache.struts2.ServletActionContext;
import service.AdminService;
import service.impl.AdminServiceImpl;
import utils.MessageUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public class EditPersonalDataAction extends ActionSupport {

    private Admin adm;
    //用户页面的信息
    private String oldPassword;
    private String newPassword;
    private String secondPassword;
    private String verifyCode;
    private String newPhone;
    private String phoneNumber;
    private String button;
    private String newEmail;

    public String execute()
    {
        return Action.SUCCESS;
    }

    public EditPersonalDataAction()
    {
    }

    public String Edit()
    {
        ActionContext actionContext = ActionContext.getContext();
        Map session = actionContext.getSession();
        adm = (Admin)session.get("adm");
        if(adm==null)
            return "login";
        String condition="edituccess";
        Admin admin=new Admin();
        try
        {
            if(!(newPhone.equals(""))&&(!newEmail.equals("")))
                admin = new Admin(adm.getA_no(),adm.getA_password(),adm.getA_name(),adm.getA_wechatid(),adm.getA_type(),newPhone,newEmail);
            else if(!(newPhone.equals("")))
                admin = new Admin(adm.getA_no(),adm.getA_password(),adm.getA_name(),adm.getA_wechatid(),adm.getA_type(),newPhone,adm.getA_email());
            else if(!(newEmail.equals("")))
                admin = new Admin(adm.getA_no(),adm.getA_password(),adm.getA_name(),adm.getA_wechatid(),adm.getA_type(),adm.getA_phone(),newEmail);
            else
                return "success";

            AdminDao adminDao = new AdminDaoImpl();
            int flag = adminDao.changeAdmin(admin);
            if(flag > 0)
            {
                session.put("adm",admin);
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

    public String forgetPassword()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        ActionContext actionContext = ActionContext.getContext();
        Map session = actionContext.getSession();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String condition="";
        String inputVerifyCode = (String)session.get("inputVerifyCode");
        try
        {
            System.out.println(button);
            if("getMsg".equals(button))
            {
                AdminDao adminDao=new AdminDaoImpl();
                List<String> phones=adminDao.getPhones();
                System.out.println(phoneNumber);
                System.out.println(phones);
                if(!(phones.contains(phoneNumber)))
                {
                    condition="nophone";
                    session.put("condition",condition);
                    return "error";
                }
                String code=MessageUtils.sendVerifyCode(phoneNumber);
                System.out.println(code);
                session.put("inputVerifyCode",code);
                session.put("phoneNumber",phoneNumber);
                condition="sendsuccess";
                session.put("condition",condition);
                return "error";
            }
            else
            {
                AdminDao adminDao = new AdminDaoImpl();
                AdminService adminService = new AdminServiceImpl();
                String a_no=adminDao.getA_noByphone(phoneNumber);
                if(a_no==null)
                {
                    condition="nophone";
                    session.put("condition",condition);
                    return "error";
                }
                int flag=adminService.changePassword(a_no,newPassword);
                admin=adminService.getPersonalInfo(a_no);
                if (flag > 0)
                {
                    session.put("adm", admin);
                    //清除保留的验证码信息
                    session.put("inputVerifyCode", null);
                    condition="success";
                    session.put("condition",condition);
                    return "success";
                }
                else
                {
                    condition = "error";
                    session.put("condition", condition);
                    return "error";
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        session.remove("verifyCode");
        return "404";
    }
    //用户修改密码
    public String changePassword()
    {
        ActionContext actionContext = ActionContext.getContext();
        Map session = actionContext.getSession();
        AdminService adminService=new AdminServiceImpl();
        Admin admin=(Admin)session.get("adm");
        if(admin==null)
            return "login";
        String condition="success";
        int flag=0;
        adm = (Admin) session.get("adm");
        try
        {
            if(!(oldPassword.equals(adm.getA_password())))
            {
                condition="error";
                session.put("condition",condition);
                return "success";
            }
            flag = adminService.changePassword(adm.getA_no(), newPassword);
            adm=adminService.getPersonalInfo(adm.getA_no());
            session.put("adm",adm);
            if (flag > 0)
            {
                session.put("condition",condition);
                return "success";
            }
            else
            {
                condition="failed";
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

    public Admin getAdm()
    {
        return adm;
    }

    public void setAdm(Admin adm)
    {
        this.adm = adm;
    }

    public String getOldPassword()
    {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword)
    {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword()
    {
        return newPassword;
    }

    public void setNewPassword(String newPassword)
    {
        this.newPassword = newPassword;
    }

    public String getSecondPassword()
    {
        return secondPassword;
    }

    public void setSecondPassword(String secondPassword)
    {
        this.secondPassword = secondPassword;
    }

    public String getVerifyCode()
    {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode)
    {
        this.verifyCode = verifyCode;
    }

    public String getNewPhone()
    {
        return newPhone;
    }

    public void setNewPhone(String newPhone)
    {
        this.newPhone = newPhone;
    }

    public String getPhoneNumber()
    {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber)
    {
        this.phoneNumber = phoneNumber;
    }

    public void setButton(String button)
    {
        this.button = button;
    }

    public String getButton()
    {
        return button;
    }

    public String getNewEmail()
    {
        return newEmail;
    }

    public void setNewEmail(String newEmail)
    {
        this.newEmail = newEmail;
    }
}