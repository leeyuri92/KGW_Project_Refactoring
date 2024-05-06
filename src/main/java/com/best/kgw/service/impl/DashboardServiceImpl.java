package com.best.kgw.service.impl;

import com.best.kgw.dao.DashboardDao;
import com.best.kgw.service.DashboardService;
import com.vo.EmpVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**********************************************************************************
 작성자 : 박병현
 작성일자 : 24.02.19
 기능 : 메인페이지
 **********************************************************************************/
@Service
public class DashboardServiceImpl implements DashboardService {
    Logger logger = LoggerFactory.getLogger(DashboardServiceImpl.class);

    @Autowired
    private DashboardDao dashboardDao;


    /**********************************************************************************
     작성자 : 박병현
     작성일자 : 24.02.24
     기능 : 사원 상세조회
     **********************************************************************************/
    @Override
    public EmpVO empDetail(EmpVO empvo) throws Exception {
        logger.info("DashboardServiceImpl : empDetail");
        EmpVO empDetail = dashboardDao.empDetail(empvo);
        return empDetail;
    }

    @Override
    public int empDetailUpdate(EmpVO empvo) throws Exception {
        logger.info("DashboardServiceImpl : empDetailUpdate");
        int result = 0;
        result = dashboardDao.empDetailUpdate(empvo);
        return result;
    }
}
