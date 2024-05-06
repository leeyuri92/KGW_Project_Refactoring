package com.vo;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**********************************************************************************
 작성자 : 박병현
 작성일자 : 24.02.19
 기능 : EmpVO
 **********************************************************************************/
@Data
@NoArgsConstructor
public class EmpVO {


    private int emp_no;
    private int team_no;
    private String team_name;
    private String emp_access;
    private String emp_position;
    private String dayoff_yn;
    private int dayoff_cnt;
    private String emp_year;
    private String hire_date;
    private String retire_date;
    private String emp_state;
    private String password;
    private String name;
    private String email;
    private String birthdate;
    private String phone_num;
    private String address;
    private String reg_date;
    private String mod_date;
    private String profile_img;
    private String gubun;
    private String keyword;

    @Override
    public String toString() {
        return "EmpVO{" +
                "emp_no=" + emp_no +
                ", team_no=" + team_no +
                ", team_name='" + team_name + '\'' +
                ", emp_access='" + emp_access + '\'' +
                ", emp_position='" + emp_position + '\'' +
                ", dayoff_yn='" + dayoff_yn + '\'' +
                ", dayoff_cnt=" + dayoff_cnt +
                ", emp_year='" + emp_year + '\'' +
                ", hire_date='" + hire_date + '\'' +
                ", retire_date='" + retire_date + '\'' +
                ", emp_state='" + emp_state + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", birthdate='" + birthdate + '\'' +
                ", phone_num='" + phone_num + '\'' +
                ", address='" + address + '\'' +
                ", reg_date='" + reg_date + '\'' +
                ", mod_date='" + mod_date + '\'' +
                ", profile_img='" + profile_img + '\'' +
                ", gubun='" + gubun + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}
