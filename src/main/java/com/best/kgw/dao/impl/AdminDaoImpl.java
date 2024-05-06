package com.best.kgw.dao.impl;

import com.best.kgw.dao.AdminDao;
import com.vo.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminDaoImpl implements AdminDao {
    Logger logger = LoggerFactory.getLogger(AdminDaoImpl.class);

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원추가 레포지토리
     **********************************************************************************/
    @Override
    public int regist(EmpVO empVO) throws Exception {
        logger.info("AdminDaoImpl 호출");
        int result = 0;
        result = sqlSessionTemplate.insert("regist",empVO);
        return result;
    }

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원목록 레포지토리
     **********************************************************************************/
    @Override
    public List<EmpVO> empList(EmpVO empVO) throws Exception {
        logger.info("Repository : empList 호출" + empVO);
        List<EmpVO> empList = sqlSessionTemplate.selectList("empList", empVO);
        logger.info(empList.toString());
        return empList;
    }

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원수정 레포지토리
     **********************************************************************************/
    @Override
    public int empInfoUpdate(EmpVO empVO) throws Exception {
        logger.info("Repository : empInfoUpdate");
        int result = 0;
        try {
            result = sqlSessionTemplate.update("empInfoUpdate", empVO);

        } catch (Exception e) {
            logger.info(e.toString());
        }
        logger.info(String.valueOf(result));
        return result;
    }





}
