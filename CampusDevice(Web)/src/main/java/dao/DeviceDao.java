package dao;

import bean.Device;
import com.alibaba.fastjson.JSONObject;

import java.util.ArrayList;

public interface DeviceDao {
    /*
     * @Description: 分页查询首页热门设备
     * @Param page  count
     * @Return: ArrayList<Device>
     */
    ArrayList<Device> getHotDeviceByPage(int page, int count,String a_no);

    /*
     * @Description: 获取设备状态
     * @Param d_no
     * @Return: java.lang.String
     */
    String getDeviceState(String d_no);

    /*
     * @Description: 改变设备状态
     * @Param d_no  d_state
     * @Return: int
     */
    int setDeviceState(String d_no, String d_state);

    /*
     * @Description: 设备借用次数增长
     * @Param d_no
     * @Return: int
     */
    int addBorrowedTimes(String d_no);
    
    /*
     * @Description: 获取设备总数
     * @Param a_no管理员学工号
     * @Return: int 设备总数
     */
    int getDeviceSum(String a_no);
    /*
     * @Description: 录入设备
     * @Param Device
     * @Return: boolean
     */
    boolean enterDevice(Device d);
    /*
     * @Description: 通过设备编号获取设备信息
     * @Param d_no
     * @Return: bean.Device
     */
    Device getDeviceByNo(String d_no);

    /*
     * @Description: 删除设备
     * @Param d_no
     * @Return: int
     */
    int deleteDevice(String d_no);

}
