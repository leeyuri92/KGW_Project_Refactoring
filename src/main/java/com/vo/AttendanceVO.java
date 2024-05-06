package com.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AttendanceVO {

    private int attendance_no;
    private int emp_no;
    private String name;
    private String work_date;
    private String start_time;
    private String end_time;
    private String state;
    private String reg_date;
    private String request_content;
    private String gubun;
    private String keyword;

    @Override
    public String toString() {
        return "AttendanceVO{" +
                "attendance_no=" + attendance_no +
                ", emp_no=" + emp_no +
                ", name='" + name + '\'' +
                ", work_date='" + work_date + '\'' +
                ", start_time='" + start_time + '\'' +
                ", end_time='" + end_time + '\'' +
                ", state='" + state + '\'' +
                ", reg_date='" + reg_date + '\'' +
                ", request_content='" + request_content + '\'' +
                ", gubun='" + gubun + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}
