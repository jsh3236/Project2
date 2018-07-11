package com.javateam.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javateam.model.vo.CustomUser;
import com.javateam.service.AuthJdbcService;
 
 
@Controller
public class LoginController {
	
	@Autowired
	AuthJdbcService authJdbcService;
	
	@RequestMapping("/idCheck")
	public String idCheck(@RequestParam("username") String username,
						   Model model) {
		
		System.out.println("id : "+username);
		
		boolean flag = authJdbcService.hasUsername(username);
		System.out.println(flag);
		model.addAttribute("flag", flag);
		
		return "idCheck";
	}
	
	@RequestMapping("/idCheck2")
	@ResponseBody
	public int idCheck2(@RequestParam("username") String username) {
		int flag = 0;
		System.out.println("id : "+username);
		System.out.println("username.length() :"+username.length()+", boolean");
		
		if(username.equals("")){
			
			flag = 0;
		
		} else if(username.length()<6) {
			
			flag = 2;
			
		}
		
		else if(!authJdbcService.hasUsername(username)) {
			
			flag = 1;
			
		} 
		
		else {
			
			flag = 3;
			
		}
	
		return flag;
	}

	
    @RequestMapping(value="/helloworld", 
    				method = RequestMethod.GET)
    public String helloWorld(ModelMap model) {
    	
	    model.addAttribute("message", "Welcome to the Hello World page");
	    return "helloworld";
    }
    
    @RequestMapping(value="/admin/home", 
					method = RequestMethod.GET)
	public String securedAdminHome(ModelMap model) {
	
		Object principal = SecurityContextHolder.getContext()
												.getAuthentication()
												.getPrincipal();
		
		CustomUser user = null;
		
		if (principal instanceof CustomUser) {
			user = ((CustomUser)principal);
		}
		
		System.out.println(user);
		
		String name = user.getUsername();
		model.addAttribute("username", name);
		model.addAttribute("message", "관리자 페이지에 들어오셨습니다.");
		
		return "admin/home";
    }
    
    @RequestMapping(value="/user/home", 
    				method = RequestMethod.GET)
    public String securedHome(ModelMap model) {
    	
        Object principal = SecurityContextHolder.getContext()
        										.getAuthentication()
        										.getPrincipal();
        
        CustomUser user = null;
        
        if (principal instanceof CustomUser) {
        	user = ((CustomUser)principal);
        }
        
        System.out.println(user);
     
	    String name = user.getUsername();
	    model.addAttribute("username", name);
	    model.addAttribute("message", "일반 사용자 페이지에 들어오셨습니다.");
	    
	    
	    return "user/home";
    }
    
	@RequestMapping("/denied")
	public String denied() {
		
		return "/redirect:/denied";
	}
	
    @RequestMapping(value="/login", method = RequestMethod.GET)
    public String login(ModelMap model) {
    	
    	return "login";
    }
    
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logout(ModelMap model,
    					 HttpServletRequest request,
    					 HttpServletResponse response) {
    	
	    Authentication auth 
		    	= SecurityContextHolder.getContext()
		    						   .getAuthentication();
	    
	    // System.out.println("auth : "+auth);
	    
	    // logout !
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }

	    return "logout";
    }
    
    @RequestMapping(value="/loginError", method = RequestMethod.GET)
    public String loginError(ModelMap model) {
    	
	    model.addAttribute("error", "true");
	    model.addAttribute("msg", "로그인 인증 정보가 잘못되었습니다.");
	    
	    return "login";
    }
    
    @RequestMapping(value="/access-denied", method = RequestMethod.GET)
    public String accessDenied(ModelMap model) {
    	
    	System.out.println("403");
    	
    	model.addAttribute("msg", "계정 권한이 없습니다.");
    	
    	return "denied";
    }
    
 
}