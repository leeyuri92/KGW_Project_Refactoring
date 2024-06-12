package com.best.kgw.common;

import java.time.Duration;

public class TimeUtil {
    /*********************************************************************
     * 작성일로부터 현재까지의 일 수를 계산하여 시간 경과를 표시
     * 7일 이상이면 원래 날짜 반환
     *
     * @param regDate 작성일을 나타내는 문자열 (형식: "yyyy-MM-dd HH:mm:ss")
     * @return 작성일로부터의 시간 경과를 나타내는 문자열
     *********************************************************************/
    public static String daysBetween(String regDate) {
        // 작성일로부터 현재까지의 시간 경과 계산
        Duration duration = DateCalc.dateCalc(regDate);

        // 시간 차이를 일, 시간, 분, 초 단위로 변환
        long days = duration.toDays();
        long hours = duration.toHours();
        long minutes = duration.toMinutes();
        long seconds = duration.toSeconds();

        // 날짜 차이가 7일 이상인 경우 원래 날짜 문자열을 반환
        if (days > 7) {
            return regDate;
        } else {
            // 날짜 차이를 일, 시간, 분, 초 단위로 계산하여 반환
            if (days != 0) {
                return days + "일 전";
            } else if (hours != 0) {
                return hours + "시간 전";
            } else if (minutes != 0) {
                return minutes + "분 전";
            } else if (seconds >= 0) {
                return seconds + "초 전";
            } else {
                return "0초 전";
            }
        }
    }

    /*********************************************************************
     * 작성일로부터 현재까지의 일 수를 계산하여 NEW 배지 표시
     *
     * @param regDate 작성일을 나타내는 문자열 (형식: "yyyy-MM-dd HH:mm:ss")
     * @return 작성일로부터의 일 수
     *********************************************************************/
    public static long newBadge(String regDate) {
        // 작성일로부터 현재까지의 시간 경과 계산
        Duration duration = DateCalc.dateCalc(regDate);

        // 작성일로부터의 일 수 반환
        return duration.toDays();
    }
}
