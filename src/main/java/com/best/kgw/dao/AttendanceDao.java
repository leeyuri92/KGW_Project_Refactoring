package com.best.kgw.dao;

import com.vo.AttendanceModifyVO;
import com.vo.AttendanceVO;

import java.util.List;
import java.util.Map;

public interface AttendanceDao {
    public void attendanceTime(AttendanceVO attendanceVO) throws Exception;

    public void attendanceEndTime(AttendanceVO attendanceVO) throws Exception;

    public AttendanceVO attendance(int emp_no) throws Exception;

    public List<AttendanceVO> attendanceData(int emp_no) throws Exception;

    public void attemdamceStateUpdate() throws Exception;

    public void attendaceMod(AttendanceVO attendanceVO) throws Exception;

    public List<AttendanceModifyVO> attendaceModList(AttendanceVO attendanceVO) throws Exception;

    public Map<String, Object> adminModAttendeanceMap(AttendanceModifyVO attendancemodifyvo) throws Exception;

    public void attendanceModUpdate(AttendanceModifyVO attendancemodifyvo)throws Exception;

    public void attendanceUpdate(AttendanceModifyVO attendancemodifyvo)throws Exception;

    List<AttendanceVO> jsonAttendanceSelect(AttendanceVO attendanceVO)throws Exception;
}
