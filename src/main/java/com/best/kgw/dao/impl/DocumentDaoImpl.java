package com.best.kgw.dao.impl;

import com.best.kgw.dao.DocumentDao;
import com.vo.ApprovalVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DocumentDaoImpl implements DocumentDao {
    Logger logger= LoggerFactory.getLogger("DocumentDaoImpl".getClass());
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
//기안자 문서함 list
    @Override
    public List<ApprovalVO>DocumentList(ApprovalVO approvalVO){
        List<ApprovalVO >list;
        list=sqlSessionTemplate.selectList("selectDocument",approvalVO);
        return list;
    }


//결재자 결재함
    @Override
    public List<ApprovalVO >ApprovalList(ApprovalVO approvalVO){
        List<ApprovalVO>list2;
        list2=sqlSessionTemplate.selectList("approvalDocument",approvalVO);
        return list2;
    }





    //    기안하기필요한 정보
     @Override
      public List<ApprovalVO> DocumentInfo(ApprovalVO approvalvo){
         List<ApprovalVO> faTeam =sqlSessionTemplate.selectList("faTeam", approvalvo);
        return faTeam;
    }
    
//    영입 문서 작성
    @Override
    public void documentInsert(ApprovalVO approvalVO) throws Exception {
        logger.info("==================approvalVO"+ approvalVO);
        sqlSessionTemplate.insert("documentInsert", approvalVO);
    }
    @Override
    public void  approvalInsert(ApprovalVO approvalVO) throws  Exception{
        logger.info("==================ApprovalInsert");
       sqlSessionTemplate.insert("approvalInsert",approvalVO);
    }

    @Override
    public void approvalUpdate(ApprovalVO approvalvo) throws Exception {
        if(approvalvo.getApproval_category().equals("중간결재대기")){
            sqlSessionTemplate.update("approvalMiddleModify", approvalvo);
        }else{
            logger.info("dao"+approvalvo);
            sqlSessionTemplate.update("approvalFinalModify", approvalvo);
        }
    }

    // 임시저장 업데이트
    @Override
    public int saveModify(ApprovalVO approvalVO) throws Exception {
        logger.info("saveModify");
        int saveModify=0;
       saveModify=sqlSessionTemplate.update("saveModify",approvalVO);
        return saveModify;
    }

    //임시저장 삭제
    @Override
    public int saveDocumentDelete(int document_no) throws Exception {
        int documentDelete=0;
       documentDelete=sqlSessionTemplate.delete("documentDelete",document_no);
        return documentDelete;
    }

    @Override
    public void documentStateModify(ApprovalVO approvalvo) throws Exception {
        logger.info("documentStateModify======="+approvalvo.toString());
        sqlSessionTemplate.update("documentStateModify",approvalvo);
    }

    @Override
    public void vacation(ApprovalVO approvalvo) throws Exception {
        sqlSessionTemplate.insert("updateDayoff", approvalvo);
    }

    @Override
    public void updateFA(ApprovalVO approvalvo) throws Exception {
        logger.info("=+++++++++++++++++++++++++++++++++++++"+approvalvo.toString());
        sqlSessionTemplate.update("updateFA", approvalvo);
    }

    @Override
    public void updateDayoffCnt(ApprovalVO approvalvo) throws Exception {
        sqlSessionTemplate.update("updateDayoffCnt", approvalvo);
    }

    @Override
    public List<Map<String, Object>> stateCnt(int empNo) throws Exception {
        List<Map<String, Object>> stateCnt = sqlSessionTemplate.selectList("stateCnt", empNo);
        return stateCnt;
    }
}

