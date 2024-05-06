package com.vo;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class KChartVO {

    private int k_id;
    private int k_no;
    private int k_ss;
    private String k_team;
    private String k_name;
    private int k_num;
    private String k_pos;
    private String k_birth;
    private String K_PHY;
    private int k_hire;
    private double k_war;
    private int k_sal;
    private String k_date;
    private String k_state;
    private int k_year;
    private String gubun;
    private String keyword;

    @Builder
    public KChartVO(int k_id, int k_no, int k_ss, String k_team, String k_name, int k_num, String k_pos, String k_birth, String k_PHY, int k_hire, double k_war, int k_sal, String k_date, String k_state, int k_year, String gubun, String keyword) {
        this.k_id = k_id;
        this.k_no = k_no;
        this.k_ss = k_ss;
        this.k_team = k_team;
        this.k_name = k_name;
        this.k_num = k_num;
        this.k_pos = k_pos;
        this.k_birth = k_birth;
        this.K_PHY = k_PHY;
        this.k_hire = k_hire;
        this.k_war = k_war;
        this.k_sal = k_sal;
        this.k_date = k_date;
        this.k_state = k_state;
        this.k_year = k_year;
        this.gubun = gubun;
        this.keyword = keyword;
    }


}


