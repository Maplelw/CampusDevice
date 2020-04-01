package dao.impl;

import bean.Device;
import com.alibaba.fastjson.JSONObject;
import dao.DeviceDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class DeviceDaoImpl implements DeviceDao {
    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;
    /*
     * @Description: 分页查询首页热门设备
     * @Param page:页数，第几页  count：每页设备数量 a_no:管理该设备的管理员的学工号
     * @Return: java.util.List<bean.Device>
     */
    public ArrayList<Device> getHotDeviceByPage(int page, int count,String a_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        ArrayList<Device> devices=new ArrayList<Device>();
        ResultSet rs=null;
        try {
            sql = "select * from device " +
                    "where a_no=? order by d_no desc limit ?,?";
            con=JDBCUtils.getConnection();
            pStmt=con.prepareStatement(sql);
            pStmt.setString(1,a_no);
            pStmt.setInt(2,(page-1)*count);
            pStmt.setInt(3,count);
            rs= pStmt.executeQuery();
            //判断是否存在记录
            if (rs.next())
            {
                do {
                    devices.add(
                            new Device(rs.getString("d_no"), rs.getString("a_no"), rs.getString("d_state"), rs.getInt("d_borrowed_times"),
                                    rs.getString("d_name"),rs.getString("d_save_site"),rs.getString("d_factory_no"),rs.getString("d_store_date"),rs.getString("d_model"))
                    );
                }
                while (rs.next());
                rs.close();
            }
            else
            {
                devices=null;
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs,pStmt,con);
        }
        return devices;
    }
    /*
     * @Description: 获取设备状态
     * @Param d_no
     * @Return: java.lang.String
     */
    public String getDeviceState(String d_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        String result = "";
        try
        {
            con = JDBCUtils.getConnection();
            String sql = "SELECT d_state FROM device WHERE d_no= ?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, d_no);

            //查询
            rs = pStmt.executeQuery();
            if (rs.next())
            {
                result = rs.getString("d_state");
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return result;
    }
    /*
     * @Description: 删除设备
     * @Param d_no
     * @Return: int
     */
    public int deleteDevice(String d_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int flag=0;
        String result = "";
        try
        {
            con = JDBCUtils.getConnection();
            String sql = "DELETE from device where d_no= ?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, d_no);

            //查询
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
    /*
     * @Description: 获取设备总数
     * @Param a_no管理员学工号
     * @Return: int 设备总数
     */
    public int getDeviceSum(String a_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int sum=0;
        try
        {
            con=JDBCUtils.getConnection();
            String sql="SELECT COUNT(*) sum from device\n" +
                    "WHERE a_no=?";
            pStmt=con.prepareStatement(sql);
            pStmt.setString(1,a_no);
            rs= pStmt.executeQuery();
            if(rs.next())
            {
                sum=rs.getInt("sum");
            }
            rs.close();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs,pStmt,con);
        }
        return sum;
    }


    /*
     * @Description: 改变设备状态
     * @Param state  d_no
     * @Return: int
     */
    public int setDeviceState(String d_no, String d_state)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            String sql = "UPDATE device SET d_state = ? WHERE d_no = ?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, d_state);
            pStmt.setString(2, d_no);

            //更新状态
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

    /*
     * @Description: 设备借用次数增长
     * @Param d_no
     * @Return: int
     */
    public int addBorrowedTimes(String d_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "UPDATE device SET d_borrowed_times = d_borrowed_times+1 WHERE d_no = ?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, d_no);

            //更新状态
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

    /*
     * @Description: 录入设备
     * @Param Device
     * @Return: boolean
     */
    public boolean enterDevice(Device d)
    {
        con = null;
        pStmt = null;
        rs = null;
        int count=0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "INSERT INTO device(d_no,d_name,d_model,d_save_site,a_no,d_factory_no,d_state,d_store_date)\n" +
                    "VALUES(?,?,?,?,?,?,?,?)";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setString(1,d.getD_no());
            pStmt.setString(2,d.getD_name());
            pStmt.setString(3,d.getD_model());
            pStmt.setString(4,d.getD_saveSite());
            pStmt.setString(5,d.getA_no());
            pStmt.setString(6,d.getD_factoryNo());
            pStmt.setString(7,d.getD_state());
            pStmt.setString(8,d.getD_storeDate());
            count = pStmt.executeUpdate();

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return count != 0;
    }
    /*
     * @Description: 通过设备编号获取设备信息
     * @Param d_no
     * @Return: bean.Device
     */
    public Device getDeviceByNo(String d_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        Device device = new Device();

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT * FROM device WHERE d_no = ?";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setString(1, d_no);
            rs = pStmt.executeQuery();

            if (rs.next())
            {
                device.setD_no(rs.getString("d_no"));
                device.setD_name(rs.getString("d_name"));
                device.setD_model(rs.getString("d_model"));
                device.setD_saveSite(rs.getString("d_save_site"));
                device.setA_no(rs.getString("a_no"));
                device.setD_factoryNo(rs.getString("d_factory_no"));
                device.setD_state(rs.getString("d_state"));
                device.setD_storeDate(rs.getString("d_store_date"));
                device.setD_borrowedTimes(rs.getInt("d_borrowed_times"));
                device.setD_photo(rs.getString("d_photo"));
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return device;
    }

}
