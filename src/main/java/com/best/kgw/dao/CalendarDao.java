package com.best.kgw.dao;

import com.vo.CalendarVO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

public interface CalendarDao {
    public List<Map<String, Object>> myCalendarList(Map<String, Object> cmap) throws Exception;

    public List<Map<String, Object>> teamCalendarList(Map<String, Object> tmap) throws Exception;

    public List<Map<String, Object>> companyCalendarList(Map<String, Object> cpmap) throws Exception;

    public List<Map<String, Object>> calendarDetail(Map<String, Object> cdmap) throws Exception;

    void deleteCalendar(int calendarNo) throws Exception;

    void updateCalendar(CalendarVO calendarVO) throws Exception;

    void deleteTodayCalendar(int calendarNo) throws Exception;

    void insertCalendar(CalendarVO calendarVO) throws Exception;

    List<Map<String, Object>> calList(Map<String, Object> calMap) throws Exception;

    List<Map<String, Object>> myCalList(Map<String, Object> myCalMap) throws Exception;
}