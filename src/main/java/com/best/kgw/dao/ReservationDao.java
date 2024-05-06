package com.best.kgw.dao;

import com.vo.CalendarVO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface ReservationDao {

    List<Map<String, Object>> assetList1(@RequestParam Map<String, Object> aMap1 )throws Exception;

    List<Map<String, Object>> assetList2(@RequestParam Map<String, Object> aMap2) throws Exception;

    List<Map<String, Object>> assetReservationList(@RequestParam Map<String, Object> arMap) throws Exception;

    void deleteReservation(CalendarVO calendarVO) throws Exception;

    int insertReservation(CalendarVO calendarVO) throws Exception;

    void updateReservation(CalendarVO calendarVO) throws Exception;

    void deleteTodayReservation(int reservationNo)  throws Exception;

    List<Map<String, Object>> reservList(@RequestParam Map<String, Object> reservMap) throws Exception;

    List<Map<String, Object>> myReservList(@RequestParam Map<String, Object> myReservMap) throws Exception;

}