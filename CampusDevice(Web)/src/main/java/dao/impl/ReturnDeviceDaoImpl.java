package dao.impl;

import bean.Admin;
import bean.ReturnDevice;
import dao.ReturnDeviceDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReturnDeviceDaoImpl implements ReturnDeviceDao {
    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;
    /*
     * @Description: 归还设备
     * @Param u_no  d_no
     * @Return: com.alibaba.fastjson.JSONObject
     */
    public int returnDevice(ReturnDevice returnDevice)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int flag = 0;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "INSERT INTO return_device(u_no, d_no, b_no, rd_date, rd_device_state, rd_comment) " +
                    "VALUES (?,?,?, CURRENT_DATE ,?,?)";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1,returnDevice.getU_no());
            pStmt.setString(2,returnDevice.getD_no());
            pStmt.setInt(3,returnDevice.getB_no());
            pStmt.setString(4,returnDevice.getRd_deviceState());
            pStmt.setString(5,returnDevice.getRd_comment());
            flag = pStmt.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return flag;
    }
}
