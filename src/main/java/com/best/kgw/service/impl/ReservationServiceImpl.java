package com.best.kgw.service.impl;

import com.best.kgw.dao.CalendarDao;
import com.best.kgw.dao.ReservationDao;
import com.best.kgw.service.CalendarService;
import com.best.kgw.service.ReservationService;
import com.vo.CalendarVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Service
public class ReservationServiceImpl implements ReservationService {
    Logger logger = LoggerFactory.getLogger(ReservationServiceImpl.class);
    @Autowired
    private ReservationDao reservationDao;

    @Override
    public List<Map<String, Object>> assetList1(@RequestParam Map<String, Object> aMap1) {
        List<Map<String, Object>> assetList1 = null;
        logger.info("Service : assetList1 호출");
        try {
            assetList1 = reservationDao.assetList1(aMap1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return assetList1;
    }

    @Override
    public List<Map<String, Object>> assetList2(@RequestParam Map<String, Object> aMap2) {
        List<Map<String, Object>> assetList2 = null;
        logger.info("Service : assetList2 호출");
        try {
            assetList2 = reservationDao.assetList2(aMap2);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return assetList2;
    }

    @Override
    public List<Map<String, Object>> assetReservationList(@RequestParam Map<String, Object> arMap) {
        List<Map<String, Object>> assetReservationList = null;
        logger.info("Service : assetReservationList 호출");
        try {
            assetReservationList = reservationDao.assetReservationList(arMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return assetReservationList;
    }

    @Override
    public int insertReservation(CalendarVO calendarVO) {
        logger.info("Service : insertReservation 호출");
        try {
            return reservationDao.insertReservation(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteReservation(CalendarVO calendarVO) {
        logger.info("Service : deleteReservation 호출");
        try {
            reservationDao.deleteReservation(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
        }
    }


    @Override
    public void updateReservation(CalendarVO calendarVO) {
        logger.info("Service : updateReservation 호출");
        try {
            reservationDao.updateReservation(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 업데이트 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteTodayReservation(int reservationNo) {
        logger.info("Service : deleteTodayReservation 호출");
        try {
            reservationDao.deleteTodayReservation(reservationNo);
        } catch (Exception e) {
            throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public List<Map<String, Object>> reservList(@RequestParam Map<String, Object> reservMap) {
        List<Map<String, Object>> reservList = null;
        logger.info("Service : reservList 호출");
        try {
            reservList = reservationDao.reservList(reservMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return reservList;
    }

    @Override
    public List<Map<String, Object>> myReservList(@RequestParam Map<String, Object> myReservMap) {
        List<Map<String, Object>> myReservList = null;
        logger.info("Service : myReservList 호출");
        try {
            myReservList = reservationDao.myReservList(myReservMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return myReservList;
    }

}
