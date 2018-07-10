package com.javateam.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.Date;
import java.util.List;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.javateam.model.vo.BoardVO;
import com.javateam.model.vo.Users;
import com.javateam.service.AuthJdbcService;
import com.javateam.service.BoardService;

@Controller
public class HomeController {
	
	@Autowired
	private AuthJdbcService authJdbcService;
	
	@Autowired
	private BoardService boardSvc; 
	

	@RequestMapping("/")
	public String home(Model model)  {
		
		List<BoardVO> boardlist = boardSvc.getArticleList(1, 10);
		
		model.addAttribute("boardlist", boardlist);
		
		return "home";
	}
	
	@RequestMapping("/chart.do")
    public ModelAndView chart() {
        String path = "C://Users//ss//git//Project//shoping_project//src//main//webapp//WEB-INF//views";
        ModelAndView view = new ModelAndView();
        view.setViewName("test");
        
        
        RConnection connection = null;
        try {
            connection = new RConnection();
            connection.eval("library(devtools)");
            connection.eval("library(RCurl)");
            connection.eval("library(d3Network)");
            connection.eval(
                    "name <- c('한글','진주','정이','민아','성훈','오미야 나미','Julia 오미야','Sharon 오미야','Meryl 오미야', 'Susan 오미야','Nicole 오미야')");
            connection.eval(
                    "pemp <- c('한글','한글','정이 Lange','정이 Ryder','정이 Ryder','정이 Bassett','정이 Thompson', '정이 Roberts','정이 Bassett', '정이 Streep','정이 Sarandon')");
            connection.eval("emp <- data.frame(이름=name,상사이름=pemp)");
            connection.eval("d3SimpleNetwork(emp,width=600,height=600,file='C://Users/ss/Desktop/Study/Study_Note/test01.jsp')");
            connection.eval("aa <- '한글'");
            System.out.println(connection.eval("aa").asString());
            connection.close();
            /*
             * 기존 소스는 생성된 .jsp 에서 한글이 깨짐.
             */
            // FileInputStream fis = new
            // FileInputStream("/Users/jinsoo_mac/Desktop/Study/Study_Note/test01.jsp");
            // FileOutputStream fos = new FileOutputStream(path+"/test01.jsp");
            //
            // FileCopyUtils.copy(fis, fos);
            /*
             * 생성한 .jsp 가 한글이 깨져 한글을 처리함.
             */
            
            File file = new File(path + "/test01.jsp");
            
            if( file.exists() ){
                if(file.delete()){
                    System.out.println("파일삭제 성공");
                }else{
                    System.out.println("파일삭제 실패");
                }
            }else{
                System.out.println("파일이 존재하지 않습니다.");
            }

            BufferedReader reader = new BufferedReader(
                    new FileReader("/Users/ss/Desktop/Study/Study_Note/test01.jsp"));
            BufferedWriter writer = new BufferedWriter(
                    new OutputStreamWriter(new FileOutputStream(path + "/test01.jsp"), "UTF-8"));
            String s;
            String str = "<%@ page contentType=\"text/html;charset=UTF-8\"%>";
            writer.write(str);
            while ((s = reader.readLine()) != null) {
                writer.write(s);
                writer.newLine();
            }
            FileCopyUtils.copy(reader, writer);
            view.addObject("viewPage", "test01.jsp");
        } catch (Exception e) {
        	System.out.println("!! 에러 !!");
            System.out.println(e);
        }
        return view;
	}
	
	@RequestMapping("/test.do")
    public ModelAndView testd() {
		
        String path = "C:\\Users\\ss\\git\\Project\\shoping_project\\src\\main\\webapp\\resources\\used-image";
        ModelAndView view = new ModelAndView();
        view.setViewName("test");
        
        RConnection connection = null;
        
        try {
        	
            File file = new File(path + "/test.png");
            if( file.exists() ){
                if(file.delete()){
                    System.out.println("파일삭제 성공");
                }else{
                    System.out.println("파일삭제 실패");
                }
            }else{
                System.out.println("파일이 존재하지 않습니다.");
            }
            
            System.out.println("1");
            connection = new RConnection();
            System.out.println("2");
            connection.eval("library(ggplot2)");
            System.out.println("3");
            connection.eval("require(ggplot2)");
            System.out.println("4");
            connection.eval("name <- c('제닉스','제닉스2','g950','g340')");
            System.out.println("5");
            connection.eval("count <- c(100,33,21,87)");
            System.out.println("6");
            connection.eval("pp <- data.frame(이름=name,판매량=count)");
            connection.eval("pp$pos <- pp$판매량>=mean(pp$판매량)");
            System.out.println("7");
            connection.eval("png(filename='C://Users/ss/git/Project/shoping_project/src/main/webapp/resources/used-image/test.png',width=800,height=600)");
            System.out.println("8");
            connection.parseAndEval("print(ggplot(pp, aes(x = 이름, y = 판매량, fill = pos)) + geom_col(size = .25) + scale_fill_manual(values = c('#F7756B', '#00BEFF')) +labs(shape='평균 이상'))");
            System.out.println("9");
            connection.parseAndEval("print(dev.off());");
            connection.close();
            System.out.println("10");
            
            /*
             * 기존 소스는 생성된 .jsp 에서 한글이 깨짐.
             */
            // FileInputStream fis = new
            // FileInputStream("/Users/jinsoo_mac/Desktop/Study/Study_Note/test01.jsp");
            // FileOutputStream fos = new FileOutputStream(path+"/test01.jsp");
            //
            // FileCopyUtils.copy(fis, fos);
            /*
             * 생성한 .jsp 가 한글이 깨져 한글을 처리함.
             */


/*            BufferedReader reader = new BufferedReader(
                    new FileReader("C://Users/ss/git/Project/shoping_project/src/main/webapp/resources/image/test.png"));
            BufferedWriter writer = new BufferedWriter(
                    new OutputStreamWriter(new FileOutputStream(path + "/test.png")));
            String s;
            String str = "<%@ page contentType=\"text/html;charset=UTF-8\"%>";
            writer.write(str);
            while ((s = reader.readLine()) != null) {
                writer.write(s);
                writer.newLine();
            }
            FileCopyUtils.copy(reader, writer);*/
            view.addObject("viewPage", "test.png");
            
        } catch (Exception e) {
        	System.out.println("!! 에러 !!");
            System.out.println(e);
        }
        return view;
	}
	
	@RequestMapping("/test01")
	public void test01() {
		
	}
	
	@RequestMapping("/user/myPage")
	public void myPage() {
		
	}
	

	@RequestMapping("/test")
	public void test() {
	}
	
	@RequestMapping("/welcome")
	public void welcome() {
	}
	
	@RequestMapping("/join")
	public void join() {
	}
	
	@RequestMapping("/joinAction")
	public void join(@RequestParam("username") String username,
					 @RequestParam("pw") String password,
					 @RequestParam("name") String name,
					 @RequestParam("gender") String sex,
					 @RequestParam("phone") String phone,
					 @RequestParam("phone2") String phone2,
					 @RequestParam("phone3") String phone3,
					 @RequestParam("postcode") String postcode,
					 @RequestParam("address") String address,
					 @RequestParam("address2") String address2,
					 @RequestParam("email") String email,
					 @RequestParam("email2") String email2,
					 @RequestParam("email3") String email3,
					 @RequestParam("flag") String flag) {
		
		System.out.println("join !");
		
		String hashedPassword = ""; 
		BCryptPasswordEncoder passwordEncoder 
			= new BCryptPasswordEncoder();
		hashedPassword = passwordEncoder.encode(password);

		System.out.println(hashedPassword);
		
		// 이메일 설정
		if(flag.equals("0")) {
			email = email + email2;
		} else {
			email = email + email3;
		}
		address = postcode+ ", " + address+ ", " + address2;
		phone = phone+"-"+phone2+"-"+phone3;
		Users users = new Users(username,
								hashedPassword,
								1,
								name,
								sex,
								phone,
								address,
								email,
								new Date(System.currentTimeMillis()));
		authJdbcService.insertUsers(users, "ROLE_USER");
	} // 
	
	

	@RequestMapping("/mouse")
	public String mouse() {
		
		return "/board/mouseBoard";
	}
	
	@RequestMapping("/keyboard")
	public String keyboard() {
		
		return "/board/keyBoard";
	}
	
	@RequestMapping("/head")
	public String head() {
		
		return "/board/headBoard";
	}
	
	@RequestMapping("/monitor")
	public String monitor() {
		
		return "/board/monitorBoard";
	}
	
}
