package com.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MediaNoticeVO {
    private Integer board_no;
    private Integer emp_no;
    private String board_title;
    private String board_content;
    private String reg_date;
    private Integer board_hit;
    private String mod_date;
    private String filename;
    private String gubun;
    private String keyword;
    private String name;
    private String profile_img;
    private Integer commend_cnt;

    @Override
    public String toString() {
        return "MediaNoticeVO{" +
                "board_no=" + board_no +
                ", emp_no=" + emp_no +
                ", board_title='" + board_title + '\'' +
                ", board_content='" + board_content + '\'' +
                ", reg_date='" + reg_date + '\'' +
                ", board_hit=" + board_hit +
                ", mod_date='" + mod_date + '\'' +
                ", filename='" + filename + '\'' +
                ", gubun='" + gubun + '\'' +
                ", keyword='" + keyword + '\'' +
                ", name='" + name + '\'' +
                ", profile_img='" + profile_img + '\'' +
                ", commend_cnt=" + commend_cnt +
                '}';
    }
}