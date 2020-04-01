package bean;

import java.util.Date;

public class FeedBack {
    int f_no;
    String u_no;
    String f_content;
    String f_date;

    //扩展属性
    String u_name;
    public FeedBack()
    {

    }
    public FeedBack(int f_no, String u_no,String u_name, String fb_content, String fb_date)
    {
        this.f_no = f_no;
        this.u_no = u_no;
        this.f_content = fb_content;
        this.f_date = fb_date;
        this.u_name=u_name;
    }
    public FeedBack(int f_no, String u_no,String fb_content, String fb_date)
    {
        this.f_no = f_no;
        this.u_no = u_no;
        this.f_content = fb_content;
        this.f_date = fb_date;
    }

    public int getF_no(){
        return f_no;
    }
    public void setF_no(int f_no){
        this.f_no=f_no;
    }
    public String getU_no(){
        return u_no;
    }
    public void setU_no(String u_no){
        this.u_no=u_no;
    }
    public String getF_content(){
        return f_content;
    }
    public void setF_content(String f_content){
        this.f_content=f_content;
    }
    public String getF_date(){
        return f_date;
    }
    public void setF_date(String f_date){
        this.f_date=f_date;
    }

    public String getU_name()
    {
        return u_name;
    }

    public void setU_name(String u_name)
    {
        this.u_name = u_name;
    }
}
