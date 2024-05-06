package com.best.kgw.service;

import com.vo.ApprovalVO;

import java.util.List;
import java.util.Map;

public interface DocumentService {
    List<ApprovalVO> DocumentList(ApprovalVO approvalVO);


    //결재자 문서함
    List<ApprovalVO > ApprovalList(ApprovalVO approvalVO);

    //기안하기 문서 정보
    List<ApprovalVO> DocumentInfo(ApprovalVO approvalvo);

    public void documentInsert(ApprovalVO approvalVO) throws Exception;



    void approvalUpdate(ApprovalVO approvalvo) throws Exception;

    //    임시저장 업데이트 처리
    int saveModify(ApprovalVO approvalVO) throws Exception;

    int saveDelete(int document_no) throws Exception;

    List<Map<String, Object>> stateCnt(int empNo)throws Exception;
}
