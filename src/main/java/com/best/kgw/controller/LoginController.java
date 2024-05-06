package com.best.kgw.controller;

import com.best.kgw.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class LoginController {
  Logger logger = LoggerFactory.getLogger(LoginController.class);

  @Autowired
  private LoginService loginService;

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.26
   기능 : Security Login 구현
   **********************************************************************************/
  @GetMapping("/login")
  public String loginPage() {
    logger.info("loginPage() 호출");
    return "forward:auth/login.jsp";
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.26
   기능 : 사원번호찾기 구현
   **********************************************************************************/
  @PostMapping("/findId")
  @ResponseBody
  public String findId(@RequestParam Map<String, Object> fmap) {
    logger.info("findId");

    try {
      String id = loginService.findId(fmap);
      logger.info("id : "+id);
      return id;
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.29
   기능 : 비밀번호찾기 구현
   **********************************************************************************/
  @PostMapping("/findPw")
  @ResponseBody
  public String findPw(String emp_no) {
    logger.info("findPw");
    logger.info("emp_no : " + emp_no);

    try {
      String email = loginService.findPw(emp_no);
      logger.info("email : "+email);
      return email;
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.03.01
   기능 : 로그인 실패시 에러처리
   **********************************************************************************/
  @GetMapping("/login-error")
  @ResponseBody
  public String loginError() {
    logger.info("loginError");
    String msg= "loginError";
    return msg;
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.03.01
   기능 :  접근권한 에러처리
   **********************************************************************************/
  @GetMapping("/access-denied")
  public String accessDenied() {
    logger.info("accessDenied");
    return "accessDenied";
  }
}
