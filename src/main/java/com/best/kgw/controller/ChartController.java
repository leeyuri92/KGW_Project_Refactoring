package com.best.kgw.controller;

import com.best.kgw.service.ChartService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.swing.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ChartController {
    Logger logger = LoggerFactory.getLogger(ChartController.class);

    @Autowired
    private ChartService chartService;

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.26
     기능 : 입/퇴사자 차트
     **********************************************************************************/
    @GetMapping("admin/empChart")
    public String empChart(Map<String, Object> hmap, Map<String, Object> rmap, Model model) {
        logger.info("empChart 호출");

//        // 데이터 조회
//        List<Map<String, Object>> hireList = chartService.hireList(hmap);
//        logger.info("hireList (받아온 DB data) : " + hireList);
//
//        // 1차 가공
//        List<List<Object>> hireDataList = new ArrayList<>();
//        List<Object> header = Arrays.asList("YEAR", "입사자 수");
//        hireDataList.add(header);
//        for (Map<String, Object> entry : hireList) {
//            List<Object> row = new ArrayList<>();
//            row.add(entry.get("HIREYEAR").toString());
//            row.add(entry.get("COUNT"));
//            hireDataList.add(row);
//        }
//        logger.info("hireDataList : " + hireDataList);

//// 모델에 추가
//        model.addAttribute("hireList", hireList);
//        model.addAttribute("hireDataList", hireDataList);

        // 1. 입사자 차트
        List<Map<String, Object>> hireList = chartService.hireList(hmap);
        logger.info("hireList (받아온 DB data) : " + hireList);
        model.addAttribute("hireList", hireList);

        // 1차 가공
        List<Object[]> hireDataList = new ArrayList<>();
        String[] hs = {"YEAR", "입사자 수"};
        hireDataList.add(hs);
        for (Map<String, Object> entry : hireList) {
            hireDataList.add(new Object[]{entry.get("HIREYEAR").toString(), entry.get("COUNT")});
        }
        logger.info("hireDataList : " + hireDataList);  // 객체[]라서 주소값으로 나올것 -> Json으로 바꿔야 값이 나옴(2차 가공)

        // 2차 가공
        Gson g = new Gson();
        String hireChart = g.toJson(hireDataList);
        logger.info("hireChart : " + hireChart);
        model.addAttribute("hireChart", hireChart);

        // 2. 퇴사자 차트
        List<Map<String, Object>> retireList = chartService.retireList(rmap);
        logger.info("retireList (받아온 DB data) : " + retireList);
        model.addAttribute("retireList", retireList);

        // 1차 가공
        List<Object[]> retireDataList = new ArrayList<>();
        String[] hs2 = {"YEAR", "퇴사자 수"};
        retireDataList.add(hs2);
        for (Map<String, Object> entry : retireList) {
            retireDataList.add(new Object[]{entry.get("RETIREYEAR").toString(), entry.get("COUNT")});
        }
        logger.info("retireDataList : " + retireDataList);  // 객체[]라서 주소값으로 나올것 -> Json으로 바꿔야 값이 나옴(2차 가공)

        // 2차 가공
        g = new Gson();
        String retireChart = g.toJson(retireDataList);
        logger.info("retireChart : " + retireChart);
        model.addAttribute("retireChart", retireChart);

        return "forward:/admin/empChart.jsp";
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.18
     기능 : FAchart 페이지 생성 및 리스트, chart 생성
     **********************************************************************************/
    @GetMapping("manage/FAChart")
    public String faPage(Map<String, Object> fmap, Map<String, Object> wmap, Map<String, Object> kmap, Map<String, Object> pmap, Model model) {
        logger.info("faPage 호출");

        // 1. FA 선수 현황 -  WAR차트
        List<Map<String, Object>> warList = chartService.warList(wmap);
        logger.info("warList (받아온 DB data) : " + warList);
        // 1차 가공
        List<Object[]> warDataList = new ArrayList<>();
        String[] hs = {"NAME", "WAR"};
        warDataList.add(hs);
        for (Map<String, Object> entry : warList) {
            warDataList.add(new Object[]{entry.get("FA_NAME"), entry.get("FA_WAR")});
        }
        logger.info("warDataList : " + warDataList);  // 객체[]라서 주소값으로 나올것 -> Json으로 바꿔야 값이 나옴(2차 가공)
        // 2차 가공
        Gson g = new Gson();
        String warChart = g.toJson(warDataList);
        logger.info("warChart : " + warChart);
        model.addAttribute("warChart", warChart);

        // 2. FA 선수 현황 -  포지션별 차트
        List<Map<String, Object>> positionList = chartService.positionList(pmap);
        logger.info("positionList (받아온 DB data) : " + positionList);
        // 1차 가공
        List<Object[]> pieList = new ArrayList<>();
        String[] hs2 = {"FA_POS", "COUNT"};
        pieList.add(hs2);
        for (Map<String, Object> entry : positionList) {
            pieList.add(new Object[]{entry.get("FA_POS"), entry.get("COUNT")});
        }
        logger.info("pieList : " + pieList);  // 객체[]라서 주소값으로 나올것 -> Json으로 바꿔야 값이 나옴(2차 가공)
        // 2차 가공
        g = new Gson();
        String positionChart = g.toJson(pieList);
        logger.info("positionChart : " + positionChart);
        model.addAttribute("positionChart", positionChart);

        // 3. FA 선수 명단
        List<Map<String, Object>> faList = chartService.faList(fmap);
        logger.info("faList : " + faList);
        model.addAttribute("faList", faList);

        // 4. FA 선수 명단 - WAR 비교차트_키움
        double kiwoomWar = chartService.kiwoomWar(kmap);
        logger.info("kiwoomWar : " + kiwoomWar);
        model.addAttribute("kiwoomWar", kiwoomWar);

        return "forward:/strategy/FAchart.jsp";
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.21
     기능 : 등록/방출에 따른 WAR값 업데이트
     **********************************************************************************/
    @GetMapping("faUpdate")
    @ResponseBody // Ajax 처리 시 넘기는 값이 없어도 필요
    public void faUpdate(@RequestParam Map<String, Object> k_id) {
        logger.info("faUpdate : "+k_id);
        chartService.faUpdate(k_id);
    }

    @GetMapping("faWar")
    @ResponseBody // Ajax 처리 시 값을 넘길 때 필요
    public double faWar(Map<String, Object> fmap) {
        // fa 선수 추가했을 시 WAR 평균값 불러오기
        double faWar = chartService.kiwoomWar(fmap);
        logger.info("faWar : " + faWar);
        return faWar ;
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.27
     기능 : 검색기 비동기 처리
     **********************************************************************************/
    @GetMapping("/manage/searchFA")
    @ResponseBody
    public String searchFA (@RequestParam Map<String, Object> smap) {
        logger.info("searchFA 호출");
        List<Map<String, Object>> searchFA = chartService.faList(smap);
        logger.info("searchFA : " + searchFA);

        Gson g = new Gson();
        String faJson = g.toJson(searchFA);
        logger.info(faJson);
        return faJson;
    }

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.28
     기능 : 등록/방출 버튼 기본값으로 초기화
     **********************************************************************************/
    @GetMapping("faInit")
    public String faInit(Map<String, Object> imap) {
        logger.info("faInit");
        chartService.faInit(imap);
        return "redirect:manage/FAChart";
    }
}
