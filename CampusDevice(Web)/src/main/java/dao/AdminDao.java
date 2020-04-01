package dao;

import bean.Admin;
import bean.User;

import java.util.List;

public interface AdminDao {

    Admin getAdminByA_No(String wechatID);
    //判断管理员身份是否正确
    int isAdmin(String name,String password);
    //更改管理员的部分数据
    int changeAdmin(Admin admin);
    /*
     * @Description: 管理员更改密码
     * @Param newPassword
     * @Return: int
     */
    int changePassword(String a_no,String newPassword);
    /*
     * @Description: 管理员授权用户
     * @Param User
     * @Return: int
     */
    int grantUser(User user);
    /*
     * @Description:获取所有管理员手机号
     * @Param null
     * @Return: List<String>
     */
    List<String> getPhones();
    /*
     * @Description: 通过手机号获取管理员
     * @Param phone
     * @Return: Admin
     */
    String getA_noByphone(String phone);


}
