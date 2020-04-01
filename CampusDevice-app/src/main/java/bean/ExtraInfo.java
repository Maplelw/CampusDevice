package bean;

public class ExtraInfo {
    private int ei_no;
    private String d_no;
    private String ei_name;
    private String ei_date;
    private String ei_info;
    private int ei_state;

    //附加信息
    private String d_name;

    public ExtraInfo(){
    };

    public ExtraInfo(int ei_no, String d_no, String ei_name, String ei_date, String ei_info, int ei_state, String d_name) {
        this.ei_no = ei_no;
        this.d_no = d_no;
        this.ei_name = ei_name;
        this.ei_date = ei_date;
        this.ei_info = ei_info;
        this.ei_state = ei_state;
        this.d_name = d_name;
    }

    public int getEi_no() {
        return ei_no;
    }

    public void setEi_no(int ei_no) {
        this.ei_no = ei_no;
    }

    public String getEi_name() {
        return ei_name;
    }

    public void setEi_name(String ei_name) {
        this.ei_name = ei_name;
    }

    public String getEi_date() {
        return ei_date;
    }

    public void setEi_date(String ei_date) {
        this.ei_date = ei_date;
    }

    public String getEi_info() {
        return ei_info;
    }

    public void setEi_info(String ei_info) {
        this.ei_info = ei_info;
    }

    public int getEi_state() {
        return ei_state;
    }

    public void setEi_state(int ei_state) {
        this.ei_state = ei_state;
    }

    public String getD_no() {
        return d_no;
    }

    public void setD_no(String d_no) {
        this.d_no = d_no;
    }

    public String getD_name() {
        return d_name;
    }

    public void setD_name(String d_name) {
        this.d_name = d_name;
    }

    @Override
    public String toString() {
        return "ExtraInfo{" +
                "ei_no=" + ei_no +
                ", d_no='" + d_no + '\'' +
                ", ei_name='" + ei_name + '\'' +
                ", ei_date='" + ei_date + '\'' +
                ", ei_info='" + ei_info + '\'' +
                ", ei_state=" + ei_state +
                ", d_name='" + d_name + '\'' +
                '}';
    }
}
