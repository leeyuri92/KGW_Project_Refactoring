package com.best.kgw.controller;

import com.best.kgw.service.AdminSevice;
import com.vo.EmpVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class CertificateController {

    Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private AdminSevice adminSevice;

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 재직증명서 조회
     **********************************************************************************/
    @GetMapping("empCertificate")
    public String empCertificate(Model model, EmpVO empVO) throws Exception {
        logger.info("empCertificate");
        List<EmpVO> empList = null;
        empList = adminSevice.empList(empVO);
        model.addAttribute("empList", empList);
        return "forward:/admin/empCertificate.jsp"; //
    }
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.19
     기능 : 퇴직증명서 조회
     **********************************************************************************/
    @GetMapping("retireCertificate")
    public String retireCertificate(Model model, EmpVO empVO) throws Exception {
        logger.info("retireCertificate");
        List<EmpVO> empList = null;
        empList = adminSevice.empList(empVO);
        model.addAttribute("empList", empList);
        return "forward:/admin/retireCertificate.jsp"; //
    }
}
