package com.best.kgw.dao;

import com.vo.NoticeBoardVO;

import java.util.List;

public interface NoticeBoardDao {
    public List<NoticeBoardVO> noticeList(NoticeBoardVO noticeBoardVO) throws Exception;
    public int noticeInsert(NoticeBoardVO noticeboardVO) throws Exception;
    public int noticeDelete(int notice_no) throws Exception;
    public int noticeModify(NoticeBoardVO noticeBoardVO) throws Exception;
    public void hitUpdate(NoticeBoardVO noticeBoardVO);

    List<NoticeBoardVO> noticePinList(NoticeBoardVO noticeboardVO) throws Exception;
}
