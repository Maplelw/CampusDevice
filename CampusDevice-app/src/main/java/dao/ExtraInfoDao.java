package dao;

import bean.Device;
import bean.ExtraInfo;

import java.util.List;

public interface ExtraInfoDao {

    /**
     * 增加一条额外记录
     */
   int addExtraInfo(String name,String info,String d_no);

    /**
     * 设置为已归还状态
     */
    int setReturnedByNo(int ei_no);

    /**
     * 获取管理员额外添加的记录,已经归还
     * @param a_no
     * @return
     */
    List<ExtraInfo> getFinishedExtraRecord(String a_no,int page,int count);

    /**
     * 获取管理员额外添加的记录,还没有归还
     * @param a_no
     * @return
     */
    List<ExtraInfo> getUnfinishedExtraRecord(String a_no,int page,int count);

}
