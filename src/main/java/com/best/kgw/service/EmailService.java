package com.best.kgw.service;

import com.best.kgw.auth.EmailMessage;
import com.vo.EmpVO;

public interface EmailService {
    String sendMail(EmailMessage emailMessage, String type) throws Exception;
}
