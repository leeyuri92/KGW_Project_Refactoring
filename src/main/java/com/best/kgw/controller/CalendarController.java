package com.best.kgw.controller;

import com.best.kgw.service.CalendarService;
import com.vo.CalendarVO;
import com.vo.NoticeBoardVO;
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
@RequestMapping("/calendar/*")
public class CalendarController {
    Logger logger = LoggerFactory.getLogger(CalendarController.class);
    @Autowired
    private CalendarService calendarService;

    @GetMapping("myCalendarList")
    public String myCalendarList(@RequestParam Map<String, Object> cMap, Model model){
        List<Map<String, Object>> myCalendarList;
        logger.info("calendarController: myCalendarList 호출");
        myCalendarList = calendarService.myCalendarList(cMap);
        logger.info(myCalendarList.toString());
        model.addAttribute("myCalendarList", myCalendarList);
        return "forward:/calendar/calendar.jsp";
    }

    @GetMapping("teamCalendarList")
    public String teamCalendarList(@RequestParam Map<String, Object> tMap, Model model){
        List<Map<String, Object>> teamCalendarList;
        logger.info("calendarController: teamCalendarList 호출");
        teamCalendarList = calendarService.teamCalendarList(tMap);
        logger.info(teamCalendarList.toString());
        model.addAttribute("teamCalendarList", teamCalendarList);
        return "forward:/calendar/teamCalendar.jsp";
    }

    @GetMapping("companyCalendarList")
    public String companyCalendarList(@RequestParam Map<String, Object> cpMap, Model model){
        List<Map<String, Object>> companyCalendarList;
        logger.info("calendarController: companyCalendarList 호출");
        companyCalendarList = calendarService.companyCalendarList(cpMap);
        logger.info(companyCalendarList.toString());
        model.addAttribute("companyCalendarList", companyCalendarList);
        return "forward:/calendar/companyCalendar.jsp";
    }

    @GetMapping("calendarDetail")
    // 상세조회
    public String calendarDetail(@RequestParam Map<String, Object> cdMap, Model model) throws Exception {
        logger.info("calendarDetail");
        List<Map<String, Object>> calendarDetail = calendarService.calendarDetail(cdMap);
        model.addAttribute("calendarDetail", calendarDetail);
        logger.info(calendarDetail.toString());
        return "forward:/calendar/calendar.jsp";
    }

    @PostMapping("/insertCalendar")
    @ResponseBody
    public ResponseEntity<String> insertCalendar(CalendarVO calendarVO) {
        logger.info("등록 컨트롤러 호출");

        ResponseEntity<String> entity = null;

        try {
            calendarService.insertCalendar(calendarVO);
            logger.info("등록 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 등록 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/deleteCalendar")
    @ResponseBody
    public ResponseEntity<String> deleteCalList(CalendarVO calendarVO) {
        logger.info("삭제 컨트롤러 호출");
        logger.info(Integer.toString(calendarVO.getCalendar_no()));
        int calendar_no = calendarVO.getCalendar_no();
        ResponseEntity<String> entity = null;

        try {
            calendarService.deleteCalList(calendar_no);
            logger.info("삭제 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 삭제 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/updateCalendar")
    @ResponseBody
    public ResponseEntity<String> updateCalendar(CalendarVO calendarVO) {
        logger.info("업데이트 컨트롤러 호출");

        ResponseEntity<String> entity = null;

        try {
            calendarService.updateCalendar(calendarVO);
            logger.info("업데이트 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 업데이트 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @PostMapping("/deleteTodayCalendar")
    @ResponseBody
    public ResponseEntity<String> deleteTodayCalendar(CalendarVO calendarVO) {
        logger.info("삭제 컨트롤러 호출");
        logger.info(Integer.toString(calendarVO.getCalendar_no()));
        int calendar_no = calendarVO.getCalendar_no();
        ResponseEntity<String> entity = null;

        try {
            calendarService.deleteTodayCalendar(calendar_no);
            logger.info("삭제 DB 연결 시도");
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            logger.info("예외 발생 삭제 DB 처리 못함");
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return entity;
    }

    @GetMapping("calList")
    public String calList(@RequestParam Map<String, Object> calMap, Model model){
        logger.info("calendarController : calList 호출");
        List<Map<String ,Object>> calList = null;
        calList = calendarService.calList(calMap);
        model.addAttribute("calList", calList);
        logger.info(calList.toString());
        return "forward:/calendar/calendar.jsp";
    }

    @GetMapping("myCalList")
    public String myCalList(@RequestParam Map<String, Object>myCalMap, Model model){
        logger.info("calendarController : myCalList 호출");
        List<Map<String ,Object>> myCalList = null;
        myCalList = calendarService.myCalList(myCalMap);
        model.addAttribute("myCalList", myCalList);
        logger.info(myCalList.toString());
        return "forward:/calendar/calendar.jsp";
    }

}

