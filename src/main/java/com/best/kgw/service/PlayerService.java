package com.best.kgw.service;

import com.vo.HittersVO;
import com.vo.PitchersVO;

import java.util.List;
import java.util.Map;

public interface PlayerService {

    List<HittersVO> hitterList(HittersVO hittersVO);


    List<PitchersVO> pitcherList(PitchersVO pitchersVO);
}
