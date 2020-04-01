package dao;

import bean.ReturnDevice;
import com.alibaba.fastjson.JSONObject;

public interface ReturnDeviceDao {

    /*
     * @Description: 归还设备
     * @Param returnDevice
     * @Return: int
     */
    int returnDevice(ReturnDevice returnDevice);
}
