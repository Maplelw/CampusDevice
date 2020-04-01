package dao;

import bean.User;
import com.alibaba.fastjson.JSONObject;

import java.util.Date;
import java.util.List;

public interface UserDao
{
    /*
     * @Description: select:分页获取用户对象
     * @Param page，count
     * @Return: bean.User
     */
    List<User> getUsersByPage(int page,int count);

    /*
     * @Description: 获取用户总数
     * @Param null
     * @Return: int
     */
    int getUserSum();

    /*
     * @Description: 通过用户学工号获取用户对象
     * @Param u_no
     * @Return: bean.User
     */
    User getUserByNo(String u_no);

    /*
     * @Description: 更新增加或减少信誉分数
     * @Param score
     * @Return: int
     */
    int updateCreditGrade(String u_no, int score);

    /*
     * @Description: 通过用户学号获取用户当前信用积分
     * @Param u_no
     * @Return: int
     */
    int getCreditScore(String u_no);
}
