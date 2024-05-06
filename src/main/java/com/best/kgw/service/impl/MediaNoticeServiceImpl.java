package com.best.kgw.service.impl;

import com.best.kgw.dao.MediaNoticeDao;
import com.best.kgw.service.MediaNoticeService;
import com.vo.MediaNoticeCommendVO;
import com.vo.MediaNoticeVO;
import com.vo.NoticeBoardVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MediaNoticeServiceImpl implements MediaNoticeService {
    Logger logger = LoggerFactory.getLogger(MediaNoticeServiceImpl.class);
    @Autowired
    private MediaNoticeDao mediaNoticeDao;
    @Override
    public List<MediaNoticeVO> mediaNoticeList(MediaNoticeVO mediaNoticeVO) throws Exception {
        logger.info("mediaNoticeList");
        List<MediaNoticeVO> mediaNoticeList=mediaNoticeDao.mediaNoticeList(mediaNoticeVO);
        return mediaNoticeList;
    }

    @Override
    public int mediaNoticeDelete(int board_no) throws Exception {
        logger.info("mediaNoticeDelete");
        int mediaNoticeDelete=0;
        mediaNoticeDelete=mediaNoticeDao.mediaNoticeDelete(board_no);
        return mediaNoticeDelete;
    }

    @Override
    public int mediaNoticeInsert(MediaNoticeVO mediaNoticeVO) throws Exception {
        logger.info("mediaNoticeInsert");
        int mediaNoticeInsert=0;
        mediaNoticeInsert=mediaNoticeDao.mediaNoticeInsert(mediaNoticeVO);
        return mediaNoticeInsert;
    }

    @Override
    public int mediaNoticeModify(MediaNoticeVO mediaNoticeVO) throws Exception {
        logger.info("mediaNoticeModify");
        int mediaNoticeModify=0;
        mediaNoticeModify=mediaNoticeDao.mediaNoticeModify(mediaNoticeVO);
        return mediaNoticeModify;
    }

    @Override
    public int mediaCommendInsert(MediaNoticeCommendVO mediaNoticeCommendVO) throws Exception {
        logger.info("mediaCommendInsert");
        logger.info(mediaNoticeCommendVO.toString());
        int mediaCommendInsert =0;
        mediaCommendInsert = mediaNoticeDao.mediaCommendInsert(mediaNoticeCommendVO);
        return mediaCommendInsert;
    }
    @Override
    public List<MediaNoticeCommendVO> commendList(MediaNoticeCommendVO mediaNoticeCommendVO) throws Exception {
        logger.info("commendList");
        List<MediaNoticeCommendVO> commendList = mediaNoticeDao.commendList(mediaNoticeCommendVO);
        return commendList;
    }

    @Override
    public int mediaCommendDelete(int commend_no) throws Exception {
        logger.info("mediaCommendDelete");
        int mediaCommendDelete=0;
        mediaCommendDelete=mediaNoticeDao.mediaCommendDelete(commend_no);
        return mediaCommendDelete;
    }

    @Transactional
    @Override
    public List<MediaNoticeVO> mediaNoticeDetail(MediaNoticeVO mediaNoticeVO) throws Exception {
        mediaNoticeDao.mediaHitUpdate(mediaNoticeVO);
        List<MediaNoticeVO> mediaNoticeDetail =mediaNoticeDao.mediaNoticeList(mediaNoticeVO);
        return mediaNoticeDetail;
    }
//    @Override
//    public List<Map<String, Object>> KiwoomNoticeDetail(KiwoomNoticeCommendVO kiwoomNoticeCommendVO) throws Exception {
////        List<Map<String,Object>> KiwoomNoticeList=KiwoomNoticeDao.kiwoomNoticeDetail(KiwoomNoticeVO);
////        List<Map<String,Oj>>
//        return null;
//    }

//    @Override
//    public List<Map<String,Object>> KiwoomNoticeDetail(KiwoomNoticeCommendVO kiwoomNoticeCommendVO) throws Exception {
//        logger.info("KiwoomNoticeDetail");
//       List<Map<String,Object>> kiwoomNoticeList =kiwoomNoticeDao.kiwoomNoticeList(new KiwoomNoticeVO());
//        List<Map<String,Object>> kiwoomCommendList=kiwoomNoticeDao.kiwoomCommendList(kiwoomNoticeCommendVO);
//        return null;
//    }


}











//    @Override
//    public List<KiwoomNoticeVO> kiwoomNoticeUpdate(KiwoomNoticeVO kiwoomNoticeVO) throws Exception {
//        return null;
//    }

