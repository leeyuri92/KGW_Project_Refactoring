package com.best.kgw.service;

import com.vo.EmpVO;

import java.util.List;

/**********************************************************************************
 작성자 : 박병현
 작성일자 : 24.02.19
 기능 : DashboardService Interface
 **********************************************************************************/
public interface DashboardService {

    public EmpVO empDetail(EmpVO empvo) throws Exception;

    public int empDetailUpdate(EmpVO empvo) throws Exception;
}
