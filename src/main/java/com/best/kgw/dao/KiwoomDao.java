package com.best.kgw.dao;

import com.vo.KChartVO;

import java.util.List;
import java.util.Map;

public interface KiwoomDao {
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.27
     기능 : 선수조회 인터페이스
     **********************************************************************************/
    public List<KChartVO>  kiwoomList(KChartVO kChartVO);

}
