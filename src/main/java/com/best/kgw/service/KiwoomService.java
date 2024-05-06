package com.best.kgw.service;

import com.vo.KChartVO;

import java.util.List;

public interface KiwoomService {

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.27
     기능 : 선수조회 인터페이스
     **********************************************************************************/
    public List<KChartVO> kiwoomList(KChartVO kChartVO);

}
