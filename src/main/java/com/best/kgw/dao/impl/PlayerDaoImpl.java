package com.best.kgw.dao.impl;

import com.best.kgw.dao.PlayerDao;
import com.vo.HittersVO;
import com.vo.PitchersVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
@Repository

public class PlayerDaoImpl  implements PlayerDao {
    Logger logger= LoggerFactory.getLogger("PlayerDao".getClass());
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
@Override
    public  List<HittersVO>hitterList(HittersVO hittersVO) {
        List<HittersVO> list = new ArrayList<>();
        logger.info("hittersDao");
        list= sqlSessionTemplate.selectList("selectHitters",hittersVO);
        return  list;
    }
    @Override
    public  List<PitchersVO>pitcherList(PitchersVO pitchersVO){
        List<PitchersVO > list2=new ArrayList<>();
        logger.info("pitcherList");
        list2=sqlSessionTemplate.selectList("SelectPitchers",pitchersVO);
        return  list2;
    }
}