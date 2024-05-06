package com.best.kgw.service.impl;

import com.best.kgw.dao.VehicleReservationDao;
import com.best.kgw.service.VehicleReservationService;
import com.vo.CalendarVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class VehicleReservationServiceImpl implements VehicleReservationService {
    Logger logger = LoggerFactory.getLogger(VehicleReservationServiceImpl.class);
    @Autowired
    private VehicleReservationDao vehicleReservationDao;

    //차량 서비스

    @Override
    public List<Map<String, Object>> vehicleList(Map<String, Object> vMap) {
        List<Map<String, Object>> assetList = null;
        logger.info("Service : assetList 호출");
        try {
            assetList = vehicleReservationDao.vehicleList(vMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return assetList;
    }

    @Override
    public List<Map<String, Object>> vehicleReservationList(Map<String, Object> vrMap) {
        List<Map<String, Object>> assetReservationList = null;
        logger.info("Service : assetReservationList 호출");
        try {
            assetReservationList = vehicleReservationDao.vehicleReservationList(vrMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return assetReservationList;
    }

    @Override
    public void deleteVehicleList(CalendarVO calendarVO) {
        logger.info("Service : deleteVehicleList 호출");
        try {
            vehicleReservationDao.deleteVehicleList(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void updateVehicleList(CalendarVO calendarVO) {
        logger.info("Service : updateVehicleList 호출");
        try {
            vehicleReservationDao.updateVehicleList(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public int insertVehicleList(CalendarVO calendarVO) {
        logger.info("Service : insertVehicleList 호출");
        try {
            return vehicleReservationDao.insertVehicleList(calendarVO);
        } catch (Exception e) {
            throw new RuntimeException("일정 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteTodayVReservation(int reservationNo) {
        logger.info("Service : deleteTodayVReservation 호출");
        try {
            vehicleReservationDao.deleteTodayVReservation(reservationNo);
        } catch (Exception e) {
            throw new RuntimeException("일정 삭제 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public List<Map<String, Object>> vehicleReservList(Map<String, Object> reservMap) {
        List<Map<String, Object>> vehicleReservList = null;
        logger.info("Service : vehicleReservList 호출");
        try {
            vehicleReservList = vehicleReservationDao.vehicleReservList(reservMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return vehicleReservList;
    }

    @Override
    public List<Map<String, Object>> myVehicleReservList(Map<String, Object> myReservMap) {
        List<Map<String, Object>> myVehicleReservList = null;
        logger.info("Service : myVehicleReservList 호출");
        try {
            myVehicleReservList = vehicleReservationDao.myVehicleReservList(myReservMap);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return myVehicleReservList;
    }

}
