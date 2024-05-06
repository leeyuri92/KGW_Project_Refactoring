package com.best.kgw.controller;

import com.best.kgw.service.AdminSevice;
import com.best.kgw.service.FileService;
import com.vo.EmpVO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
    Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private AdminSevice adminSevice;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private FileService fileService;


    @GetMapping("/registPage")
    public String registPage() {
        logger.info("registPage() 호출");
        return "forward:/admin/regist.jsp";
    }
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19 ,24,02.26
     기능 : 사원추가,비밀번호 암호화적용
     **********************************************************************************/
    @PostMapping("regist")
    public String regist(EmpVO empVO) throws Exception{
        logger.info(empVO.toString());

        int result = 0;
        String path = "";
        String rawPassword = empVO.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        empVO.setPassword(encPassword);//password변수 치환

        result = adminSevice.regist(empVO);
        if(result == 1){
            path = "redirect:/admin/empList";
        }else{
            path = "redirect:/registerror.jsp";
        }
        return path;
    }
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원목록조회
     **********************************************************************************/
    @GetMapping("empList")
    public String empList(EmpVO empVO, Model model) throws Exception{
        logger.info("Controller : empList 호출");
        List<EmpVO> empList = adminSevice.empList(empVO);
        model.addAttribute("empList", empList);
        logger.info(empList.toString());
        return "forward:/admin/adminSearch.jsp";
    }
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 사원상세정보조회
     **********************************************************************************/
    @GetMapping("empDetail")
    public String empDetail(Model model,EmpVO empVO) throws Exception {
        logger.info("empDetail");
        List<EmpVO> empList = null;// [ {},{},{} ]
        empList = adminSevice.empList(empVO);
        model.addAttribute("empList", empList);
        return "forward:/admin/empDetail.jsp"; // webapp아래에서찾음
    }


    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19 ,24,02.26 , 24.03.03
     기능 : 사원수정,비밀번호암호화적용,이미지업로드사인업로드추가
     **********************************************************************************/
    @PostMapping("empInfoUpdate")
    public String empInfoUpdate(EmpVO empVO,@RequestParam("profiles") MultipartFile file,HttpServletRequest req) throws Exception{
        logger.info("empDetailUpdate");
        if (file != null && !file.isEmpty()) {
            // 파일이 제대로 전달되었을 때의 처리
            logger.info("File is not null and not empty.");
            fileService.fileUpload("profile", file, req, empVO);
            String originalFilename = file.getOriginalFilename(); // 업로드된 파일의 원본 파일 이름
            String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1); // 확장자 추출
            empVO.setProfile_img(empVO.getEmp_no()+"."+extension);
            String rawPassword = empVO.getPassword();
            String encPassword = bCryptPasswordEncoder.encode(rawPassword);
            empVO.setPassword(encPassword);
            int result = 0;
            result = adminSevice.empInfoUpdate(empVO);
        } else {
            // 파일이 전달되지 않았을 때의 처리
            logger.info("File is null or empty.");
            String rawPassword = empVO.getPassword();
            String encPassword = bCryptPasswordEncoder.encode(rawPassword);
            empVO.setPassword(encPassword);
            int result = 0;
            result = adminSevice.empInfoUpdate(empVO);
        }

        return "redirect:/admin/empList";
}
}
