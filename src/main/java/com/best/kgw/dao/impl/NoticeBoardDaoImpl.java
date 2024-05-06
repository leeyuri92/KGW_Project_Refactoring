package com.best.kgw.dao.impl;

import com.best.kgw.dao.NoticeBoardDao;
import com.vo.NoticeBoardVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class NoticeBoardDaoImpl implements NoticeBoardDao {
    Logger logger = LoggerFactory.getLogger(NoticeBoardDao.class);
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    public List<NoticeBoardVO> noticeList(NoticeBoardVO noticeBoardVO) throws Exception {
        logger.info("NoticeList");
        List<NoticeBoardVO> noticeList =sqlSessionTemplate.selectList("noticeList",noticeBoardVO);
        return noticeList;
    }

    @Override
    public int noticeInsert(NoticeBoardVO noticeboardVO) throws Exception {
       logger.info("noticeInsert");
       int noticeInsrt=0;
       noticeInsrt=sqlSessionTemplate.insert("noticeInsert",noticeboardVO);
       logger.info("noticeInsert");
       return noticeInsrt;
    }

    @Override
    public int noticeDelete(int notice_no) throws Exception {
        logger.info("noticeDelete");
        int noticeDelete=0;
        noticeDelete=sqlSessionTemplate.delete("noticeDelete",notice_no);
        logger.info("noticeDelete");
        return noticeDelete;
    }

    @Override
    public int noticeModify(NoticeBoardVO noticeBoardVO) throws Exception {
        logger.info("noticeModify");
        int noticeModify=0;
        noticeModify=sqlSessionTemplate.update("noticeModify",noticeBoardVO);
        return noticeModify;
    }

    @Override
    public void hitUpdate(NoticeBoardVO noticeBoardVO) {
        sqlSessionTemplate.update("hitUpdate",noticeBoardVO);
    }

    @Override
    public List<NoticeBoardVO> noticePinList(NoticeBoardVO noticeboardVO) throws Exception {
        List<NoticeBoardVO> noticePinList =sqlSessionTemplate.selectList("noticePinList",noticeboardVO);
        return noticePinList;
    }
}
