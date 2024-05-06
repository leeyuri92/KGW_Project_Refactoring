package com.best.kgw.controller;

import com.best.kgw.service.KiwoomService;
import com.vo.KChartVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller()
@RequestMapping("kiwoom")
public class KiwoomController {

    Logger logger = LoggerFactory.getLogger(KiwoomController.class);

    @Autowired
    private KiwoomService kiwoomService;
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.27
     기능 : 선수조회 컨트롤러
     **********************************************************************************/
    @GetMapping("kiwoomList")
    public String kiwoomList(KChartVO kChartVO, Model model) throws Exception{
        logger.info("Controller : kiwoomList 호출");
        List<KChartVO> kList = kiwoomService.kiwoomList(kChartVO);
        model.addAttribute("kList", kList);
        logger.info(kList.toString());
        return "forward:/kiwoom/kiwoomSearch.jsp";
    }
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.27
     기능 : 선수상세조회 컨트롤러
     **********************************************************************************/
    @GetMapping("kiwoomDetail")
    public String kiwoomDetail( KChartVO kChartVO , Model model) {
        logger.info("kiwoomDetail");
        List<KChartVO> kList = kiwoomService.kiwoomList(kChartVO);
        model.addAttribute("kList", kList);
        return "forward:/kiwoom/kiwoomDetail.jsp";
    }
}
