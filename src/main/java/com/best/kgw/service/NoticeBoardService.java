package com.best.kgw.service;



import com.vo.NoticeBoardVO;

import java.util.List;

public interface NoticeBoardService {
    public List<NoticeBoardVO> noticeList(NoticeBoardVO noticeBoardVO) throws Exception;
    public int noticeInsert(NoticeBoardVO noticeboardVO) throws Exception;
    public int noticeDelete(int notice_no)throws Exception;
    public int noticeModify(NoticeBoardVO noticeBoardVO)throws Exception;

    public List<NoticeBoardVO> noticeDetail(NoticeBoardVO noticeboardVO) throws Exception;

    List<NoticeBoardVO> noticePinList(NoticeBoardVO noticeboardVO) throws Exception;
}
