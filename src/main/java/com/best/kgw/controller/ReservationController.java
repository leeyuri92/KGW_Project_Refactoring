package com.best.kgw.controller;

import com.best.kgw.service.ReservationService;
import com.vo.CalendarVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/assetReservation/*")
public class ReservationController {
    Logger logger = LoggerFactory.getLogger(ReservationController.class);
    @Autowired
    private ReservationService reservationService;

    @GetMapping("assetReservationList")
    public String assetReservationList(@RequestParam Map<String, Object> aMap1,@RequestParam Map<String, Object> aMap2, @RequestParam Map<String, Object> arMap, Model model){
        List<Map<String, Object>> assetList1;
        List<Map<String, Object>> assetList2;
        List<Map<String, Object>> assetReservationList;
        logger.info("ReservationController: assetList1 호출");
        logger.info("ReservationController: assetList2 호출");
        logger.info("ReservationController: assetReservationList 호출");
        assetList1 = reservationService.assetList1(aMap1);
        assetList2 = reservationService.assetList2(aMap2);
        assetReservationList = reservationService.assetReservationList(arMap);
        model.addAttribute("assetList1", assetList1);
        model.addAttribute("assetList2", assetList2);
        model.addAttribute("assetReservationList", assetReservationList);
        logger.info(assetList1.toString());
        logger.info(assetList2.toString());
        logger.info(assetReservationList.toString());
        return "forward:/reservation/assetReservation.jsp";
    }

    @PostMapping("/insertReservation")
    @ResponseBody
    public ResponseEntity<String> insertReservation(CalendarVO calendarVO) {
        logger.info("등록 컨트롤러 호출");
        ResponseEntity<String> entity = null;
        try {
            int result = reservationService.insertReservation(calendarVO);
            if (result > 0) {
                entity = new ResponseEntity<>("1", HttpStatus.OK); // 성공적으로 예약이 되었을 때
            } else {
                entity = new ResponseEntity<>("0", HttpStatus.OK); // 이미 예약이 있는 경우
            }
        } catch (Exception e) {
            logger.info("예외 발생 등록 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/deleteReservation")
    @ResponseBody
    public ResponseEntity<String> deleteReservation(CalendarVO calendarVO) {
        logger.info("삭제 컨트롤러 호출");

        ResponseEntity<String> entity = null;

        try {
            reservationService.deleteReservation(calendarVO);
            logger.info("삭제 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 삭제 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/updateReservation")
    @ResponseBody
    public ResponseEntity<String> updateReservation(CalendarVO calendarVO) {
        logger.info("업데이트 컨트롤러 호출");

        ResponseEntity<String> entity = null;

        try {
            reservationService.updateReservation(calendarVO);
            logger.info("업데이트 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 업데이트 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/deleteTodayReservation")
    @ResponseBody
    public ResponseEntity<String> deleteTodayReservation(CalendarVO calendarVO) {
        logger.info("삭제 컨트롤러 호출");
        logger.info(Integer.toString(calendarVO.getReservation_no()));
        int reservation_no = calendarVO.getReservation_no();
        ResponseEntity<String> entity = null;

        try {
            reservationService.deleteTodayReservation(reservation_no);
            logger.info("삭제 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 삭제 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }


    @GetMapping("reservList")
    public String reservList(@RequestParam Map<String, Object> reservMap, Model model){
        logger.info("reservationService : reservList 호출");
        List<Map<String ,Object>> reservList = null;
        reservList = reservationService.reservList(reservMap);
        model.addAttribute("reservList", reservList);
        logger.info(reservList.toString());
        return "forward:/reservation/assetReservation.jsp";
    }

    @GetMapping("myReservList")
    public String myReservList(@RequestParam Map<String, Object>myReservMap, Model model){
        logger.info("reservationService : myReservList 호출");
        List<Map<String ,Object>> myReservList = null;
        myReservList = reservationService.myReservList(myReservMap);
        model.addAttribute("myReservList", myReservList);
        logger.info(myReservList.toString());
        return "forward:/reservation/assetReservation.jsp";
    }
}

