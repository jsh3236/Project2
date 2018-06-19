package com.javateam.service.deprecated;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import com.javateam.model.vo.CustomUser;
import com.javateam.service.AuthJdbcService;

@Service("customAuthenticationProvider")
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	AuthJdbcService authJdbcService;
	
	@Autowired
	private CustomUserService userService;
	
	@Autowired
	UserDAO userDao;
    
    @Override
    public Authentication authenticate(Authentication authentication) 
    			throws AuthenticationException {
       
    	String username = authentication.getName();
        String password = (String) authentication.getCredentials();
        
        System.out.println("username : "+username);
        System.out.println("password : "+password);
 
       /* CustomUser user = new CustomUser();
        user.setFirstName("kb");
        user.setLastName("gc");
        user.setUsername("kb");
        user.setPassword("1234");
        Role r = new Role();
        r.setName("ROLE_USER");
        List<Role> roles = new ArrayList<Role>();
        roles.add(r);
        user.setAuthorities(roles);*/
       // CustomUser user = userService.loadUserByUsername(username);
        CustomUser user = userDao.loadUserByUsername(username);
       // CustomUser user = getUser(username);
        
        System.out.println("user : "+user);
 
        if (user == null || !user.getUsername().equalsIgnoreCase(username)) {
            throw new BadCredentialsException("Username not found.");
        }
 
        if (!password.equals(user.getPassword())) {
            throw new BadCredentialsException("Wrong password.");
        }
 
        Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
 
        return new UsernamePasswordAuthenticationToken(user, password, authorities);
    }
 
    @Override
    public boolean supports(Class<?> arg0) {
        return true;
    }

}
