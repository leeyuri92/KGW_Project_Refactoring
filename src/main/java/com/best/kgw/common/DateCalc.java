package com.best.kgw.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DateCalc {

    /************************************************************************
     * 주어진 날짜 문자열과 현재 날짜 사이의 차이를 계산하여 반환합니다.
     * 만약 차이가 7일 이상이라면 원래의 날짜 문자열을 반환하고,
     * 그렇지 않다면 차이를 일, 시간, 분, 초 단위로 계산하여 반환합니다.
     *
     * @param regDate 문자열 형태의 날짜 (형식: "yyyy-MM-dd HH:mm:ss")
     * @return 날짜 차이를 나타내는 문자열
     * @throws ParseException 날짜 문자열을 파싱할 수 없는 경우 예외를 던집니다.
     ************************************************************************/


        public String daysBetween(String regDate) {
            // 문자열을 LocalDateTime으로 변환
            LocalDateTime regDateTime = LocalDateTime.parse(regDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            // 현재 시간
            LocalDateTime currentDateTime = LocalDateTime.now();

            // 시간 차이 계산
            Duration duration = Duration.between(regDateTime, currentDateTime);

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
    }

//        // SimpleDateFormat을 사용하여 문자열을 Date 객체로 변환
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        Date regDateParsed = dateFormat.parse(regDate);
//
//        // 현재 시간
//        Date date = new Date();
//
//        // 두 날짜의 시간 차이를 밀리초 단위로 계산
//        long differenceInMilliSeconds = date.getTime() - regDateParsed.getTime();
//
//        // 밀리초를 초, 분, 시간, 일 단위로 변환
//        long differenceInSeconds = differenceInMilliSeconds / 1000;
//        long differenceInMinutes = differenceInSeconds / 60;
//        long differenceInHours = differenceInMinutes / 60;
//        long differenceInDays = differenceInHours / 24;
//
//        // 날짜 차이가 7일 이상인 경우 원래 날짜 문자열을 반환
//        if (differenceInDays > 7) {
//            return regDate;
//        } else {
//            // 날짜 차이를 일, 시간, 분, 초 단위로 계산하여 반환
//            if (differenceInDays != 0) {
//                return differenceInDays + "일 전";
//            } else if (differenceInHours != 0) {
//                return differenceInHours + "시간 전";
//            } else if (differenceInMinutes != 0) {
//                return differenceInMinutes + "분 전";
//            } else if (differenceInSeconds >= 0) {
//                return differenceInSeconds + "초 전";
//            } else {
//                return "0초 전";
//            }
//        }
//    }


