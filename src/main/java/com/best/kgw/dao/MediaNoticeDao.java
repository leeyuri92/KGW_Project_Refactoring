package com.best.kgw.dao;



import com.vo.MediaNoticeCommendVO;
import com.vo.MediaNoticeVO;

import java.util.List;

public interface MediaNoticeDao {
     public List<MediaNoticeVO> mediaNoticeList(MediaNoticeVO mediaNoticeVO) throws Exception;
     public int mediaNoticeDelete(int board_no)throws Exception;

     public int mediaNoticeInsert(MediaNoticeVO mediaNoticeVO) throws Exception;
     //     public List<KiwoomNoticeVO> mediaNoticeUpdate(KiwoomNoticeVO kiwoomNoticeVO) throws Exception;
     public int mediaNoticeModify(MediaNoticeVO mediaNoticeVO) throws Exception;
     public int mediaCommendInsert(MediaNoticeCommendVO mediaNoticeCommendVO)throws Exception;
     public List<MediaNoticeCommendVO>commendList(MediaNoticeCommendVO mediaNoticeCommendVO) throws Exception;
     public int mediaCommendDelete(int commend_no) throws Exception;

     public void mediaHitUpdate(MediaNoticeVO mediaNoticeVO) throws Exception;


}
