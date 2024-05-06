package com.best.kgw.controller;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SessionController {
    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.03.03
     기능 : 세션시간 설정
     **********************************************************************************/
    @GetMapping("/extendSessionTime")
    public int extendSessionTime(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            // 현재 세션 시간 가져오기
            int currentTimeout = session.getMaxInactiveInterval();
            // 세션 시간 연장 (예: 5분 추가)
            int extendedTimeout =  (5 * 60);
            // 세션 시간을 연장한 후 반환
            session.setMaxInactiveInterval(extendedTimeout);
            return extendedTimeout;
        } else {
            // 세션 없음 또는 이미 만료된 경우
            return 0;
        }
    }
}
