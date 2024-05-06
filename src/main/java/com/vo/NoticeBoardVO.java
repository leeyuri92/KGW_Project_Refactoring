package com.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeBoardVO {
    private Integer notice_no;
    private Integer emp_no;
    private String notice_title;
    private String notice_content;
    private String category;
    private Integer notice_hit;
    private boolean notice_pin;
    private String pin_start;
    private String pin_end;
    private String reg_date;
    private String mod_date;
    private String gubun;
    private String keyword;
    private String name;

    @Override
    public String toString() {
        return "NoticeBoardVO{" +
                "notice_no=" + notice_no +
                ", emp_no=" + emp_no +
                ", notice_title='" + notice_title + '\'' +
                ", notice_content='" + notice_content + '\'' +
                ", category='" + category + '\'' +
                ", notice_hit=" + notice_hit +
                ", notice_pin=" + notice_pin +
                ", pin_start='" + pin_start + '\'' +
                ", pin_end='" + pin_end + '\'' +
                ", reg_date='" + reg_date + '\'' +
                ", mod_date='" + mod_date + '\'' +
                ", gubun='" + gubun + '\'' +
                ", keyword='" + keyword + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
