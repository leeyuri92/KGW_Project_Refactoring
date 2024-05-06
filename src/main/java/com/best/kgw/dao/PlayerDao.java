package com.best.kgw.dao;

import com.vo.HittersVO;
import com.vo.PitchersVO;

import java.util.List;
import java.util.Map;

public interface PlayerDao {

    List<HittersVO > hitterList(HittersVO hittersVO);


    List<PitchersVO>pitcherList(PitchersVO pitchersVO);
}
