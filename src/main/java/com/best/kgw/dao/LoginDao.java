package com.best.kgw.dao;

import com.best.kgw.auth.EmailMessage;
import com.vo.EmpVO;

import java.util.Map;

public interface LoginDao {

  public EmpVO login(String emp_no) throws Exception;

  public String findId(Map<String, Object> fmap) throws Exception;

  String findPw(String emp_no) throws Exception;

  int updatePw(EmailMessage emailMessage) throws Exception;
}
