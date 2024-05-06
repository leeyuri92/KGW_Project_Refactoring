package com.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AttendanceModifyVO {
    private int attendancemod_no;
    private int emp_no;
    private int attendance_no;
    private String reg_date;
    private String original_start_time;
    private String original_end_time;
    private String original_state;
    private String request_content;
    private String mod_date;
    private String mod_content;
    private String state;
    private String mod_state;
    private String name;

    @Override
    public String toString() {
        return "AttendanceModifyVO{" +
                "attendancemod_no=" + attendancemod_no +
                ", emp_no=" + emp_no +
                ", attendance_no=" + attendance_no +
                ", reg_date='" + reg_date + '\'' +
                ", original_start_time='" + original_start_time + '\'' +
                ", original_end_time='" + original_end_time + '\'' +
                ", original_state='" + original_state + '\'' +
                ", request_content='" + request_content + '\'' +
                ", mod_date='" + mod_date + '\'' +
                ", mod_content='" + mod_content + '\'' +
                ", state='" + state + '\'' +
                ", mod_state='" + mod_state + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
