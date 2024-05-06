package com.vo;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DocumentVO {

        private Integer document_no;
        private Integer emp_no;
        private String document_Title;
        private String document_Category;
        private String submission_Date;
        private String state;
        private String draftDay;
        private String start_Date;
        private String end_Date;
        private String dayoff_Content;
        private Integer k_id;
        private Integer SALARY;
        private String contract_Term;



        @Builder
    public DocumentVO(Integer document_no, Integer emp_no, String document_Title, String document_Category,
                      String submission_Date, String state, String draftDay, String start_Date, String end_Date,
                      String dayoff_Content, Integer k_id, Integer SALARY, String contract_Term){
            super();
            this.document_no=document_no;
            this.emp_no=emp_no;
            this.document_Title=document_Title;
            this.document_Category=document_Category;
            this.submission_Date=submission_Date;
            this.state=state;
            this.draftDay=draftDay;
            this.start_Date=start_Date;
            this.end_Date=end_Date;
            this.dayoff_Content=dayoff_Content;
            this.k_id=k_id;
            this.SALARY=SALARY;
            this.contract_Term=contract_Term;

        }
    }

