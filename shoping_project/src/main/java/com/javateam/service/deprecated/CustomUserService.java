package com.javateam.service.deprecated;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.javateam.model.vo.CustomUser;

@Component("userService")
public class CustomUserService implements UserDetailsService {

	@Autowired
	private UserDAOImpl userDao; 
    
    @Override
    public CustomUser loadUserByUsername(String username) 
    			throws UsernameNotFoundException {
    	
       System.out.println("CustomService loadUSer...");
       return userDao.loadUserByUsername(username);
    }
}
