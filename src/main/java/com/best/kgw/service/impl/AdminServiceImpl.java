package com.best.kgw.service.impl;

import com.best.kgw.dao.AdminDao;
import com.best.kgw.service.AdminSevice;
import com.vo.EmpVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminSevice {
    Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Autowired
    private AdminDao adminDao;
 /*
    작성자 : 이동건
    작성일자 : 24.01.18
    기능 : 회원가입(RegistServiceImpl)
    */


    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원추가 서비스
     **********************************************************************************/
    @Override
    public int regist(EmpVO empVO) throws Exception {
        logger.info("RegistServiceImpl : Regist 호출");
        int result = 0;
        result = adminDao.regist(empVO);
        return result;
    }
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원목록 서비스
     **********************************************************************************/
    @Override
    public List<EmpVO> empList(EmpVO empVO) throws Exception {
        logger.info("Service empList");
        List<EmpVO> empList = adminDao.empList(empVO);
        logger.info(empList.toString());
        return empList;
    }

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.21
     기능 : 사원수정 서비스
     **********************************************************************************/
    @Override
    public int empInfoUpdate(EmpVO empVO) throws Exception {
        logger.info("Service empInfoUpdate");
        int result = 0;
        result = adminDao.empInfoUpdate(empVO);
        return result;
    }






}
