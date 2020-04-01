package dao;

import dao.impl.ExtraInfoDaoImpl;
import org.junit.jupiter.api.Test;

public class ExtraInfoTest {
    @Test
    public void addExtraInfo() {
        ExtraInfoDao extraInfoDao = new ExtraInfoDaoImpl();
        extraInfoDao.addExtraInfo("lw","2017-05-16","001");
    }

    @Test
    public void setReturnedByNo() {
        ExtraInfoDao extraInfoDao = new ExtraInfoDaoImpl();
        System.out.println(extraInfoDao.setReturnedByNo(2));
    }

    @Test
    public void getFinishedExtraRecord() {
        ExtraInfoDao extraInfoDao = new ExtraInfoDaoImpl();
        System.out.println(extraInfoDao.getFinishedExtraRecord("1",1,10));
    }

    @Test
    public void getUnfinishedExtraRecord() {
        ExtraInfoDao extraInfoDao = new ExtraInfoDaoImpl();
        System.out.println(extraInfoDao.getUnfinishedExtraRecord("1",1,10));
    }

}
