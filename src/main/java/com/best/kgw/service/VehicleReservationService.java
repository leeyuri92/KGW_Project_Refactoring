package com.best.kgw.service;

import com.vo.CalendarVO;

import java.util.List;
import java.util.Map;

public interface VehicleReservationService {

    List<Map<String, Object>> vehicleList(Map<String, Object> vMap);

    List<Map<String, Object>> vehicleReservationList(Map<String, Object> vrMap);

    void deleteVehicleList(CalendarVO calendarVO);

    int insertVehicleList(CalendarVO calendarVO);

    void updateVehicleList(CalendarVO calendarVO);

    void deleteTodayVReservation(int reservationNo);

    List<Map<String, Object>> vehicleReservList(Map<String, Object> reservMap);

    List<Map<String, Object>> myVehicleReservList(Map<String, Object> myReservMap);

}

