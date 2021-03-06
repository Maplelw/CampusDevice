package dao.impl;

import bean.Borrow;
import dao.BorrowDao;
import utils.JDBCUtils;
import utils.TransformUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BorrowDaoImpl implements BorrowDao
{
    private Connection con;
    private PreparedStatement pStmt;
    private ResultSet rs;
    private String sql;

    /*
     * @Description: 用户查询借用完成的记录(逾期归还:-2 归还未评价:1 归还评价:2)
     * @Param u_no  page  count
     * @Return: java.util.List<bean.Borrow>
     */
    public List<Borrow> getFinishedBorrowRecordByPage(String u_no, int page, int count)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        List<Borrow> borrowList = new ArrayList<>();

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT b_no, b_borrow_date, b_return_date, d_save_site, device.d_no, d_name, b_state " +
                    "FROM borrow, device " +
                    "WHERE u_no = ?" +
                    "AND borrow.d_no = device.d_no AND b_state IN(-2, 1, 2) " +
                    "ORDER BY b_borrow_date DESC  " +
                    "LIMIT ?, ?";
            pStmt = con.prepareStatement(sql);

            //执行操作
            pStmt.setString(1, u_no);
            pStmt.setInt(2, (page - 1) * count);
            pStmt.setInt(3, count);

            rs = pStmt.executeQuery();
            while (rs.next())
            {
                Borrow borrow = new Borrow();
                borrow.setB_no(rs.getInt("b_no"));
                borrow.setB_borrowDate(rs.getString("b_borrow_date"));
                borrow.setB_returnDate(rs.getString("b_return_date"));
                borrow.setD_saveSite(rs.getString("d_save_site"));
                borrow.setD_no(rs.getString("d_no"));
                borrow.setD_name(rs.getString("d_name"));
                borrow.setB_state(rs.getInt("b_state"));
                borrowList.add(borrow);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return borrowList;
    }

    /*
     * @Description: 用户查询借用中的记录( 逾期借用: -1 借用中：0 )
     * @Param u_no  page  count
     * @Return: java.util.List<bean.Borrow>
     */
    public List<Borrow> getUnfinishedBorrowRecordByPage(String u_no, int page, int count)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        List<Borrow> borrowList = new ArrayList<>();

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT b_no, b_borrow_date, b_return_date, d_save_site, device.d_no, d_name, b_state " +
                    "FROM borrow, device " +
                    "WHERE u_no = ?" +
                    "AND borrow.d_no = device.d_no AND b_state IN(-1, 0) " +
                    "ORDER BY b_borrow_date DESC " +
                    "LIMIT ?, ?";
            pStmt = con.prepareStatement(sql);

            //执行操作
            pStmt.setString(1, u_no);
            pStmt.setInt(2, (page - 1) * count);
            pStmt.setInt(3, count);

            rs = pStmt.executeQuery();
            while (rs.next())
            {
                Borrow borrow = new Borrow();
                borrow.setB_no(rs.getInt("b_no"));
                borrow.setB_borrowDate(rs.getString("b_borrow_date"));
                borrow.setB_returnDate(rs.getString("b_return_date"));
                borrow.setD_saveSite(rs.getString("d_save_site"));
                borrow.setD_no(rs.getString("d_no"));
                borrow.setD_name(rs.getString("d_name"));
                borrow.setB_state(rs.getInt("b_state"));
                borrowList.add(borrow);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return borrowList;
    }
    /*
     * @Description: 获取待归还设备总数
     * @Param a_no
     * @Return: int
     */
    public int getTobeReturnedSum(String a_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        int sum=0;

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT count(*) " +
                    "FROM borrow b, administrator a ,device d  " +
                    "WHERE a.a_no = ? " +
                    "AND a.a_no=d.a_no "+
                    "AND b.d_no = d.d_no AND b_state IN (-1, 0) ";
            pStmt = con.prepareStatement(sql);

            //执行操作
            pStmt.setString(1, a_no);
            rs = pStmt.executeQuery();
            if(rs.next())
                sum=rs.getInt(1);
        }
        catch (Exception e)
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
     * @Description: 管理员查看管辖范围内外借中记录(逾期归还:-2  逾期借用: -1  借用中:0  归还未评价:1 归还评价:2)
     * @Param a_no
     * @Return: java.util.List<bean.Borrow>
     */
    public List<Borrow> getBorrowListByPage(String a_no,int page,int count)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        List<Borrow> borrowList = new ArrayList<>();

        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT b_no, b.b_state,b.b_no,d.d_save_site, d.d_name, d.d_no, u.u_no, u.u_name, u.u_phone, u.u_mentor_name, u.u_mentor_phone, u_credit_grade, b_borrow_date, b_return_date " +
                    "FROM borrow b, administrator a, user u ,device d  " +
                    "WHERE a.a_no = ? " +
                    "AND a.a_no=d.a_no "+
                    "AND b.u_no = u.u_no " +
                    "AND b.d_no = d.d_no AND b_state IN (-1, 0) " +
                    "ORDER BY b_return_date limit ?,? ";
            pStmt = con.prepareStatement(sql);

            //执行操作
            pStmt.setString(1, a_no);
            pStmt.setInt(2,(page-1)*count);
            pStmt.setInt(3,count);
            rs = pStmt.executeQuery();
            while (rs.next())
            {
                Borrow borrow = new Borrow();
                borrow.setB_no(rs.getInt("b_no"));
                borrow.setB_state(rs.getInt("b_state"));
                borrow.setD_saveSite(rs.getString("d_save_site"));
                borrow.setD_name(rs.getString("d_name"));
                borrow.setD_no(rs.getString("d_no"));
                borrow.setU_no(rs.getString("u_no"));
                borrow.setU_name(rs.getString("u_name"));
                borrow.setU_phone(rs.getString("u_phone"));
                borrow.setU_mentorName(rs.getString("u_mentor_name"));
                borrow.setU_mentorPhone(rs.getString("u_mentor_phone"));
                borrow.setU_creditGrade(rs.getInt("u_credit_grade"));
                borrow.setB_borrowDate(rs.getString("b_borrow_date"));
                borrow.setB_returnDate(rs.getString("b_return_date"));
                borrowList.add(borrow);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs, pStmt, con);
        }
        return borrowList;
    }

    /*
     * @Description: 管理员确认设备租借给某个用户
     * @Param u_no  d_no  borrowDate  returnDate
     * @Return: int
     */
    public int confirmBorrow(String u_no, String d_no, String borrowDate, String returnDate)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        con = JDBCUtils.getConnection();
        sql = "INSERT INTO borrow(d_no, u_no, b_borrow_date, b_return_date) " +
                "VALUES (?, ?, ?, ?)";
        try
        {
            pStmt = con.prepareStatement(sql);
            pStmt.setString(1, d_no);
            pStmt.setString(2, u_no);
            pStmt.setString(3, borrowDate);
            pStmt.setString(4, returnDate);

            //返回执行状态
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

    /*
     * @Description: 设置所有逾期设备状态为 -1 表示逾期未还
     * @Param
     * @Return: int
     */
    public int setAllOverDueState()
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int result = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "UPDATE borrow SET b_state = -1 " +
                    "WHERE b_return_date < CURRENT_DATE " +
                    "AND b_state = 0";
            pStmt = con.prepareStatement(sql);

            result = pStmt.executeUpdate();
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
     * @Description: 获取逾期未换记录数量
     * @Param a_no
     * @Return: int
     */
    public int getOverdueSum(String a_no)
    {
        con = null;
        pStmt = null;
        rs = null;
        int sum=0;
        try
        {
            con=JDBCUtils.getConnection();
            String firstSQL =   "select count(*) " +
                    "from user u, device d, borrow b, return_device rd, administrator a " +
                    "where u.u_no=b.u_no and d.d_no=b.d_no and rd.u_no=u.u_no and rd.d_no=d.d_no and rd.b_no=b.b_no and d.a_no=a.a_no and b.b_state=-2 and a.a_no=?" +
                    "order by b.b_no";

            //第二种是未归还，但b_state=-1
            String secondSQL =  "select count(*)  " +
                    "from user u, device d, borrow b, administrator a " +
                    "where u.u_no=b.u_no and d.d_no=b.d_no and d.a_no=a.a_no and b.b_state=-1 and a.a_no=?"+
                    "order by b.b_no";

            //执行
            PreparedStatement firstPs = con.prepareStatement(firstSQL);
            firstPs.setString(1,a_no);
            ResultSet firstRs = firstPs.executeQuery();
            if(firstRs.next())
                sum+=firstRs.getInt(1);
            //执行
            PreparedStatement secondPs = con.prepareStatement(secondSQL);
            secondPs.setString(1,a_no);
            ResultSet secondRs = secondPs.executeQuery();
            if(secondRs.next())
                sum+=secondRs.getInt(1);
            secondRs.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs,pStmt,con);
        }
        return sum;
    }
    /*
     * @Description: 管理员获取管辖范围内预期未还用户
     * @Param a_no  page  count
     * @Return: java.util.List<bean.Borrow>
     */
    public List<Borrow> getOverDueList(String a_no, int page, int count)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;
        List<Borrow> borrowList = new ArrayList<>();
        try
        {
            con=JDBCUtils.getConnection();
            String firstSQL =   "select u.u_name, u.u_no, u.u_type, u.u_credit_grade,d.d_no,d.d_name, b.b_borrow_date, b.b_return_date " +
                    "from user u, device d, borrow b, return_device rd, administrator a " +
                    "where u.u_no=b.u_no and d.d_no=b.d_no and rd.u_no=u.u_no and rd.d_no=d.d_no and rd.b_no=b.b_no and d.a_no=a.a_no and b.b_state=-2 and a.a_no=?" +
                    "order by b.b_no";

            //第二种是未归还，但b_state=-1
            String secondSQL =  "select u.u_name, u.u_no, u.u_type, u.u_credit_grade,d.d_no,d.d_name, b.b_borrow_date, b.b_return_date " +
                    "from user u, device d, borrow b, administrator a " +
                    "where u.u_no=b.u_no and d.d_no=b.d_no and d.a_no=a.a_no and b.b_state=-1 and a.a_no=?"+
                    "order by b.b_no";

            //执行
            PreparedStatement firstPs = con.prepareStatement(firstSQL);
            firstPs.setString(1,a_no);
            ResultSet firstRs = firstPs.executeQuery();
            int i=0;
            while (firstRs.next())
            {
                if(i>page*count)
                    break;
                i++;
                if((i>(page-1)*count)&&(i<=page*count))
                {
                    Borrow borrow = new Borrow();
                    borrow.setU_name(firstRs.getString(1));
                    borrow.setU_no(firstRs.getString(2));
                    borrow.setU_type(firstRs.getString(3));
                    borrow.setD_no(firstRs.getString(5));
                    borrow.setD_name(firstRs.getString(6));
                    borrow.setU_creditGrade(firstRs.getInt(4));
                    borrow.setB_borrowDate(firstRs.getString(7));
                    borrow.setB_returnDate(firstRs.getString(8));
                    borrowList.add(borrow);
                }
            }
            //执行
            PreparedStatement secondPs = con.prepareStatement(secondSQL);
            secondPs.setString(1,a_no);
            ResultSet secondRs = secondPs.executeQuery();
            while (secondRs.next())
            {
                if(i>page*count)
                    break;
                i++;
                if((i>(page-1)*count)&&(i<=page*count))
                {
                    Borrow borrow = new Borrow();
                    borrow.setU_name(secondRs.getString(1));
                    borrow.setU_no(secondRs.getString(2));
                    borrow.setU_type(secondRs.getString(3));
                    borrow.setD_no(secondRs.getString(5));
                    borrow.setD_name(secondRs.getString(6));
                    borrow.setU_creditGrade(secondRs.getInt(4));
                    borrow.setB_borrowDate(secondRs.getString(7));
                    borrow.setB_returnDate(secondRs.getString(8));
                    borrowList.add(borrow);
                }
            }
            secondRs.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            JDBCUtils.closeAll(rs,pStmt,con);
        }
        return borrowList;
    }

    /*
     * @Description: 借用中设备按时归还 （0:借用中，1:按时归还 -1:逾期未还 -2:逾期归还）
     * @Param b_no
     * @Return: int
     */
    public int returnOnTime(int b_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "UPDATE borrow SET b_state = 1 " +
                    "WHERE b_no = ? " +
                    "AND b_state <> 1 ";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setInt(1, b_no);

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
     * @Description: 借用中设备逾期归还 （0:借用中，1:按时归还 -1:逾期未还 -2:逾期归还）
     * @Param b_no
     * @Return: int
     */
    public int returnOutOfTime(int b_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "UPDATE borrow SET b_state = -2 " +
                    "WHERE b_no = ? " +
                    "AND b_state <> -2";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setInt(1, b_no);

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
     * @Description: 修改借用表 借用状态 （逾期归还:-2  逾期借用: -1  借用中:0  归还:1 归还评价:2）
     * @Param b_no
     * @Return: int
     */
    public int finishComment(int b_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        int flag = 0;
        try
        {
            con = JDBCUtils.getConnection();
            sql = "UPDATE borrow SET b_state = 2 " +
                    "WHERE b_no = ? " +
                    "AND b_state <> 2";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setInt(1, b_no);

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
     * @Description: 根据借用编号查询借用记录
     * @Param b_no
     * @Return: bean.Borrow
     */
    public Borrow getBorrowByNo(int b_no)
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        Borrow borrow = new Borrow();
        try
        {
            con = JDBCUtils.getConnection();
            sql = "SELECT * FROM borrow b, device d, user u " +
                    "WHERE b.d_no = d.d_no " +
                    "AND b.u_no = u.u_no " +
                    "AND b_no = ?";
            pStmt = con.prepareStatement(sql);

            //替换参数，从1开始
            pStmt.setInt(1, b_no);
            rs = pStmt.executeQuery();
            if (rs.next())
            {
                borrow.setB_no(rs.getInt("b_no"));
                borrow.setD_no(rs.getString("d_no"));
                borrow.setU_no(rs.getString("u_no"));
                borrow.setB_borrowDate(rs.getString("b_borrow_date"));
                borrow.setB_returnDate(rs.getString("b_return_date"));
                borrow.setB_state(rs.getInt("b_state"));
                borrow.setU_name(rs.getString("u_name"));
                borrow.setU_type(rs.getString("u_type"));
                borrow.setU_phone(rs.getString("u_phone"));
                borrow.setD_name(rs.getString("d_name"));
                borrow.setD_saveSite(rs.getString("d_save_site"));
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
        return borrow;
    }

    /*
     * @Description: 以String的形式返回逾期人学工号、逾期人名、设备编号、设备名、借用日期、应当归还日期、实际归还日期、借用人信用分、管理仪器的管理员的名字
     * @Param b_no
     * @Return: List<String>
     */
    public List<String> getOverDueList(String a_no)
    {

        //初始化
        con = null;
        pStmt = null;
        rs = null;

        try
        {
            con = JDBCUtils.getConnection();
            //第一种是已归还，但实际归还日期大于应当归还日期
            String firstSQL = "select u.u_no, u.u_name, d.d_no, d.d_name, b.b_borrow_date, b.b_return_date, rd.rd_date, u.u_credit_grade, a.a_name " +
                    "from user u, device d, borrow b, return_device rd, administrator a " +
                    "where u.u_no=b.u_no and d.d_no=b.d_no and rd.u_no=u.u_no and rd.d_no=d.d_no and rd.b_no=b.b_no and d.a_no=a.a_no and b.b_state=-2 and a.a_no=?"+
                    "order by b.b_no";

            //第二种是未归还，但b_state=-1
            String secondSQL = "select u.u_no, u.u_name, d.d_no, d.d_name, b.b_borrow_date, b.b_return_date, u.u_credit_grade, a.a_name " +
                    "from user u, device d, borrow b, administrator a " +
                    "where u.u_no=b.u_no and d.d_no=b.d_no and d.a_no=a.a_no and b.b_state=-1 " +
                    "order by b.b_no";

            List<String> list = new ArrayList<>();

            //执行
            PreparedStatement firstPs = con.prepareStatement(firstSQL);
            firstPs.setString(1,a_no);
            ResultSet firstRs = firstPs.executeQuery();
            while (firstRs.next())
            {
                list.add(firstRs.getString(1));
                list.add(firstRs.getString(2));
                list.add(firstRs.getString(3));
                list.add(firstRs.getString(4));
                list.add(TransformUtils.SQLDateTransString(firstRs.getDate(5)));
                list.add(TransformUtils.SQLDateTransString(firstRs.getDate(6)));
                list.add(TransformUtils.SQLDateTransString(firstRs.getDate(7)));
                list.add(Integer.toString(firstRs.getInt(8)));
                list.add(firstRs.getString(9));
            }

            PreparedStatement secondPs = con.prepareStatement(secondSQL);
            ResultSet secondRs = secondPs.executeQuery();
            while (secondRs.next())
            {
                list.add(secondRs.getString(1));
                list.add(secondRs.getString(2));
                list.add(secondRs.getString(3));
                list.add(secondRs.getString(4));
                list.add(TransformUtils.SQLDateTransString(secondRs.getDate(5)));
                list.add(TransformUtils.SQLDateTransString(secondRs.getDate(6)));
                list.add("尚未归还");
                list.add(Integer.toString(secondRs.getInt(7)));
                list.add(secondRs.getString(8));
            }

            return list;

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return null;
    }

    /*
     * @Description: 获得逾期的用户借用天数以及他未还的天数
     * @Param b_no
     * @Return: int
     */
    @Override
    public List<Integer> getOverDueBorrowAndDays()
    {
        //初始化
        con = null;
        pStmt = null;
        rs = null;

        List<Integer> list = new ArrayList<>();
        try
        {
            con = JDBCUtils.getConnection();
            sql = "select b_no, b_return_date from borrow where b_state = -1";
            Date date = new Date();
            pStmt = con.prepareStatement(sql);

            rs = pStmt.executeQuery();
            while (rs.next())
            {
                int days = (int) ((date.getTime() - rs.getDate(2).getTime()) / (1000 * 3600 * 24));
                list.add(rs.getInt(1));
                list.add(days);
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
        return list;
    }
}
