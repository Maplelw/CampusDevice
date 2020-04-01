package action;

import bean.Admin;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import utils.ExcelUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class ExportAction extends ActionSupport{
    //获取输出excel表的管理员
    private Admin admin;
    //提供给struts的配置文件使用
    private InputStream inputStream;
    // 保存时的文件名
    private String fileName;

    public ExportAction(){

    }

    public String execute(){
        return Action.SUCCESS;
    }

    public String export() throws UnsupportedEncodingException {
        String downloadPath = ServletActionContext.getServletContext().getRealPath("/download");
        //获取当前日期
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String fileSaveName = sdf.format(date);
        //获取当前管理员
        ActionContext context= ActionContext.getContext();
        Map session=context.getSession();
        admin = (Admin)session.get("adm");
        if(admin==null)
            return "login";
        //将文件名以管理员+date命名
        fileSaveName = admin.getA_name()+fileSaveName+".xlsx";
        fileName = new String(fileSaveName.getBytes(),"ISO8859-1");
        //创建这个文件夹
        File file = new File(downloadPath);
        if(!file.exists())
        {
            file.mkdirs();
        }
        //在路径生成该文件
        ExcelUtils.dbToExcel(downloadPath,fileSaveName,admin.getA_no());
        try
        {
            inputStream = new FileInputStream(new File(downloadPath,fileSaveName));
            return "success";

        }
        catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}

