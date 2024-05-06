package com.best.kgw.controller;

import com.best.kgw.service.ReservationService;
import com.best.kgw.service.VehicleReservationService;
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
@RequestMapping("/vehicleReservation/*")
public class VehicleReservationController {
    Logger logger = LoggerFactory.getLogger(VehicleReservationController.class);
    @Autowired
    private VehicleReservationService vehicleReservationService;

    @GetMapping("vehicleReservationList")
    public String vehicleReservationList(@RequestParam Map<String, Object> aMap, @RequestParam Map<String, Object> arMap, Model model){
        List<Map<String, Object>> vehicleList;
        List<Map<String, Object>> vehicleReservationList;
        logger.info("vehicleReservationController: vehicleList 호출");
        logger.info("vehicleReservationController: vehicleReservationList 호출");
        vehicleList = vehicleReservationService.vehicleList(aMap);
        vehicleReservationList = vehicleReservationService.vehicleReservationList(arMap);
        model.addAttribute("vehicleList", vehicleList);
        model.addAttribute("vehicleReservationList", vehicleReservationList);
        logger.info(vehicleList.toString());
        logger.info(vehicleReservationList.toString());
        return "forward:/reservation/vehicleReservation.jsp";
    }

    @PostMapping("/insertVehicleList")
    @ResponseBody
    public ResponseEntity<String> insertVehicleList(CalendarVO calendarVO) {
        logger.info("등록 컨트롤러 호출");
        ResponseEntity<String> entity = null;
        try {
            int result = vehicleReservationService.insertVehicleList(calendarVO);
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

    @PostMapping("/deleteVehicleList")
    @ResponseBody
    public ResponseEntity<String> deleteVehicleList(CalendarVO calendarVO) {
        logger.info("삭제 컨트롤러 호출");

        ResponseEntity<String> entity = null;

        try {
            vehicleReservationService.deleteVehicleList(calendarVO);
            logger.info("삭제 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 삭제 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/updateVehicleList")
    @ResponseBody
    public ResponseEntity<String> updateVehicleList(CalendarVO calendarVO) {
        logger.info("업데이트 컨트롤러 호출");

        ResponseEntity<String> entity = null;

        try {
            vehicleReservationService.updateVehicleList(calendarVO);
            logger.info("업데이트 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 업데이트 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/deleteTodayVReservation")
    @ResponseBody
    public ResponseEntity<String> deleteTodayVReservation(CalendarVO calendarVO) {
        logger.info("삭제 컨트롤러 호출");
        logger.info(Integer.toString(calendarVO.getReservation_no()));
        int reservation_no = calendarVO.getReservation_no();
        ResponseEntity<String> entity = null;

        try {
            vehicleReservationService.deleteTodayVReservation(reservation_no);
            logger.info("삭제 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 삭제 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }


    @GetMapping("vehicleReservList")
    public String vehicleReservList(@RequestParam Map<String, Object> reservMap, Model model){
        logger.info("vehicleReservationService : vehicleReservList 호출");
        List<Map<String ,Object>> vehicleReservList = null;
        vehicleReservList = vehicleReservationService.vehicleReservList(reservMap);
        model.addAttribute("vehicleReservList", vehicleReservList);
        logger.info(vehicleReservList.toString());
        return "forward:/reservation/vehicleReservation.jsp";
    }

    @GetMapping("myVehicleReservList")
    public String myVehicleReservList(@RequestParam Map<String, Object>myReservMap, Model model){
        logger.info("vehicleReservationService : myReservList 호출");
        List<Map<String ,Object>> myVehicleReservList = null;
        myVehicleReservList = vehicleReservationService.myVehicleReservList(myReservMap);
        model.addAttribute("myVehicleReservList", myVehicleReservList);
        logger.info(myVehicleReservList.toString());
        return "forward:/reservation/vehicleReservation.jsp";
    }
}

