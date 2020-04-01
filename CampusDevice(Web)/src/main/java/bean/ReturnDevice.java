package bean;

public class ReturnDevice
{
    private int rd_no;
    private String u_no;
    private String d_no;
    private int b_no;
    private String rd_date;
    private String rd_deviceState;
    private String rd_comment;

    public int getB_no()
    {
        return b_no;
    }

    public String getD_no()
    {
        return d_no;
    }

    public int getRd_no()
    {
        return rd_no;
    }

    public String getU_no()
    {
        return u_no;
    }

    public void setB_no(int b_no)
    {
        this.b_no = b_no;
    }

    public void setD_no(String d_no)
    {
        this.d_no = d_no;
    }

    public void setRd_no(int rd_no)
    {
        this.rd_no = rd_no;
    }

    public String getRd_date()
    {
        return rd_date;
    }

    public void setRd_date(String rd_date)
    {
        this.rd_date = rd_date;
    }

    public void setU_no(String u_no)
    {
        this.u_no = u_no;
    }

    public String getRd_comment()
    {
        return rd_comment;
    }

    public void setRd_comment(String rd_comment)
    {
        this.rd_comment = rd_comment;
    }

    public String getRd_deviceState()
    {
        return rd_deviceState;
    }

    public void setRd_deviceState(String rd_deviceState)
    {
        this.rd_deviceState = rd_deviceState;
    }
}
