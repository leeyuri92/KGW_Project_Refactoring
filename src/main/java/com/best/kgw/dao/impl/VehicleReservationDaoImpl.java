package com.best.kgw.dao.impl;

import com.best.kgw.dao.VehicleReservationDao;
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
public class VehicleReservationDaoImpl implements VehicleReservationDao {
    Logger logger = LoggerFactory.getLogger(VehicleReservationDaoImpl.class);

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<Map<String, Object>> vehicleList(@RequestParam Map<String, Object> vMap)throws Exception {
        logger.info("Dao : vehicleList 호출");
        logger.info(vMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("vList", vMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> vehicleReservationList(@RequestParam Map<String, Object> vrMap)throws Exception {
        logger.info("Dao : vehicleReservationList 호출");
        logger.info(vrMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("vrList", vrMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public int insertVehicleList(CalendarVO calendarVO)throws Exception {
        logger.info("Dao : insertVehicleList 호출");
        try {
            return sqlSessionTemplate.insert("insertVehicleList", calendarVO);
        } catch (Exception e) {
            throw new Exception("일정 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteVehicleList(CalendarVO calendarVO)throws Exception {
        logger.info("Dao : deleteVehicleList 호출");
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("deleteVehicleList", calendarVO);
        logger.info(list.toString());
    }

    @Override
    public void updateVehicleList(CalendarVO calendarVO)throws Exception {
        logger.info("Dao : updateVehicleList 호출");
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("updateVehicleList", calendarVO);
        logger.info(list.toString());
    }

    @Override
    public void deleteTodayVReservation(int reservationNo) throws Exception {
        logger.info("Dao : deleteTodayVReservation 호출");
        sqlSessionTemplate.delete("deleteTodayVReservation", reservationNo);
    }

    @Override
    public List<Map<String, Object>> vehicleReservList(@RequestParam Map<String, Object> reservMap)throws Exception {
        logger.info("Dao : vehicleReservList 호출");
        logger.info(reservMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("vehicleReservList", reservMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> myVehicleReservList(@RequestParam Map<String, Object> myReservMap)throws Exception {
        logger.info("Dao : myVehicleReservList 호출");
        logger.info(myReservMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("myVehicleReservList", myReservMap);
        logger.info(list.toString());
        return list;
    }


}

