package com.best.kgw.service.impl;

import com.best.kgw.controller.MediaNoticeController;
import com.best.kgw.dao.NoticeBoardDao;
import com.best.kgw.service.NoticeBoardService;
import com.vo.NoticeBoardVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
    Logger logger = LoggerFactory.getLogger(MediaNoticeController.class);
    @Autowired
    private NoticeBoardDao noticeBoardDao;
    @Override
    public List<NoticeBoardVO> noticeList(NoticeBoardVO noticeBoardVO) throws Exception {
        logger.info("NoticeList");
        List<NoticeBoardVO> noticeList=noticeBoardDao.noticeList(noticeBoardVO);
        return noticeList;

    }

    @Override
    public int noticeInsert(NoticeBoardVO noticeboardVO) throws Exception{
        logger.info("noticeInset");
        int noticeInsert = 0;
        noticeInsert = noticeBoardDao.noticeInsert(noticeboardVO);
        logger.info("noticeInset:"+noticeInsert);
        return noticeInsert;

    }

    @Override
    public int noticeDelete(int notice_no) throws Exception {
        logger.info("noticeDelete");
        int noticeDelete =0;
        noticeDelete = noticeBoardDao.noticeDelete(notice_no);
        logger.info("noticeDelete:"+noticeDelete);
        return noticeDelete;
    }

    @Override
    public int noticeModify(NoticeBoardVO noticeBoardVO) throws Exception {
        int noticeModify =0;
        noticeModify=noticeBoardDao.noticeModify(noticeBoardVO);
        return noticeModify;
    }
    @Transactional
    @Override
    public List<NoticeBoardVO> noticeDetail(NoticeBoardVO noticeBoardVO) throws Exception {
        noticeBoardDao.hitUpdate(noticeBoardVO);
        List<NoticeBoardVO> noticeList=noticeBoardDao.noticeList(noticeBoardVO);
        return noticeList;
    }

    @Override
    public List<NoticeBoardVO> noticePinList(NoticeBoardVO noticeboardVO) throws Exception {
        List<NoticeBoardVO> noticePinList=noticeBoardDao.noticePinList(noticeboardVO);
        return noticePinList;
    }
}
