package dao;


public interface MessageDao
{
    /*
     * @Description: 系统向用户发送消息
     * @Param u_no  m_content
     * @Return: int
     */
    int sendMessage(String u_no, String m_content);
}
