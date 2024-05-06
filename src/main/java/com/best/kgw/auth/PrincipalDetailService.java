package com.best.kgw.auth;

import com.best.kgw.dao.impl.LoginDaoImpl;
import com.vo.EmpVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class PrincipalDetailService implements UserDetailsService {
    Logger logger = LoggerFactory.getLogger(PrincipalDetailService.class);

    @Autowired
    private LoginDaoImpl loginDaoImpl;

    @Override
    public UserDetails loadUserByUsername(String emp_no) throws UsernameNotFoundException {
        logger.info("loadUserByUsername() 호출");
        logger.info("입력 받은 값 : " + emp_no); // 파라미터로 사용자가 입력한 이름이 담김
        EmpVO empVO = null;
        try {
            empVO = loginDaoImpl.login(emp_no);
            logger.info("empVO : " + empVO);
            if (empVO != null && empVO.getEmp_state().equals("1")) {
                logger.info("입력 받은 값과 일치하는 DB 찾음 > PrincipalDetails 이동 ");
                return new PrincipalDetails(empVO);
            }
            return null;
        } catch (Exception e) {
            logger.info("일치하는 값 없음");
            throw new RuntimeException(e);
        }
    }
}
