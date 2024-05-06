package com.best.kgw.service;

import com.vo.CalendarVO;
import com.vo.NoticeBoardVO;

import java.util.List;
import java.util.Map;

public interface CalendarService {
    List<Map<String, Object>> myCalendarList(Map<String, Object> cmap);

    List<Map<String, Object>> teamCalendarList(Map<String, Object> tmap);

    List<Map<String, Object>> companyCalendarList(Map<String, Object> cpmap);

    List<Map<String, Object>> calendarDetail(Map<String, Object> cdMap);

    public void deleteCalList(int calendarNo) throws Exception;

    public void insertCalendar(CalendarVO calendarVO);

    public void updateCalendar(CalendarVO calendarVO);

    public void deleteTodayCalendar(int calendarNo);


    List<Map<String, Object>> calList(Map<String, Object> calMap);

    List<Map<String, Object>> myCalList(Map<String, Object> myReservMap);

}

