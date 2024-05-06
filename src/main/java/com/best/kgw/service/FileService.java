package com.best.kgw.service;

import com.vo.EmpVO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Service
public class FileService {
    Logger logger = LoggerFactory.getLogger(FileService.class);

    public void fileUpload(String fileFolder, MultipartFile file, HttpServletRequest req) throws Exception{
        String realFolder = "";
        String saveFolder = "/fileUpload/"+ fileFolder + "/";

        //현재 파일경로
        ServletContext context = req.getServletContext();
        realFolder = context.getRealPath(saveFolder);
        logger.info("context : "+ realFolder);

        // 파일 저장 경로에 폴더가 없으면 생성
        File folder = new File(realFolder);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        // 파일 이름 설정
        String originalFilename = file.getOriginalFilename();
        String filePath = realFolder + originalFilename;
        logger.info(filePath);
        // 업로드된 파일 저장
        if (!originalFilename.isEmpty()) {
            try {
                file.transferTo(new File(filePath));
            } catch (IOException e) {
                logger.error("파일 업로드 중 오류 발생: " + e.getMessage());
                throw e;
            }
        }
    }

    public void fileUpload(String fileFolder, MultipartFile file, HttpServletRequest req, EmpVO empvo) throws Exception{
        logger.info("file update ========================== "+file.getBytes());

        String realFolder = "";
        String saveFolder = "/fileUpload/"+ fileFolder + "/";

        //현재 파일경로
        ServletContext context = req.getServletContext();
        realFolder = context.getRealPath(saveFolder);
        logger.info("context : "+ realFolder);

        // 파일 저장 경로에 폴더가 없으면 생성
        File folder = new File(realFolder);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        // 파일 이름 설정
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
        String fileName = empvo.getEmp_no() + ".png" ;
        String filePath = realFolder + fileName;

        // 업로드된 파일 저장
        if (!originalFilename.isEmpty()) {
            try {
                file.transferTo(new File(filePath));
            } catch (IOException e) {
                logger.error("파일 업로드 중 오류 발생: " + e.getMessage());
                throw e;
            }
        }
    }
}
