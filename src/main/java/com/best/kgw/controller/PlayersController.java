package com.best.kgw.controller;

import com.best.kgw.service.PlayerService;
import com.vo.HittersVO;
import com.vo.PitchersVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("player")
public class PlayersController {
    @Autowired
    private PlayerService playerService;

    Logger logger = LoggerFactory.getLogger("PlayersController".getClass());

    @GetMapping("/HittersList")
    public String hitterList(Model model, HittersVO hittersVO)  throws  Exception{
        List<HittersVO> list = playerService.hitterList(hittersVO);
        model.addAttribute("list", list);
        return "forward:HittersList.jsp";

    }
    @GetMapping("/HitterDetail")
    public String hitterDetail(Model model, HittersVO hittersVO) throws  Exception {
    List<HittersVO> hitterDetail = playerService.hitterList(hittersVO);
    model.addAttribute("hitterDetail", hitterDetail);
    logger.info("DetailHitter");
    return "forward:HitterDetail.jsp";

}

    @GetMapping("/PitchersList")
    public String pitcherList(Model model, PitchersVO pitchersVO)  throws  Exception {
        List<PitchersVO> list2 = playerService.pitcherList(pitchersVO);
        model.addAttribute("list2", list2);
        return "forward:PitchersList.jsp";
    }


    @GetMapping("/PitcherDetail")
// 상세조회
    public String pitcherDetail(PitchersVO pitchersVO, Model model) throws Exception {
        List<PitchersVO>  pitcherDetail = playerService.pitcherList(pitchersVO);
        model.addAttribute("pitcherDetail", pitcherDetail);
        return "forward:PitcherDetail.jsp";
    }

}
