package dao.impl;

import bean.Message;
import dao.MessageDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MessageDaoImpl implements MessageDao
{
    private PreparedStatement pStmt;
    private ResultSet rs;
    private Connection con;
    private String sql;
    /*
     * @Description: 系统向用户发送消息
     * @Param u_no  m_content
     * @Return: int
     */
    public int sendMessage(String u_no, String m_content)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            //刚发的message的状态为未读
            sql = "INSERT INTO message(u_no, m_content, m_date, m_state) " +
                    "VALUES (?, ?, CURRENT_DATE,0)";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setString(1, u_no);
            pStmt.setString(2, m_content);

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
