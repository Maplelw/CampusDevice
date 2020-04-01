package dao.impl;

import bean.User;
import dao.UserDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao
{
    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;

    /*
     * @Description: select:获取用户对象
     * @Param null
     * @Return: bean.User
     */
    public List<User> getUsersByPage(int page,int count)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        List<User> users=new ArrayList<>();
        try
        {
            con = JDBCUtils.getConnection();
            sql =   "SELECT * from user u LEFT JOIN specialty s \n" +
                    "ON u.s_no=s.s_no where u.u_wechatid NOT in(SELECT DISTINCT a_wechatid\n" +
                    "from administrator) limit ?,?";
            pStmt = con.prepareStatement(sql);
            pStmt.setInt(1,(page-1)*count);
            pStmt.setInt(2,count);

            //替换参数，从1开
            rs = pStmt.executeQuery();
            if (rs.next())
            {
                do
                {
                    User user = null;
                    user = new User(rs.getString("u_no"), rs.getString("u_name"), rs.getString("u_wechatid"), rs.getString("u_email"),
                            rs.getString("u_phone"), rs.getInt("u_credit_grade"), rs.getString("u_type"), rs.getString("u_mentor_name"),
                            rs.getString("u_mentor_phone"), rs.getInt("s_no"),rs.getString("s_name"));
                    users.add(user);
                }
                while (rs.next());
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
        return users;
    }

    /*
     * @Description: 获取用户总数
     * @Param null
     * @Return: int
     */
    public int getUserSum()
    {
        con = null;
        pStmt = null;
        rs = null;
        int sum=0;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql="select count(*) from user where u_wechatid NOT in(SELECT DISTINCT a_wechatid" +
                    "  from administrator)";
            pStmt=con.prepareStatement(sql);
            rs=pStmt.executeQuery();
            if(rs.next())
            {
                sum=rs.getInt(1);
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
        return sum;
    }


    /*
     * @Description: 通过用户学工号获取用户对象
     * @Param u_no
     * @Return: bean.User
     */
    public User getUserByNo(String u_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        User user = new User();
        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT * FROM user u  WHERE u_no = ?";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setString(1, u_no);
            rs = pStmt.executeQuery();

            if (rs.next())
            {
                user = new User(rs.getString("u_no"), rs.getString("u_name"), rs.getString("u_wechatid"), rs.getString("u_email"),
                        rs.getString("u_phone"), rs.getInt("u_credit_grade"), rs.getString("u_type"), rs.getString("u_mentor_name"),
                        rs.getString("u_mentor_phone"), rs.getInt("s_no"));
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
        return user;

    }

    /*
     * @Description: 更新增加或减少信誉分数
     * @Param score
     * @Return: int
     */
    public int updateCreditGrade(String u_no, int score)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "UPDATE user SET u_credit_grade = u_credit_grade + ? WHERE u_no = ?";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setInt(1, score);
            pStmt.setString(2, u_no);
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
     * @Description: 通过用户学号获取用户当前信用积分
     * @Param u_no
     * @Return: int
     */
    @Override
    public int getCreditScore(String u_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "select u_credit_grade from user WHERE u_no = ?";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setString(1, u_no);
            int score = pStmt.executeUpdate();
            return score;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return 0;
    }
}
