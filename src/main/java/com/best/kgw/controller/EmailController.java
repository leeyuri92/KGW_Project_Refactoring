package com.best.kgw.controller;

import com.best.kgw.auth.EmailMessage;
import com.best.kgw.service.EmailService;
import com.best.kgw.service.LoginService;
import com.vo.EmpVO;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class EmailController {
    Logger logger = LoggerFactory.getLogger(EmailController.class);

    @Autowired
    private EmailService emailService;

    @Autowired
    private LoginService loginService;

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.29
     기능 : 비밀번호찾기 구현
     **********************************************************************************/
    @PostMapping("/sendPassword")
    @ResponseBody
    public ResponseEntity sendPasswordEmail (EmpVO empVO) throws Exception {
        logger.info("입력받은 email : " + empVO.getEmail());

        EmailMessage emailMessage = EmailMessage.builder()
                .to(empVO.getEmail())
                .subject("임시비밀번호입니다.")
                .build();

        String authNum = emailService.sendMail(emailMessage , "password");
        empVO.setPassword(authNum);
        loginService.updatePW(empVO);

        return ResponseEntity.ok().build();
    }
}
