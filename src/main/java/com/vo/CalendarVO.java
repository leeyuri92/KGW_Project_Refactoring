package com.vo;


import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CalendarVO {
    private int calendar_no;
    private int calendar_id;
    private String calendar_title;
    private String calendar_memo;
    private String calendar_start;
    private String calendar_end;
    private String calendar_rid;

    private int asset_no;
    private String asset_id;
    private String asset_name;
    private int team_no;
    private boolean availability;
    private String asset_color;
    private int reservation_no;
    private int emp_no;
    private String name;
    private String reservation_title;
    private String reservation_id;
    private String reservation_content;
    private String reservation_start;
    private String reservation_end;

    @Override
    public String toString() {
        return "CalendarVO{" +
                "calendar_no=" + calendar_no +
                ", calendar_id=" + calendar_id +
                ", calendar_title='" + calendar_title + '\'' +
                ", calendar_memo='" + calendar_memo + '\'' +
                ", calendar_start='" + calendar_start + '\'' +
                ", calendar_end='" + calendar_end + '\'' +
                ", calendar_rid='" + calendar_rid + '\'' +
                ", asset_no=" + asset_no +
                ", asset_id='" + asset_id + '\'' +
                ", asset_name='" + asset_name + '\'' +
                ", team_no=" + team_no +
                ", availability=" + availability +
                ", asset_color='" + asset_color + '\'' +
                ", reservation_no=" + reservation_no +
                ", emp_no=" + emp_no +
                ", name='" + name + '\'' +
                ", reservation_title='" + reservation_title + '\'' +
                ", reservation_id='" + reservation_id + '\'' +
                ", reservation_content='" + reservation_content + '\'' +
                ", reservation_start='" + reservation_start + '\'' +
                ", reservation_end='" + reservation_end + '\'' +
                '}';
    }
}

