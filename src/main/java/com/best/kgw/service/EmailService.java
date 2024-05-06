package com.best.kgw.service;

import com.best.kgw.auth.EmailMessage;

public interface EmailService {
    String sendMail(EmailMessage emailMessage, String type) throws Exception;
}
