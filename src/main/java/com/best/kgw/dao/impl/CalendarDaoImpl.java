package com.best.kgw.dao.impl;

import com.best.kgw.dao.CalendarDao;
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
public class CalendarDaoImpl implements CalendarDao {
    Logger logger = LoggerFactory.getLogger(CalendarDaoImpl.class);

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<Map<String, Object>> myCalendarList(Map<String, Object> cMap)throws Exception {
        logger.info("Dao : myCalendarList 호출");
        logger.info(cMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("cList", cMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> teamCalendarList(Map<String, Object> tMap)throws Exception {
        logger.info("Dao : teamCalendarList 호출");
        logger.info(tMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("tList", tMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> companyCalendarList(Map<String, Object> cpMap)throws Exception {
        logger.info("Dao : companyCalendarList 호출");
        logger.info(cpMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("cpList", cpMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> calendarDetail(Map<String, Object> cdMap)throws Exception {
        logger.info("Dao : calendarDetail 호출");
        logger.info(cdMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("cdList", cdMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public void insertCalendar(CalendarVO calendarVO) throws Exception {
        logger.info("Dao : insertCalendar 호출");
        try {
            sqlSessionTemplate.insert("insertCalendar", calendarVO);
        } catch (Exception e) {
            throw new Exception("일정 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteCalendar(int calendarNo) throws Exception {
        logger.info("Dao : deleteCalendar 호출");
        sqlSessionTemplate.delete("deleteCalendar", calendarNo);
    }

    @Override
    public void updateCalendar(CalendarVO calendarVO) throws Exception {
        logger.info("Dao : updateCalendar 호출");
        try {
            sqlSessionTemplate.update("updateCalendar", calendarVO);
        } catch (Exception e) {
            throw new Exception("일정 업데이트 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public void deleteTodayCalendar(int calendarNo) throws Exception {
        logger.info("Dao : deleteTodayCalendar 호출");
        sqlSessionTemplate.delete("deleteTodayCalendar", calendarNo);
    }
    @Override
    public List<Map<String, Object>> calList(@RequestParam Map<String, Object> calMap)throws Exception {
        logger.info("Dao : calList 호출");
        logger.info(calMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("reservList", calMap);
        logger.info(list.toString());
        return list;
    }

    @Override
    public List<Map<String, Object>> myCalList(@RequestParam Map<String, Object> myCalMap)throws Exception {
        logger.info("Dao : myCalList 호출");
        logger.info(myCalMap.toString());
        List<Map<String,Object>> list = null;
        list = sqlSessionTemplate.selectList("myCalList", myCalMap);
        logger.info(list.toString());
        return list;
    }

}

