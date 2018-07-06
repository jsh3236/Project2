package com.javateam.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@Autowired
	private FileSystemResource uploadDirResource;

	@RequestMapping("/")
	public String home(Model model) {
		
		List<BoardVO> boardlist = boardSvc.getArticleList(1, 10);
		
		model.addAttribute("boardlist", boardlist);
		
		return "home";
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
