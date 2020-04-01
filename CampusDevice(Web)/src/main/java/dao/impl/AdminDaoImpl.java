package dao.impl;

import bean.Admin;
import bean.User;
import dao.AdminDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDaoImpl implements AdminDao {
    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;

    /*
     * @Description: 通过学工号唯一标识获取管理员信息
     * @Param a_no
     * @Return: bean.Admin
     */
    public Admin getAdminByA_No(String a_no)
    {
        con = null;
        pStmt = null;
        rs = null;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "select * from administrator where a_no = ?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1,a_no);
            rs = pStmt.executeQuery();

            if (rs.next())
            {
                return new Admin(rs.getString("a_no"), rs.getString("a_password"),rs.getString("a_name"), rs.getString("a_wechatid"),
                        rs.getString("a_type"), rs.getString("a_phone"), rs.getString("a_email"));
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
        return null;

    }
    //判断管理员身份是否正确
    @Override
    public int isAdmin(String name, String password) {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "select a_no,a_password from administrator";
            pStmt = con.prepareStatement(sql);

            rs = pStmt.executeQuery();

            while (rs.next())
            {
                if(rs.getString(1).equals(name) && rs.getString(2).equals(password))
                {
                    return 1;
                }
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
        return 0;
    }
    @Override
    public int changeAdmin(Admin admin) {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "update administrator set a_password=?,a_name=?,a_phone=?,a_email=? where a_no=?";
            pStmt = con.prepareStatement(sql);

            pStmt.setString(1,admin.getA_password());
            pStmt.setString(2,admin.getA_name());
            pStmt.setString(3,admin.getA_phone());
            pStmt.setString(4,admin.getA_email());
            pStmt.setString(5,admin.getA_no());
            int flag = pStmt.executeUpdate();
            return flag;
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
    /*
     * @Description: 管理员授权用户
     * @Param User
     * @Return: int
     */
    public int grantUser(User user)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag=0;
        try
        {
            con=JDBCUtils.getConnection();
            sql="INSERT into administrator\n" +
                    "VALUES(?,MD5(?),?,?,'院统管',?,?)";
            pStmt=con.prepareStatement(sql);
            pStmt.setString(1,user.getU_no());
            pStmt.setString(2,user.getU_no());
            pStmt.setString(3,user.getU_name());
            pStmt.setString(4,user.getU_wechatID());
            pStmt.setString(5,user.getU_phone());
            pStmt.setString(6,user.getU_email());
            flag=pStmt.executeUpdate();
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
    //更改管理员密码
    public int changePassword(String a_no,String newPassword)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "update administrator \n" +
                    "set a_password=MD5(?)\n" +
                    "WHERE a_no=?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1,newPassword);
            pStmt.setString(2,a_no);
            return pStmt.executeUpdate();
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

    /*
     * @Description:获取所有管理员手机号
     * @Param null
     * @Return: List<String>
     */
    public List<String> getPhones()
    {
        con = null;
        pStmt = null;
        rs = null;
        List<String> phones=new ArrayList<>();
        try
        {
            con = JDBCUtils.getConnection();
            sql = "select a_phone from administrator";
            pStmt = con.prepareStatement(sql);
            rs=pStmt.executeQuery();
            if(rs.next())
            {
                do
                {
                    String phone=rs.getString(1);
                    phones.add(phone);
                }while (rs.next());
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
        return phones;
    }
    /*
     * @Description: 通过手机号获取管理员
     * @Param phone
     * @Return: String
     */
    public String getA_noByphone(String phone)
    {
        con = null;
        pStmt = null;
        rs = null;
        String a_no=null;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "select a_no from administrator " +
                    "where a_phone=?";
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1,phone);
            rs=pStmt.executeQuery();
            if(rs.next())
            {
                a_no=rs.getString(1);
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
        return a_no;
    }
}
