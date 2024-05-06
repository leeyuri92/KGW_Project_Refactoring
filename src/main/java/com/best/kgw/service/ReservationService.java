package com.best.kgw.service;

import com.vo.CalendarVO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface ReservationService {

    List<Map<String, Object>> assetList1(@RequestParam Map<String, Object> aMap1);

    List<Map<String, Object>> assetList2(@RequestParam Map<String, Object> aMap2);

    List<Map<String, Object>> assetReservationList(@RequestParam Map<String, Object> arMap);

    public void deleteReservation(CalendarVO calendarVO);

    public int insertReservation(CalendarVO calendarVO);

    public void updateReservation(CalendarVO calendarVO);

    public void deleteTodayReservation(int reservationNo);

    List<Map<String, Object>> reservList(@RequestParam Map<String, Object> reservMap);

    List<Map<String, Object>> myReservList(@RequestParam Map<String, Object> myReservMap);

}

