package com.best.kgw.dao.impl;

import com.best.kgw.auth.EmailMessage;
import com.best.kgw.dao.LoginDao;
import com.vo.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class LoginDaoImpl implements LoginDao {
  Logger logger = LoggerFactory.getLogger(LoginDaoImpl.class);

  @Autowired
  private BCryptPasswordEncoder bCryptPasswordEncoder;

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate ;

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.26
   기능 : Security Login 구현
   **********************************************************************************/
  @Override
  public EmpVO login(String emp_no) throws Exception {
    logger.info("login() 호출 - 입력받은 값 : " + emp_no);
    EmpVO empVO = null;
    try {
      empVO = sqlSessionTemplate.selectOne("login", emp_no);
    } catch (Exception e) {
      logger.info(e.toString());
    }
    return empVO;
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.26
   기능 : 사원번호찾기 구현
   **********************************************************************************/
  @Override
  public String findId(Map<String, Object> fmap) throws Exception {
    logger.info("findId");
    logger.info("fmap : " + fmap);
    String id = sqlSessionTemplate.selectOne("findId", fmap);
    logger.info("찾은 id 값 : " + id);
    return id;
  }

  /**********************************************************************************
   작성자 : 이유리
   작성일자 : 24.02.29
   기능 : 비밀번호찾기 구현
   **********************************************************************************/
  @Override
  public String findPw(String emp_no) throws Exception {
    logger.info("findPw");
    logger.info("emp_no : " + emp_no);
    String email = sqlSessionTemplate.selectOne("emp_no", emp_no);
    logger.info("찾은 email 값 : " + email);
    return email;
  }

  @Override
  public int updatePw(EmailMessage emailMessage) throws Exception {
    logger.info("updatePw");
    // 임시비밀번호 암호화
    String rowNum = emailMessage.getEncPW();
    String encNum =bCryptPasswordEncoder.encode(rowNum);
    emailMessage.setEncPW(encNum);
    int result = sqlSessionTemplate.update("updatePw", emailMessage);
    logger.info("result : " + result);
    return result;
  }

  @Override
  public int updatePW(EmpVO empVO) {
    logger.info("updatePW");
    int result = sqlSessionTemplate.update("updatePW", empVO);
    logger.info("result : " + result);
    return result;
  }
} 