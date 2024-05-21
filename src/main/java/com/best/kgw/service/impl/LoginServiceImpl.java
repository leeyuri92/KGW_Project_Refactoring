package com.best.kgw.service.impl;


import com.best.kgw.dao.LoginDao;
import com.best.kgw.service.LoginService;
import com.vo.EmpVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service
public class LoginServiceImpl implements LoginService {
  Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);

  @Autowired
  private LoginDao loginDao;

  @Autowired
  private BCryptPasswordEncoder bCryptPasswordEncoder;

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.26
   기능 : 사원번호찾기 구현
   **********************************************************************************/
  @Override
  public String findId(Map<String, Object> fmap) throws Exception {
    logger.info("findId");
    String id = loginDao.findId(fmap);
    logger.info("id  : " + id);
    return id;
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.29
   기능 : 비밀번호찾기 구현
   **********************************************************************************/
  @Override
  public String findPw(String emp_no) throws Exception {
    logger.info("emp_no: " + emp_no);
    String email = loginDao.findPw(emp_no);
    logger.info("email  : " + email);
    return email;
  }

  @Override
  public int updatePW(EmpVO empVO) {
    logger.info("updatePW");
    // 비밀번호 암호화
    String rowNum = empVO.getPassword();;
    String encNum =bCryptPasswordEncoder.encode(rowNum);
    empVO.setPassword(encNum);
    int result = loginDao.updatePW(empVO);
    logger.info("result : " + result);
    return result;
  }
}
