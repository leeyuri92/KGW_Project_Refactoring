package com.vo;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class HittersVO {
    private  int h_no;
    private String h_name; //  H_소속
    private String h_team; //  H_팀
    private Double h_avg; //  H_타울
    private Integer h_ab; //  H_타수
    private Integer h_h; //  H_안타
    private Integer h_hr; //  H_홈런
    private Integer h_r; //  H_득점
    private Integer h_rbi; //  H_탐점
    private Integer h_so; //  H_삼진
    private Integer h_sb; //  H_도루
    private Double h_obp; //  H_출루율
    private Double h_slg; //  H_장타율
    private Double h_war; //  H_WAR
    private Double h_ops; //  H_OPS
    private Integer h_bb;


    @Builder
    public HittersVO( int h_no, String h_name, String h_team, Double h_avg, Integer h_ab, Integer h_h,
                     Integer h_hr, Integer h_r, Integer h_rbi, Integer h_so, Integer h_sb,
                     Double h_obp, Double h_slg, Double h_war, Double h_ops, Integer h_bb) {
        super();
        this.h_no=h_no;
        this.h_name = h_name;
        this.h_team = h_team;
        this.h_avg = h_avg;
        this.h_ab = h_ab;
        this.h_h = h_h;
        this.h_hr = h_hr;
        this.h_r = h_r;
        this.h_rbi = h_rbi;
        this.h_so = h_so;
        this.h_sb = h_sb;
        this.h_obp = h_obp;
        this.h_slg = h_slg;
        this.h_war = h_war;
        this.h_ops = h_ops;
        this.h_bb = h_bb;

    }



}
