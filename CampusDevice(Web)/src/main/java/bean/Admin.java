package bean;

/*
 * 管理员表
 */
public class Admin
{

    //管理员_学工号
    private String a_no;
    //管理员_姓名
    private String a_name;
    //管理员_密码
    private  String a_password;
    //管理员_微信号
    private String a_wechatId;
    //管理员_邮箱
    private String a_email;
    //管理员_手机号
    private String a_phone;
    //管理员_类型
    private String a_type;
    public Admin()
    {
    }
    public Admin(String a_no, String a_password, String a_name, String a_wechatid, String a_type, String a_phone , String a_email )
    {
        this.a_email=a_email;
        this.a_name=a_name;
        this.a_no=a_no;
        this.a_password=a_password;
        this.a_phone=a_phone;
        this.a_type=a_type;
        this.a_wechatId=a_wechatid;
    }

    public String getA_no()
    {
        return a_no;
    }

    public void setA_no(String a_no)
    {
        this.a_no = a_no;
    }

    public String getA_name()
    {
        return a_name;
    }

    public void setA_name(String a_name)
    {
        this.a_name = a_name;
    }

    public String getA_wechatid()
    {
        return a_wechatId;
    }

    public void setA_wechatid(String a_wechatid)
    {
        this.a_wechatId = a_wechatid;
    }

    public String getA_email()
    {
        return a_email;
    }

    public void setA_email(String a_email)
    {
        this.a_email = a_email;
    }

    public String getA_phone()
    {
        return a_phone;
    }

    public void setA_phone(String a_phone)
    {
        this.a_phone = a_phone;
    }

    public String getA_type()
    {
        return a_type;
    }

    public void setA_type(String u_type)
    {
        this.a_type = a_type;
    }

    public String getA_password()
    {
        return a_password;
    }

    public void setA_password(String a_password)
    {
        this.a_password = a_password;
    }

    @Override
    public String toString()
    {
        return "Admin[" +
                "a_no='" + a_no + '\"' +
                ", a_name=\"" + a_name + '\"' +
                ", a_wechatId=\"" + a_wechatId + '\"' +
                ", a_type=\"" + a_type + '\"' +
                ", a_phone=\"" + a_phone + '\"' +
                ", a_emial=\"" + a_email + '\"' +
                ']';
    }
}

