package com.best.kgw.service.impl;

import com.best.kgw.dao.AttendanceDao;
import com.best.kgw.service.AttendanceService;
import com.vo.AttendanceModifyVO;
import com.vo.AttendanceVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class AttendanceServiceImpl implements AttendanceService {
    Logger logger = LoggerFactory.getLogger(AttendanceServiceImpl.class);
    @Autowired
    private AttendanceDao attendanceDao;

    @Override
    public List<AttendanceVO> attendanceData(int emp_no) throws Exception {
        List<AttendanceVO> attendanceCalendar = (List) attendanceDao.attendanceData(emp_no);
        return attendanceCalendar;
    }

    @Override
    public void attendanceTime(AttendanceVO attendanceVO) throws Exception {

        attendanceDao.attendanceTime(attendanceVO);
    }

    @Override
    public void attendanceEndTime(AttendanceVO attendanceVO) throws Exception {
        attendanceDao.attendanceEndTime(attendanceVO);
    }

    @Override
    public AttendanceVO attendance(int emp_no) throws Exception {
        logger.info("AttendanceServiceImpl : "+emp_no);
        return attendanceDao.attendance(emp_no);
    }

    //스케줄러에 따라서 월-금 23:59:59 에 근태 상태값 업데이트
    @Override
    public void attemdamceStateUpdate() throws Exception {
        attendanceDao.attemdamceStateUpdate();
    }

    @Override
    public void attendaceMod(AttendanceVO attendanceVO) throws Exception {
        attendanceDao.attendaceMod(attendanceVO);
    }

    @Override
    public List<AttendanceModifyVO> attendaceModList(AttendanceVO attendanceVO) throws Exception {
        List<AttendanceModifyVO> attendaceModList = attendanceDao.attendaceModList(attendanceVO);
        return attendaceModList;
    }

    @Override
    public Map<String, Object> adminModAttendeanceMap(AttendanceModifyVO attendancemodifyvo) throws Exception {
        Map<String, Object> adminModAttendeanceMap = attendanceDao.adminModAttendeanceMap(attendancemodifyvo);
        return adminModAttendeanceMap;
    }

    @Override
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void attendanceModUpdate(AttendanceModifyVO attendancemodifyvo) throws Exception {
        logger.info("==================================="+attendancemodifyvo.toString());
        attendanceDao.attendanceModUpdate(attendancemodifyvo);
        attendanceDao.attendanceUpdate(attendancemodifyvo);
    }

    @Override
    public List<AttendanceVO> jsonAttendanceSelect(AttendanceVO  attendanceVO) throws Exception {
        List<AttendanceVO> attendanceList = attendanceDao.jsonAttendanceSelect(attendanceVO);
        return attendanceList;
    }
}
