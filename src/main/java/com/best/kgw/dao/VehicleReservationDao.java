package com.best.kgw.dao;

import com.vo.CalendarVO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface VehicleReservationDao {

    List<Map<String, Object>> vehicleList(Map<String, Object> vMap)throws Exception;

    List<Map<String, Object>> vehicleReservationList(Map<String, Object> vrMap)throws Exception;

    void deleteVehicleList(CalendarVO calendarVO)throws Exception;

    int insertVehicleList(CalendarVO calendarVO)throws Exception;

    void updateVehicleList(CalendarVO calendarVO)throws Exception;

    void deleteTodayVReservation(int reservationNo)throws Exception;

    List<Map<String, Object>> vehicleReservList(Map<String, Object> reservMap)throws Exception;

    List<Map<String, Object>> myVehicleReservList(Map<String, Object> myReservMap)throws Exception;

}