package service;

import bean.*;
import com.alibaba.fastjson.JSONObject;

import java.sql.ResultSet;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
public interface AdminService {

    /*
     * @Description: 通过学工号获取管理员管辖范围内的有人预约的设备
     * @Param a_No
     * @Return: com.alibaba.fastjson.JSONObject
     */
    List<Reservation> getReservationByPage(String a_No,int page);

    /*
     * @Description: 获取某一个设备的预约队列
     * @Param deviceNo
     * @Return: com.alibaba.fastjson.JSONObject
     */
    List<Reservation> getReservationDetail(String deviceNo);



    /*
     * @Description: 获取用户反馈信息队列
     * @Param null
     * @Return: ArrayList<FeedBack>
     */
    List<FeedBack> getFeedBackByPage(int page);

    /*
     * @Description: 获取所有未归还设备信息
     * @Param a_no
     * @Return: ArrayList<Borrow>
     */
     List<Borrow> getBorrow(String a_no,int page);

    /*
     * @Description: 管理员拒绝租借给某个用户
     * @Param u_no  d_no
     * @Return: com.alibaba.fastjson.JSONObject
     */
     int refuseBorrow(int r_no, String r_feedBack);
    /*
     * @Description: 管理员确认用户归还设备
     * @Param returnDevice
     * @Return: ReturnDevice
     */
    int confirmReturn(ReturnDevice returnDevice);

    /*
     * @Description: 管理员编辑修改用户预约，开始协商
     * @Param r_no  startDate  endDate  feedBack
     * @Return: com.alibaba.fastjson.JSONObject
     */
    int editReservation(int r_no, String startDate, String endDate, String feedBack);

    /*
     * @Description:获取管理员个人资料
     * @Param a_no
     * @Return: Admin
     */
    Admin getPersonalInfo(String a_no);

    /*
     * @Description: 获取管理设备的信息
     * @Param a_no管理员学工号 page:第几页设备
     * @Return: ArrayList<Device>
     */
    ArrayList<Device> getDevices(String a_no,int page);

    /*
     * @Description: 获取设备总数
     * @Param a_no管理员学工号
     * @Return: int 设备总数
     */
    int getDeviceSum(String a_no);

    /*
     * @Description: 获取反馈信息总数
     * @Param null
     * @Return: int 反馈信息总数
     */
    int getFeedbackSum();
    /*
     * @Description: 管理员确认设备租借给某个用户
     * @Param r_no
     * @Return: int
     */
    int confirmBorrow(int r_no);

    /*
     * @Description: 录入设备
     * @Param Device
     * @Return: boolean
     */
    boolean enterDevice(Device d);

    /*
     * @Description: 管理员获取所有逾期未换设备记录
     * @Param a_no
     * @Return: List<Borrow>
     */
    List<Borrow> getOverDueList(String a_no,int page);

    /*
     * @Description: 管理员回复用户的意见
     * @Param u_no,m_content,f_no
     * @Return: com.alibaba.fastjson.JSONObject
     */
    int respondToUserFeedback(String m_content, int f_no);
    /*
     * @Description: 检验管理员身份
     * @Param name,password
     * @Return: int
     */
    int isAdmin(String name,String password);
    /*
     * @Description: 管理员修改设备状态
     * @Param int
     * @Return: String
     */
    int changeDeviceState(String d_no,String d_state);
    /*
     * @Description: 管理员删除设备
     * @Param int
     * @Return: String
     */
    int deleteDevices(String d_no);
    List<Reservation> handleReservationDetailBycd(String d_no);
    List<Reservation> handleReservationDetailByst(String d_no);
    /*
     * @Description: 获取逾期未换记录数量
     * @Param a_no
     * @Return: int
     */
    int getOverdueSum(String a_no);
    /*
     * @Description: 管理员更改密码
     * @Param newPassword
     * @Return: int
     */
    int changePassword(String a_no,String newPassword);
    /*
     * @Description: 管理员获取用户信息
     * @Param null
     * @Return: null
     */
    List<User> getUsers(int page);
    /*
     * @Description: 获取用户总数
     * @Param null
     * @Return: int
     */
    int getUserSum();
    /*
     * @Description: 授权用户为管理员
     * @Param u_no
     * @Return: int
     */
    int grantUser(String u_no);


}
