package com.best.kgw.controller;

import com.best.kgw.service.AdminSevice;
import com.vo.EmpVO;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Objects;


@Controller
public class ExelController {

    @Autowired
    private AdminSevice adminSevice;

    Logger logger = LoggerFactory.getLogger(ExelController.class);
    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.24
     기능 : 전체사원정보 다운
     **********************************************************************************/

    @GetMapping("/allDownLoadExel")
    public void downloadExel(HttpServletResponse response) throws IOException, SQLException {

        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.ap-chuncheon-1.oraclecloud.com))(connect_data=(service_name=ga45479ea3c71df_l4hrfixp1sgbh0pd_medium.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)))","ADMIN","Abcd12345678");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select e.emp_no,t.team_name,t.team_no, e.emp_access, e.emp_position, e.dayoff_cnt, e.emp_year,e.hire_date, e.emp_state, e.reg_date, e.mod_date, e.password, e.name, e.email,e.phone_num,e.address,e.birthdate\n" +
                "        from emp e JOIN team t ON e.team_no = t.team_no");

        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("Emp Data");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("이름");
        headerRow.createCell(1).setCellValue("사번");
        headerRow.createCell(2).setCellValue("입사일");
        headerRow.createCell(3).setCellValue("부서");
        headerRow.createCell(4).setCellValue("직급");
        headerRow.createCell(5).setCellValue("상태");
        headerRow.createCell(6).setCellValue("휴대전화");
        headerRow.createCell(7).setCellValue("생일");
        headerRow.createCell(8).setCellValue("이메일");
        headerRow.createCell(9).setCellValue("주소");

        int r = 1;
        while (rs.next()) {
            String name = rs.getString("NAME");
            int empno = rs.getInt("EMP_NO");
            String hiredate = rs.getString("HIRE_DATE");
            String teamname = rs.getString("TEAM_NAME");
            String position = rs.getString("EMP_POSITION");
            String state = rs.getString("EMP_STATE");
            String phonenum = rs.getString("PHONE_NUM");
            String birthdate = rs.getString("BIRTHDATE");
            String email = rs.getString("EMAIL");
            String address = rs.getString("ADDRESS");
            if(Objects.equals(state, "0")){
                state = "퇴직";
            }else {
                state = "재직";
            }
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(name);
            row.createCell(1).setCellValue(empno);
            row.createCell(2).setCellValue(hiredate);
            row.createCell(3).setCellValue(teamname);
            row.createCell(4).setCellValue(position);
            row.createCell(5).setCellValue(state);
            row.createCell(6).setCellValue(phonenum);
            row.createCell(7).setCellValue(birthdate);
            row.createCell(8).setCellValue(email);
            row.createCell(9).setCellValue(address);
        }
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=empList.xls");

        workbook.write(response.getOutputStream());
        workbook.close();
        con.close();
    }

    /**********************************************************************************
     작성자 : 이동건
     작성일자 : 24.02.24
     기능 : 선택사원정보 다운
     **********************************************************************************/
    @GetMapping("/selectDownLoadExel")
    public void downloadExel(HttpServletResponse response, EmpVO empVO) throws Exception {

        // 엑셀에 들어갈 데이터 생성
        logger.info("Controller : empList 호출");
        List<EmpVO> empList = adminSevice.empList(empVO);
        logger.info(empList.toString());
        EmpVO rmap = empList.get(0);

        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("Emp Data");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("이름");
        headerRow.createCell(1).setCellValue("사번");
        headerRow.createCell(2).setCellValue("입사일");
        headerRow.createCell(3).setCellValue("부서");
        headerRow.createCell(4).setCellValue("직급");
        headerRow.createCell(5).setCellValue("상태");
        headerRow.createCell(6).setCellValue("휴대전화");
        headerRow.createCell(7).setCellValue("생일");
        headerRow.createCell(8).setCellValue("이메일");
        headerRow.createCell(9).setCellValue("주소");


        String name =  rmap.getName();
        int empno = empVO.getEmp_no();
        String hiredate = rmap.getHire_date();
        String teamname =rmap.getName();
        String position = rmap.getEmp_position();
        String state = rmap.getEmp_state();
        if (Objects.equals(state, "0")) {
            state = "퇴직";
        } else {
            state = "재직";
        }
        String phonenum = (String) rmap.getPhone_num();
        String birthdate = (String) rmap.getBirthdate();
        String email = (String) rmap.getEmail();
        String address = (String) rmap.getAddress();

        Row row = sheet.createRow(1);
        row.createCell(0).setCellValue(name);
        row.createCell(1).setCellValue(empno);
        row.createCell(2).setCellValue(hiredate);
        row.createCell(3).setCellValue(teamname);
        row.createCell(4).setCellValue(position);
        row.createCell(5).setCellValue(state);
        row.createCell(6).setCellValue(phonenum);
        row.createCell(7).setCellValue(birthdate);
        row.createCell(8).setCellValue(email);
        row.createCell(9).setCellValue(address);

        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=empList.xls");

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}
