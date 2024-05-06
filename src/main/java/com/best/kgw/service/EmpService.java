package com.best.kgw.service;

import com.vo.EmpVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class EmpService {
    Logger logger = LoggerFactory.getLogger(EmpService.class);

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    // 매월 1일에 실행
    @Scheduled(cron = "0 0 0 1 * ?")
    public void monthlyTask() {
        try {
            sqlSessionTemplate.update("updateMonthDayoff_cnt");
        }catch (Exception e) {
            // 예외 발생 시 로그 출력 또는 예외 처리 로직 추가
            e.printStackTrace();
        }
    }

    // 1월 1일 자정에만 실행
    @Scheduled(cron = "0 0 0 1 1 ?")
    public void firstOfYearTask() {
        try {
            logger.info("되라제발!!!!");
            sqlSessionTemplate.update("updateYearDayoff_cnt");
        }catch (Exception e) {
            // 예외 발생 시 로그 출력 또는 예외 처리 로직 추가
            e.printStackTrace();
        }
    }
}
