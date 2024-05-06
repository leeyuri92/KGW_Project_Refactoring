package com.best.kgw.service;

import java.util.List;
import java.util.Map;

public interface ChartService {
    List<Map<String, Object>> hireList(Map<String, Object> hmap);

    List<Map<String, Object>> retireList(Map<String, Object> rmap);

    List<Map<String, Object>> warList(Map<String, Object> wmap);

    List<Map<String, Object>> positionList(Map<String, Object> pmap);

    List<Map<String, Object>> faList(Map<String, Object> fmap);

    double kiwoomWar(Map<String, Object> kmap);

    void faInit(Map<String, Object> imap);

    void faUpdate(Map<String, Object> FA_NO);


}
