package com.best.kgw.service.impl;

import com.best.kgw.dao.ChartDao;
import com.best.kgw.service.ChartService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ChartServiceImpl implements ChartService {
    Logger logger = LoggerFactory.getLogger(ChartServiceImpl.class);

    @Autowired
    private ChartDao chartDao;

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.26
     기능 : 입/퇴사자 차트
     **********************************************************************************/
    @Override
    public List<Map<String, Object>> hireList(Map<String, Object> hmap) {
        logger.info("hireList");
        List<Map<String, Object>> hireList = chartDao.hireList(hmap);
        logger.info(hireList.toString());
        return hireList;
    }

    @Override
    public List<Map<String, Object>> retireList(Map<String, Object> rmap) {
        logger.info("retireList");
        List<Map<String, Object>> retireList = chartDao.retireList(rmap);
        logger.info(retireList.toString());
        return retireList;
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.18
     기능 : FAchart 페이지 생성 및 리스트, chart 생성
     **********************************************************************************/
    @Override
    public List<Map<String, Object>> warList(Map<String, Object> wmap) {
        logger.info("warList : ");
        List<Map<String, Object>> warList = chartDao.warList(wmap);
        logger.info(warList.toString());
        return warList;
    }

    @Override
    public List<Map<String, Object>> positionList(Map<String, Object> pmap) {
        logger.info("positionList : ");
        List<Map<String, Object>> positionList = chartDao.positionList(pmap);
        logger.info(positionList.toString());
        return positionList;
    }

    @Override
    public List<Map<String, Object>> faList(Map<String, Object> fmap) {
        logger.info("faList");
        List<Map<String, Object>> faList = chartDao.faList(fmap);
        logger.info(faList.toString());
        return faList;
    }

    @Override
    public  double kiwoomWar(Map<String, Object> kmap) {
        logger.info("kiwoomWar");
        double kiwoomWar = chartDao.kiwoomWar(kmap);
        logger.info("kiwoomWar : " + kiwoomWar);
        return kiwoomWar;
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.21
     기능 : 등록/방출에 따른 WAR값 업데이트
     **********************************************************************************/
    @Override
    public void faUpdate(Map<String, Object> FA_NO) {
        logger.info("faUpdate : " + FA_NO);
        chartDao.faUpdate(FA_NO);
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.28
     기능 : 등록/방출 버튼 기본값으로 초기화
     **********************************************************************************/
    @Override
    public void faInit(Map<String, Object> imap) {
        logger.info("faInit");
        chartDao.faInit(imap);
    }
}
