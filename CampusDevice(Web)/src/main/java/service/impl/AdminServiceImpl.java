package service.impl;

import bean.*;
import dao.*;
import dao.impl.*;
import service.AdminService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class AdminServiceImpl implements AdminService {
    private DeviceDao deviceDao = new DeviceDaoImpl();
    private ReservationDao reservationDao = new ReservationDaoImpl();
    private BorrowDao borrowDao = new BorrowDaoImpl();
    private ReturnDeviceDao returnDeviceDao = new ReturnDeviceDaoImpl();
    private FeedBackDao feedBackDao=new FeedBackDaoImpl();
    private AdminDao adminDao=new AdminDaoImpl();
    private UserDao userDao=new UserDaoImpl();
    private MessageDao messageDao=new MessageDaoImpl();
    private CreditRecordDao creditRecordDao=new CreditRecordDaoImpl();
    private CreditRuleDao creditRuleDao=new CreditRuleDaoImpl();
    private TrackDao trackDao=new TrackDaoImpl();

    /*
     * @Description: 通过标识获取管理员管辖范围内的有人预约的设备
     * @Param a_No
     * @Return: com.alibaba.fastjson.JSONObject
     */
    public List<Reservation> getReservationByPage(String a_no,int page)
    {
        //获取主键，通过主键查询
        List<Reservation> reservationList = reservationDao.handleReservation(a_no,page,6);

       /* if (reservationList.isEmpty())
        {
            info.put("flag", 0);
            errMsg.add("暂时没有预约中设备");
        }
        else
        {
            info.put("flag", 1);
            info.put("device", JSONArray.parseArray(JSON.toJSONString(reservationList)));
        }
        info.put("errMsg", errMsg);*/

        return reservationList;
    }

    /*
     * @Description: 获取某一个设备的预约队列
     * @Param deviceNo
     * @Return: com.alibaba.fastjson.JSONObject
     */
    public List<Reservation> getReservationDetail(String d_no)
    {
        List<Reservation> reservationList = reservationDao.handleReservationDetail(d_no);
        /*if (reservationList.isEmpty())
        {
            info.put("flag", 0);
            errMsg.add("该设备没有预约队列");
        }
        else
        {
            info.put("flag", 1);
            info.put("reservation", JSONArray.parseArray(JSON.toJSONString(reservationList)));
        }*/
        return reservationList;
    }
    public List<Reservation> handleReservationDetailBycd(String d_no)
    {
        List<Reservation> reservationList = reservationDao.handleReservationDetailBycd(d_no);
        return reservationList;
    }
    public List<Reservation> handleReservationDetailByst(String d_no)
    {
        List<Reservation> reservationList = reservationDao.handleReservationDetailByst(d_no);
        return reservationList;
    }

    /*
     * @Description: 管理员确认设备租借给某个用户
     * @Param u_no  d_no  borrowDate  returnDate
     * @Return: int
     */
    public int confirmBorrow(int r_no)
    {
        int flag=1;
        Reservation reservation = reservationDao.getReservation(r_no);
        String u_no = reservation.getU_no();
        String u_name = reservation.getU_name() + reservation.getU_type();
        String d_no = reservation.getD_no();
        String d_name = reservation.getD_name();
        String d_saveSite = reservation.getD_saveSite();
        String state = deviceDao.getDeviceState(d_no);

        //判断用户是否已取消预约
        if(reservationDao.getReservation(r_no).getR_state()==-2)
            flag=-4; //用户取消预约
            //判断是否已经确认借用给用户: 防止web端小程序端同时借用
        else if (reservation.getR_state() == 0 || reservation.getR_state() == 3)
        {
            System.out.println(state);
            if (state.equals("在库"))
            {
                String borrowDate = reservation.getR_startDate();
                String returnDate = reservation.getR_returnDate();

                // 预约状态置为1（成功）-> 设备状态修改外借 -> 借用表中插入记录
                flag = reservationDao.confirmReserve(r_no);
                if(flag==0)
                    return flag;
                flag = deviceDao.setDeviceState(d_no, "外借");
                if(flag==0)
                    return flag;
                flag = borrowDao.confirmBorrow(u_no, d_no, borrowDate, returnDate);
                if(flag==0)
                    return flag;
                flag = messageDao.sendMessage(u_no, u_name + "，管理员已批准你的预约，设备：" + d_name + "。请在今日内到" + d_saveSite + "领取设备");
                if(flag==0)
                    return flag;
            }
            else if(state.equals("损坏"))
            {
                flag=-1;  //设备损坏
            }
            else if(state.equals("报废"))
            {
                flag=-2;     //设备报废
            }
            else
            {
                flag=-3;    //设备已借出
            }
        }
        else
        {
            flag=-5;    //请求已被处理
        }
        return flag;
    }


    /*
     * @Description: 管理员拒绝租借给某个用户
     * @Param u_no  d_no
     * @Return: com.alibaba.fastjson.JSONObject
     */
    public int refuseBorrow(int r_no, String r_feedBack)
    {
        Reservation reservation = reservationDao.getReservation(r_no);
        String u_no = reservation.getU_no();
        String u_name = reservation.getU_name() + (reservation.getU_type().equals("学生") ? "同学" : "老师");
        String d_name = reservation.getD_name();
        int flag=1;
        //判断用户是否已取消预约
        if(reservationDao.getReservation(r_no).getR_state()==-2)
            flag=-4; //用户取消预约
            //判断是否已经确认拒绝租借给用户: 防止web端小程序端同时拒绝
        else if (reservation.getR_state() == 0 || reservation.getR_state() == 3)
        {
            flag = reservationDao.refuseReserve(r_no, r_feedBack);
            //反馈不为空
            if (r_feedBack != null)
            {
                flag = messageDao.sendMessage(u_no, u_name + "，你的预约：" + d_name + "被拒绝。请在我的预约中查看详情");
            }
        }
        else
        {
            flag=0;
        }
        return flag;
    }
    /*
     * @Description: 管理员编辑修改用户预约，开始协商
     * @Param r_no  startDate  endDate  feedBack
     * @Return: int
     */
    public int editReservation(int r_no, String startDate, String endDate, String feedBack)
    {
        Reservation reservation = reservationDao.getReservation(r_no);
        String u_no = reservation.getU_no();
        String u_name = reservation.getU_name() + reservation.getU_type();
        String d_name = reservation.getD_name();

        int flag = 1;
        //判断用户是否已取消预约
        if(reservationDao.getReservation(r_no).getR_state()==-2)
            flag=-4; //用户取消预约
            //判断是否已经确认借用给用户: 防止web端小程序端同时借用
        else if (reservation.getR_state() == 0 || reservation.getR_state() == 3)
        {
            //编辑预约，修改预约状态
            flag = reservationDao.editReservation(r_no, startDate, endDate, feedBack);
            //if (flag == 0)  errMsg.add("编辑修改预约失败");

            //向用户发送提示消息
            flag = messageDao.sendMessage(u_no, u_name + "，你有一条来自管理员的预约协商：" + d_name + "，请在我的预约中查看详情");
            //if (flag == 0) errMsg.add("发送提示消息失败");
        }
        else
        {
            flag = 0;
            //errMsg.add("该预约请求已被处理");
        }

        return flag;
    }

    /* @Description: 获取用户反馈信息队列
     * @Param null
     * @Return: ArrayList<FeedBack>
     */
    public List<FeedBack> getFeedBackByPage(int page)
    {
        return feedBackDao.getFeedbackByPage(page,6);
    }

    /*
     * @Description: 获取反馈信息总数
     * @Param null
     * @Return: int 反馈信息总数
     */
    public int getFeedbackSum()
    {
        return feedBackDao.getFeedbackSum();
    }

    /*
     * @Description: 获取所有未归还设备信息
     * @Param a_no
     * @Return: ArrayList<Borrow>
     */
    public List<Borrow> getBorrow(String a_no,int page)
    {
        borrowDao.setAllOverDueState();
        return borrowDao.getBorrowListByPage(a_no,page,6);
    }


    /*
     * @Description: 管理员确认用户归还设备
     * @Param wechatId  d_no
     * @Return: com.alibaba.fastjson.JSONObject
     */
    public int confirmReturn(ReturnDevice returnDevice)
    {
        Borrow borrow = borrowDao.getBorrowByNo(returnDevice.getB_no());
        String u_no = borrow.getU_no();
        User user = userDao.getUserByNo(returnDevice.getU_no());
        String u_name = user.getU_name() + (user.getU_type().equals("学生") ? "同学" : "老师");
        String d_no = borrow.getD_no();
        String d_name = deviceDao.getDeviceByNo(d_no).getD_name();
        Date now = new Date();
        Date returnDate = new Date();
        String nowDate = "";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try
        {
            returnDate = simpleDateFormat.parse(borrow.getB_returnDate());
            nowDate = simpleDateFormat.format(now);
        } catch (ParseException e)
        {
            e.printStackTrace();
        }
        int flag = 1;
        //判断是否已经确认设备归还: 防止web端小程序端同时确认归还
        int b_state = borrowDao.getBorrowByNo(returnDevice.getB_no()).getB_state();
        if (b_state == -1 || b_state == 0)
        {
            //及时归还
            if (borrow.getB_returnDate().compareTo(nowDate) >= 0)
            {
                flag = borrowDao.returnOnTime(returnDevice.getB_no());
                if(flag==0)
                    return 0;
            }
            //逾期归还
            else
            {
                flag = borrowDao.returnOutOfTime(returnDevice.getB_no());
                if(flag==0)
                    return 0;
            }
            flag = returnDeviceDao.returnDevice(returnDevice);
            if(flag==0)
                return 0; //归还设备失败
            //发送成功归还提示信息
            flag = messageDao.sendMessage(u_no, u_name + "，管理员已确认你归还设备：" + d_name + "，感谢你的合作");
            if (flag == 0)
            {
                return 0;//发送信息失败
            }
            //修改设备状态
            CreditRule creditRule = new CreditRule();
            switch (returnDevice.getRd_deviceState())
            {
                case "damaged":
                {
                    deviceDao.setDeviceState(d_no, "损坏");
                    creditRule = creditRuleDao.getCreditRule(6);
                    break;
                }
                case "scrapped":
                {
                    deviceDao.setDeviceState(d_no, "报废");
                    creditRule = creditRuleDao.getCreditRule(7);
                    break;
                }
                //正常归还
                default:
                {
                    deviceDao.setDeviceState(d_no, "在库");
                    creditRule = creditRuleDao.getCreditRule(1);
                    break;
                }
            }
            //添加信用记录
            System.out.println(creditRule.getCr_content());
            flag = creditRecordDao.updateCredit(u_no, creditRule.getCr_content(), user.getU_creditGrade(), creditRule.getCr_score());
            if (flag == 0)
                return 0; //更新用户信用记录失败

            //更新用户信誉分
            flag = userDao.updateCreditGrade(u_no, creditRule.getCr_score());
            if (flag == 0)
                return 0; //更新用户信用分失败

            //跟踪提醒
            List<String> trackingUserNoList = trackDao.getTrackingUserNoList(d_no);
            for (String userNo : trackingUserNoList)
            {
                flag = messageDao.sendMessage(userNo, "你跟踪的设备：" + d_name + "已经归还。如需借用，请及时预约");
                if (flag == 0)
                    return 0; //更新用户信用记录失败
            }

            //设备借用次数增长
            flag = deviceDao.addBorrowedTimes(d_no);
        }
        else
            return -1;//请求已被处理
        return flag;
    }

    /*
     * @Description:获取管理员个人资料
     * @Param a_no
     * @Return: Admin
     */
    public Admin getPersonalInfo(String a_no){
        return adminDao.getAdminByA_No(a_no);
    }

    /*
     * @Description: 获取管理设备的信息
     * @Param a_no管理员学工号 page:第几页设备
     * @Return: ArrayList<Device>
     */
    public ArrayList<Device> getDevices(String a_no,int page)
    {
        return deviceDao.getHotDeviceByPage(page,6,a_no);
    }

    /*
     * @Description: 获取设备总数
     * @Param a_no管理员学工号
     * @Return: int 设备总数
     */
    public int getDeviceSum(String a_no){
        return deviceDao.getDeviceSum(a_no);
    }

    /*
     * @Description: 录入设备
     * @Param Device
     * @Return: boolean
     */
    public boolean enterDevice(Device d){
        return deviceDao.enterDevice(d);
    }

    public List<Borrow> getOverDueList(String a_no,int page){
        return borrowDao.getOverDueList(a_no,page,6);
    }

    /*
     * @Description: 管理员回复用户的意见
     * @Param u_no,m_content,f_no
     * @Return: com.alibaba.fastjson.JSONObject
     */
    @Override
    public int respondToUserFeedback(String m_content, int f_no)
    {
        FeedBackDao feedbackDao = new FeedBackDaoImpl();
        return feedbackDao.respondToUserFeedback(m_content, f_no);
    }
    /*
     * @Description: 检验管理员身份
     * @Param name,password
     * @Return: int
     */
    @Override
    public int isAdmin(String name, String password) {
        AdminDao adminDao = new AdminDaoImpl();
        return adminDao.isAdmin(name,password);
    }

    /*
     * @Description: 管理员修改设备状态
     * @Param int
     * @Return: String
     */
    public int changeDeviceState(String d_no,String d_state)
    {
        return deviceDao.setDeviceState(d_no,d_state);
    }

    /*
     * @Description: 管理员删除设备
     * @Param int
     * @Return: String
     */
    public int deleteDevices(String d_no)
    {
        return deviceDao.deleteDevice(d_no);
    }

    /*
     * @Description: 获取逾期未换记录数量
     * @Param a_no
     * @Return: int
     */
    public int getOverdueSum(String a_no)
    {
        return borrowDao.getOverdueSum(a_no);
    }
    /*
     * @Description: 管理员更改密码
     * @Param newPassword
     * @Return: int
     */
    public int changePassword(String a_no,String newPassword)
    {
        return adminDao.changePassword(a_no, newPassword);
    }
    /*
     * @Description: 管理员获取用户信息
     * @Param null
     * @Return: null
     */
    public List<User> getUsers(int page)
    {
        return userDao.getUsersByPage(page,6);
    }
    /*
     * @Description: 获取用户总数
     * @Param null
     * @Return: int
     */
    public int getUserSum()
    {
        return userDao.getUserSum();
    }
    /*
     * @Description: 授权用户为管理员
     * @Param null
     * @Return: int
     */
    public int grantUser(String u_no)
    {
        User user=userDao.getUserByNo(u_no);
        return adminDao.grantUser(user);
    }
}
