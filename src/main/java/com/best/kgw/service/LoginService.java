package com.best.kgw.service;

import java.util.Map;
/**********************************************************************************
 작성자 : 이유리
 작성일자 : 24.02.26
 기능 : Security Login 구현
 **********************************************************************************/
public interface LoginService {

    public String findId(Map<String, Object> fmap) throws Exception;

    String findPw(String emp_no) throws Exception;
}
