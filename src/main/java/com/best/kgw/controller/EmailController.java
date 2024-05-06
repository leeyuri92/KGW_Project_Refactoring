package com.best.kgw.controller;

import com.best.kgw.auth.EmailMessage;
import com.best.kgw.service.EmailService;
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

    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.29
     기능 : 비밀번호찾기 구현
     **********************************************************************************/
    @PostMapping("/sendPassword")
    @ResponseBody
    public ResponseEntity sendPasswordEmail (String email) throws Exception {
        logger.info("입력받은 email : " + email);

        EmailMessage emailMessage = EmailMessage.builder()
                .to(email)
                .subject("임시비밀번호입니다.")
                .build();

        emailService.sendMail(emailMessage, "password");

        return ResponseEntity.ok().build();
    }
}
