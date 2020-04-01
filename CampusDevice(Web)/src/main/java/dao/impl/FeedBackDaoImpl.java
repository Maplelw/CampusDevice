package dao.impl;
import bean.FeedBack;
import dao.FeedBackDao;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.List;

public class FeedBackDaoImpl implements FeedBackDao{
    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;
    /*
     * @Description: 获取反馈信息总数
     * @Param null
     * @Return: int
     */
    public int getFeedbackSum()
    {
        con = null;
        pStmt = null;
        rs = null;
        int sum = 0;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT COUNT(*) sum from feedback";
            pStmt = con.prepareStatement(sql);
            rs=pStmt.executeQuery();
            if(rs.next())
            {
                sum=rs.getInt("sum");
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

        return sum;
    }
    /*
     * @Description: 获取用户反馈信息队列
     * @Param null
     * @Return: ArrayList<FeedBack>
     */
    @Override
    public ArrayList<FeedBack> getFeedBack() {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int sum = 0;
        ArrayList<FeedBack> feedBacks=new ArrayList<FeedBack>();

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT f_no,u_no,f_content,f_date\n" +
                    "from feedback;";
            pStmt = con.prepareStatement(sql);
            rs=pStmt.executeQuery();
            if(rs.next())
            {
                do{
                    FeedBack feedBack= new FeedBack(rs.getInt("f_no"),rs.getString("u_no"),
                            rs.getString("f_content"),rs.getString("f_date"));
                    feedBacks.add(feedBack);

                }while (rs.next());
                rs.close();
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

        return feedBacks;
    }
    //将用户的反馈信息添加到feedback表中并返回f_no
    @Override
    public int addUserFeedbackToDb(String u_no, String f_content)
    {
        try
        {
            Connection con = JDBCUtils.getConnection();
            String firstSQL = "insert into feedback(u_no,f_content,f_date) values(?,?,CURRENT_DATE)";
            PreparedStatement pStmt = con.prepareStatement(firstSQL);
            pStmt.setString(1, u_no);
            pStmt.setString(2, f_content);
            //执行第一条
            pStmt.executeUpdate();

            //立即获取最近的一条学号为u_no的反馈
            String secondSQL = "select f_no from feedback where u_no= ? order by f_no desc";
            pStmt = con.prepareStatement(secondSQL);
            pStmt.setString(1, u_no);
            ResultSet rs = pStmt.executeQuery();
            if (rs.next())
            {
                return rs.getInt(1);
            }
            con.close();

        }
        catch (Exception e)
        {
            System.out.println("连接错误");
            e.printStackTrace();
        }
        return -1;
    }

    //通过用户的f_no查找到用户的反馈信息
    @Override
    public FeedBack getUserByFeedback(int f_no)
    {
        try
        {
            Connection con = JDBCUtils.getConnection();
            String sql = "select * from feedback where f_no = ?";
            PreparedStatement pStmt = con.prepareStatement(sql);

            //获取
            pStmt.setInt(1, f_no);

            ResultSet rs = pStmt.executeQuery();
            FeedBack feedback = new FeedBack();
            if (rs.next())
            {
                feedback = new FeedBack(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
            }
            con.close();
            return feedback;

        }
        catch (Exception e)
        {
            System.out.println("连接错误");
            e.printStackTrace();
        }
        return null;
    }

    //分页查询按倒序获取全部反馈（最近）
    @Override
    public List<FeedBack> getFeedbackByPage(int page, int count)
    {
        try
        {
            Connection con = JDBCUtils.getConnection();
            String sql = "select f_no,feedback.u_no,u_name,f_content,f_date from feedback," +
                    "user where user.u_no=feedback.u_no order by f_no desc limit ?,?";
            PreparedStatement pStmt = con.prepareStatement(sql);

            //获取
            pStmt.setInt(1, (page - 1) * count);
            pStmt.setInt(2, count);

            ResultSet rs = pStmt.executeQuery();
            List<FeedBack> list = new ArrayList<>();
            while (rs.next())
            {
                list.add(new FeedBack(rs.getInt(1), rs.getString(2),rs.getString(3),rs.getString(4), rs.getString(5)));
            }
            con.close();
            return list;

        }
        catch (Exception e)
        {
            System.out.println("连接错误");
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    //一键统计当前反馈（设置关键词，看反馈语句是否包含这些关键词来统计反馈，没有关键词的表明原因为其他）
    @Override
    public List<String> getFeedbackByStatistics()
    {
        return null;
    }

    //管理员回复用户的反馈（提供模板，方便操作）
    @Override
    public int respondToUserFeedback(String m_content, int f_no)
    {
        try
        {
            Connection con = JDBCUtils.getConnection();
            String sql = "INSERT INTO message(u_no, m_content, m_date) " +
                    "VALUES (?, ?, CURRENT_DATE)";
            PreparedStatement pStmt = con.prepareStatement(sql);

            FeedBackDao feedbackDao = new FeedBackDaoImpl();
            FeedBack feedback = feedbackDao.getUserByFeedback(f_no);
            SimpleDateFormat sdf = new SimpleDateFormat("y年M月d日");
            String stringDate =feedback.getF_date();
            String message = "根据您在" + stringDate + "的时候发表的关于“" + feedback.getF_content() + "”的反馈内容,管理员做出了以下回答：" +
                    "\r\n" + m_content;
            //替换参数，从1开始
            pStmt.setString(1, feedback.getU_no());
            pStmt.setString(2, message);

            int flag = pStmt.executeUpdate();
            con.close();
            return flag;
        }
        catch (SQLException e)
        {
            System.out.println("连接错误");
            e.printStackTrace();
        }
        return -1;
    }
}
