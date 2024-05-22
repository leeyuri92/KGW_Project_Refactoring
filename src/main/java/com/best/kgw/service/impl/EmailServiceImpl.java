package com.best.kgw.service.impl;

import com.best.kgw.auth.EmailMessage;
import com.best.kgw.dao.LoginDao;
import com.best.kgw.service.EmailService;
import com.best.kgw.service.LoginService;
import com.vo.EmpVO;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {
    Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

    @Autowired
    private final JavaMailSender javaMailSender;

    @Autowired
    private LoginDao loginDao;


    /**********************************************************************************
     작성자 : 이유리
     작성일자 : 24.02.29
     기능 : 비밀번호찾기 구현
     **********************************************************************************/
    @Override
    public String sendMail(EmailMessage emailMessage, String type) throws Exception{
        logger.info("sendMail 호출");

        String authNum = createCode();
        String mailCon = "임시비밀번호의 값은 " + authNum + " 입니다.";
        emailMessage.setEncPW(authNum);

        logger.info("authNum : " + authNum);
//        logger.info("emailMessage.getMessage : " + mailCon);
//        logger.info("emailMessage.getSubject : " + emailMessage.getSubject());
//        logger.info("emailMessage.getTo : " + emailMessage.getTo());
//        logger.info("emailMessage.getEncPW : " + emailMessage.getEncPW());

        MimeMessage mimeMessage = javaMailSender.createMimeMessage();

        try {
            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
            mimeMessageHelper.setTo(emailMessage.getTo()); // 메일 수신자
            mimeMessageHelper.setSubject(emailMessage.getSubject()); // 메일 제목
            mimeMessageHelper.setText(mailCon, false); // 메일 본문 내용, HTML 여부
            javaMailSender.send(mimeMessage);

            logger.info("Success");

            return authNum;

        } catch (MessagingException e) {
            logger.info("fail");
            throw new RuntimeException(e);
        }
    }

    // 임시 비밀번호 생성
    public String createCode() {
        logger.info("createCode 호출");
        Random random = new Random();
        StringBuffer key = new StringBuffer();

        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(4);

            switch (index) {
                case 0: key.append((char) ((int) random.nextInt(26) + 97)); break;
                case 1: key.append((char) ((int) random.nextInt(26) + 65)); break;
                default: key.append(random.nextInt(9));
            }
        }
        return key.toString();
    }
}
