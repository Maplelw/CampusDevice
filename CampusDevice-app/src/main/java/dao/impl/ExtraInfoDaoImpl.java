package dao.impl;

import bean.ExtraInfo;
import bean.Reservation;
import dao.ExtraInfoDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ExtraInfoDaoImpl implements ExtraInfoDao {

    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;

    @Override
    public int addExtraInfo(String name,String info,String d_no) {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "INSERT INTO extra_info (ei_date,ei_name,ei_info,ei_state,d_no) VALUES ( CURRENT_DATE, ?, ?, 0, ?)";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, name);
            pStmt.setString(2, info);
            pStmt.setString(3, d_no);
            flag = pStmt.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(null, pStmt, con);
        }
        return flag;
    }

    @Override
    public int setReturnedByNo(int ei_no) {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int flag = 0;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "update extra_info set ei_state = 1 where ei_no = ?";
            pStmt = con.prepareStatement(sql);
            pStmt.setInt(1, ei_no);
            flag = pStmt.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(null, pStmt, con);
        }
        return flag;
    }

    @Override
    public List<ExtraInfo> getFinishedExtraRecord(String a_no,int page,int count) {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int flag = 0;
        List<ExtraInfo> list = new ArrayList<>();
        try
        {
            con = JDBCUtils.getConnection();
            sql = "select ei_no,ei_name,ei_date,ei_info,ei_state,e.d_no,d_name " +
                  "from extra_info e,device d where e.d_no = d.d_no and d.a_no = ? and ei_state = 1 " +
                  "limit ?,?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, a_no);
            pStmt.setInt(2,(page-1) * count);
            pStmt.setInt(3,count);
            rs = pStmt.executeQuery();

            while (rs.next())
            {
                ExtraInfo extraInfo = new ExtraInfo();
                extraInfo.setEi_no(rs.getInt("ei_no"));
                extraInfo.setEi_name(rs.getString("ei_name"));
                extraInfo.setEi_date(rs.getString("ei_date"));
                extraInfo.setEi_info(rs.getString("ei_info"));
                extraInfo.setEi_state(rs.getInt("ei_state"));
                extraInfo.setD_no(rs.getString("d_no"));
                extraInfo.setD_name(rs.getString("d_name"));
                list.add(extraInfo);
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(null, pStmt, con);
        }
        return list;
    }

    @Override
    public List<ExtraInfo> getUnfinishedExtraRecord(String a_no,int page,int count) {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int flag = 0;
        List<ExtraInfo> list = new ArrayList<>();
        try
        {
            con = JDBCUtils.getConnection();
            sql = "select ei_no,ei_name,ei_date,ei_info,ei_state,e.d_no,d_name " +
                    "from extra_info e,device d where e.d_no = d.d_no and d.a_no = ? and ei_state = 0 " +
                    "limit ?,?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, a_no);
            pStmt.setInt(2,(page-1) * count);
            pStmt.setInt(3,count);
            rs = pStmt.executeQuery();

            while (rs.next())
            {
                ExtraInfo extraInfo = new ExtraInfo();
                extraInfo.setEi_no(rs.getInt("ei_no"));
                extraInfo.setEi_name(rs.getString("ei_name"));
                extraInfo.setEi_date(rs.getString("ei_date"));
                extraInfo.setEi_info(rs.getString("ei_info"));
                extraInfo.setEi_state(rs.getInt("ei_state"));
                extraInfo.setD_no(rs.getString("d_no"));
                extraInfo.setD_name(rs.getString("d_name"));
                list.add(extraInfo);
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(null, pStmt, con);
        }
        return list;
    }
}
