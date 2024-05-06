package com.best.kgw.auth;


import com.vo.EmpVO;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

@Data
public class PrincipalDetails implements UserDetails {
//    private static final long serialVersionUID = 1L; // 직렬화 버전 명시
    Logger logger = LoggerFactory.getLogger(PrincipalDetails.class);

    private EmpVO empVO;

    public PrincipalDetails(EmpVO empVO) {
        this.empVO = empVO;
    }


    // 해당 User의 권한 리턴
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
        collect.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                logger.info("getAuthority : " + empVO.getEmp_access());
                return empVO.getEmp_access();
            }
        });
        return collect;
    }

    //  DB와 매칭 실패 시 loginFail.jsp 호출
    @Override
    public String getPassword() {
        logger.info("getPassword : " + empVO.getPassword());
        return empVO.getPassword();
    }

    @Override
    public String getUsername() {
        logger.info("getUsername = " + empVO.getName());
        return empVO.getName();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
