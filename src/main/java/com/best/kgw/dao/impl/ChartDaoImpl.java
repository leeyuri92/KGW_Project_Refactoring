package com.best.kgw.dao.impl;

import com.best.kgw.dao.ChartDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ChartDaoImpl implements ChartDao {
    Logger logger = LoggerFactory.getLogger(ChartDaoImpl.class);

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.26
     기능 : 입/퇴사자 차트
     **********************************************************************************/
    @Override
    public List<Map<String, Object>> hireList(Map<String, Object> hmap) {
        logger.info("hireList");
        List<Map<String, Object>> hireList = null;
        hireList = sqlSessionTemplate.selectList("hireList", hmap);
        logger.info(hireList.toString());
        return hireList;
    }

    @Override
    public List<Map<String, Object>> retireList(Map<String, Object> rmap) {
        logger.info("retireList");
        List<Map<String, Object>> retireList = null;
        retireList = sqlSessionTemplate.selectList("retireList", rmap);
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
        logger.info("warList");
        List<Map<String, Object>> warList = null;
        warList = sqlSessionTemplate.selectList("warList", wmap);
        logger.info(warList.toString());
        return warList;
    }

    @Override
    public List<Map<String, Object>> positionList(Map<String, Object> pmap) {
        logger.info("positionList");
        List<Map<String, Object>> positionList = null;
        positionList = sqlSessionTemplate.selectList("positionList", pmap);
        logger.info(positionList.toString());
        return positionList;
    }

    @Override
    public List<Map<String, Object>> faList(Map<String, Object> fmap) {
        logger.info("faList");
        List<Map<String, Object>> faList = null;
        faList = sqlSessionTemplate.selectList("faList", fmap);
        logger.info(faList.toString());
        return faList;
    }

    @Override
    public double kiwoomWar(Map<String, Object> kmap) {
        logger.info("kiwoomWar");
        double kiwoomWar = sqlSessionTemplate.selectOne("kiwoomWar",kmap);
        logger.info("kiwoomWar : " + kiwoomWar);
        return kiwoomWar;
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.21
     기능 : 등록/방출에 따른 WAR값 업데이트
     **********************************************************************************/
    @Override
    public  void faUpdate(Map<String, Object> umap) {
        logger.info("faUpdate 입력값 : " + umap);
        logger.info(umap.get("FA_NO").toString());
        int result = sqlSessionTemplate.update("faUpdate",umap);
        logger.info("업데이트 성공했니? result : " + result );
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.28
     기능 : 등록/방출 버튼 기본값으로 초기화
     **********************************************************************************/
    @Override
    public void faInit(Map<String, Object> imap) {
        logger.info("faInit");
        int result = sqlSessionTemplate.update("faInit",imap);
        logger.info("업데이트 성공했니? result : " + result );
    }
}
