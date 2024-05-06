package com.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MediaNoticeCommendVO {
 private Integer commend_no;
 private Integer board_no;
 private Integer emp_no;
 private String commend_content;
 private String reg_date;
 private String mod_date;
 private String name;
 private String profile_img;
 private Integer commend_cnt;

 @Override
 public String toString() {
  return "MediaNoticeCommendVO{" +
          "commend_no=" + commend_no +
          ", board_no=" + board_no +
          ", emp_no=" + emp_no +
          ", commend_content='" + commend_content + '\'' +
          ", reg_date='" + reg_date + '\'' +
          ", mod_date='" + mod_date + '\'' +
          ", name='" + name + '\'' +
          ", profile_img='" + profile_img + '\'' +
          ", commend_cnt=" + commend_cnt +
          '}';
 }
}
