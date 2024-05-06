package com.best.kgw.dao.impl;
import com.best.kgw.dao.MediaNoticeDao;
import com.vo.MediaNoticeCommendVO;
import com.vo.MediaNoticeVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MediaNoticeDaoImpl implements MediaNoticeDao {
    Logger logger = LoggerFactory.getLogger(MediaNoticeDaoImpl.class);

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<MediaNoticeVO> mediaNoticeList(MediaNoticeVO mediaNoticeVO) throws Exception {
        logger.info("mediaNoticeList");
        List<MediaNoticeVO> mediaNoticeList = sqlSessionTemplate.selectList("mediaNoticeList", mediaNoticeVO);
//        logger.info(kiwoomNoticeList.toString());
        return mediaNoticeList;

    }

    @Override
    public int mediaNoticeDelete(int board_no) throws Exception {
        logger.info("mediaNoticeDelete");
        int mediaNoticeDelete=0;
        mediaNoticeDelete = sqlSessionTemplate.delete("mediaNoticeDelete",board_no);
        logger.info("mediaNoticeDelete : " + mediaNoticeDelete);
        return mediaNoticeDelete;
    }

    @Override
    public int mediaNoticeInsert(MediaNoticeVO mediaNoticeVO) throws Exception {
        logger.info("mediaNoticeInsert");
        int mediaNoticeInsert=0;
        mediaNoticeInsert = sqlSessionTemplate.insert("mediaNoticeInsert",mediaNoticeVO);
        logger.info("mediaNoticeInsert" + mediaNoticeInsert);
        return mediaNoticeInsert;
    }

    @Override
    public int mediaNoticeModify(MediaNoticeVO mediaNoticeVO) throws Exception {
        logger.info("mediaNoticeModify");
        int mediaNoticeModify=0;
        mediaNoticeModify = sqlSessionTemplate.update("mediaNoticeModify",mediaNoticeVO);
        logger.info("mediaNoticeModify" + mediaNoticeModify);
        return mediaNoticeModify;
    }

    @Override
    public int mediaCommendInsert(MediaNoticeCommendVO mediaNoticeCommendVO) throws Exception {
        logger.info("mediaCommendInsert");
        int mediaCommendInsert = sqlSessionTemplate.insert("mediaCommendInsert",mediaNoticeCommendVO);
        logger.info("mediaCommendInsert:"+mediaCommendInsert);
        return mediaCommendInsert;
    }

    @Override
    public List<MediaNoticeCommendVO> commendList(MediaNoticeCommendVO mediaNoticeCommendVO) throws Exception {
        logger.info("commend");
        List<MediaNoticeCommendVO> commendList =sqlSessionTemplate.selectList("commendList",mediaNoticeCommendVO);
        return commendList;
    }

    @Override
    public int mediaCommendDelete(int commend_no) throws Exception {
        logger.info("mediaCommendDelete");
        int mediaCommendDelete =0;
        mediaCommendDelete=sqlSessionTemplate.delete("mediaCommendDelete",commend_no);
        return mediaCommendDelete;
    }

    @Override
    public void mediaHitUpdate(MediaNoticeVO mediaNoticeVO) throws Exception {
        sqlSessionTemplate.update("mediaHitUpdate",mediaNoticeVO);
    }


}

