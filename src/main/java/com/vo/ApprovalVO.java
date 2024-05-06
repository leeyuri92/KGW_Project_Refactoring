package com.vo;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ApprovalVO {
        private Integer document_no;
        private int emp_no;
        private String document_title;
        private String document_category;
        private String submission_date;
        private String state;
        private String draftday;
        private String start_date;
        private String end_date;
        private String dayoff_content;
        private String salary;
        private  int k_no;
        private String contract_term;
        private String team_name;
//        문서 끝
        private int approval_no; // 결재 번호
        private String approval_name; // 결재자
        private String approval_category; // 결재 상태
        private String rejection_content; // 반려 사유
        private String middle_approval_date; // 중간 결재 일시
        private String final_approval_date; // 최종 결재 일시
        private String middlesign_name; // 중간 결재 사인 이미지
        private String finalsign_name; // 최종 결재 사인 이미지
//      결재 끝
        private  String name; //직원이름
        private  int dayoff_cnt;// 잔여 연차
        private  String emp_position;// 직급
        private  int team_no;
        private  String  k_team; // 우리구단
        private  String  k_name; // 우리구단 선수명
        private  int fa_no; // fa no
        private  String  fa_name; //fa 이름
        private  String  fa_team;// fa team
        private  String  fa_state;// true 시  키움 false 시 자유
        private  String  fa_agent;

        private String storage;//  value true 시 임시저장
        private String gubun;  //검색위한사용 컬럼
        private String action; //결재 바트 업데이트 처리 컬럼

        private String keyword;
        
//        select 받아논 데이터 끝
    @Builder
    public  ApprovalVO(Integer document_no,int emp_no,String document_title,String  document_category, String  submission_date,String state,
                       String start_date,String  end_date,String  draftday,String  dayoff_content,int  k_no, String salary ,String contract_term, String team_name,
                       int approval_no,String approval_name,String  approval_category, String  rejection_content, String  middle_approval_date,
                       String  final_approval_date , String middlesign_name, String finalsign_name, String name,int dayoff_cnt,String emp_position,
                       int team_no, String k_name, String k_team, int fa_no,String fa_name,String fa_team ,String fa_state ,String fa_agent  ,String keyword ,String storage,String gubun){
        super();
        this.document_no=document_no;
        this.emp_no=emp_no;
        this.document_title = document_title;
        this.document_category = document_category;
        this.submission_date = submission_date;
        this.state = state;
        this.start_date = start_date;
        this.end_date = end_date;
        this.draftday = draftday;
        this.dayoff_content = dayoff_content;
        this.k_no = k_no;
        this.salary = salary;
        this.contract_term = contract_term;
        this.team_name = team_name;
        this.approval_no = approval_no;
        this.approval_name = approval_name;
        this.approval_category = approval_category;
        this.rejection_content = rejection_content;
        this.middle_approval_date = middle_approval_date;
        this.final_approval_date = final_approval_date;
        this.middlesign_name = middlesign_name;
        this.finalsign_name = finalsign_name;
        this.name = name;
        this.dayoff_cnt = dayoff_cnt;
        this.emp_position = emp_position;
        this.team_no=team_no;
        this.k_name = k_name;
        this.k_team = k_team;
        this.fa_no = fa_no;
        this.fa_name = fa_name;
        this.fa_team=fa_team;
        this.fa_state=fa_state;
        this.fa_agent=fa_agent;
        this.keyword=keyword;
        this.storage=storage;
        this.gubun=gubun;
    }
}
