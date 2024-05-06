package com.best.kgw.dao.impl;

import com.best.kgw.dao.CalendarDao;
import com.best.kgw.dao.ReservationDao;
import com.vo.CalendarVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Repository
public class ReservationDaoImpl implements ReservationDao {
    Logger logger = LoggerFactory.getLogger(ReservationDaoImpl.class);

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<Map<String, Object>> assetList1(@RequestParam Map<String, Object> aMap1)throws Exception {
        logger.info("Dao : assetList1 호출");
        logger.info(aMap1.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("aList1", aMap1);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> assetList2(@RequestParam Map<String, Object> aMap2)throws Exception {
        logger.info("Dao : assetList2 호출");
        logger.info(aMap2.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("aList2", aMap2);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> assetReservationList(@RequestParam Map<String, Object> arMap)throws Exception {
        logger.info("Dao : assetReservationList 호출");
        logger.info(arMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("arList", arMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public int insertReservation(CalendarVO calendarVO) throws Exception {
        logger.info("Dao : insertReservation 호출");
        try {
            return sqlSessionTemplate.insert("insertReservation", calendarVO);
        } catch (Exception e) {
            throw new Exception("일정 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteReservation(CalendarVO calendarVO) throws Exception {
        logger.info("Dao : deleteReservation 호출");
        try {
            sqlSessionTemplate.update("deleteReservation", calendarVO);
        } catch (Exception e) {
            throw new Exception("일정 업데이트 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void updateReservation(CalendarVO calendarVO) throws Exception {
        logger.info("Dao : updateReservation 호출");
        try {
            sqlSessionTemplate.update("updateReservation", calendarVO);
        } catch (Exception e) {
            throw new Exception("일정 업데이트 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteTodayReservation(int reservationNo) throws Exception {
        logger.info("Dao : deleteTodayReservation 호출");
        sqlSessionTemplate.delete("deleteTodayReservation", reservationNo);
    }

    @Override
    public List<Map<String, Object>> reservList(@RequestParam Map<String, Object> reservMap)throws Exception {
        logger.info("Dao : reservList 호출");
        logger.info(reservMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("reservList", reservMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> myReservList(@RequestParam Map<String, Object> myReservMap)throws Exception {
        logger.info("Dao : myReservList 호출");
        logger.info(myReservMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("myReservList", myReservMap);
        logger.info(list.toString());
        return list;
    }

}

