package com.best.kgw.service.impl;

import com.best.kgw.dao.PlayerDao;
import com.best.kgw.service.PlayerService;
import com.vo.HittersVO;
import com.vo.PitchersVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class PlayerServiceImpl  implements PlayerService {
    Logger logger=LoggerFactory.getLogger("PlayerService".getClass());
    @Autowired
    PlayerDao playerDao;

    @Override
    public List<HittersVO> hitterList(HittersVO hittersVO){
        List<HittersVO >list=new ArrayList<>();
        list=playerDao.hitterList(hittersVO);
        logger.info("hMap"+hittersVO);
        return list;
    }
    @Override
    public List<PitchersVO> pitcherList(PitchersVO pitchersVO){
        List<PitchersVO >list2=new ArrayList<>();
        list2=playerDao.pitcherList(pitchersVO);
        return list2;
    }
}
