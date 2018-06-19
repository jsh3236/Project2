package com.javateam.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.javateam.model.vo.CustomUser;
import com.javateam.model.vo.Role;

@Component
public class CustomProvider 
		implements AuthenticationProvider, UserDetailsService {
	
    private static final Logger logger 
		= LoggerFactory.getLogger(CustomProvider.class);
   
	private JdbcTemplate jdbcTemplate;
	
    @Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
    @Override
	public CustomUser loadUserByUsername(String username) {
    	
    	try {
	    	return (CustomUser)jdbcTemplate.queryForObject(
	    			 "SELECT * FROM users WHERE username=?", 
				     new Object[]{ username },
				     new BeanPropertyRowMapper<CustomUser>(CustomUser.class));
	    } catch (EmptyResultDataAccessException e) {
	    	System.out.println("error1");
	    	return null;
	    }
    }
	
	private Role loadUserRole(String username) {
		
		try {
			return (Role)jdbcTemplate.queryForObject(
	   			 	"SELECT username, role FROM user_roles WHERE username=?", 
				     new Object[]{ username },
				     new BeanPropertyRowMapper<Role>(Role.class));
		} catch (EmptyResultDataAccessException e) {
			System.out.println("error2");
	    	return null;
	    }
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) 
				throws AuthenticationException {
		
		String username = authentication.getName();
        String password = (String) authentication.getCredentials();

        CustomUser user = null;
        Collection<? extends GrantedAuthority> authorities = null;
        
        try {
	        	user = this.loadUserByUsername(username);
	            Role role = this.loadUserRole(username);
	            
	            List<Role> roles = new ArrayList<Role>();
	            roles.add(role);		
	            user.setAuthorities(roles);
	            
	            BCryptPasswordEncoder passwordEncoder 
					= new BCryptPasswordEncoder();
	            
	            if (passwordEncoder.matches(password, user.getPassword())) 
	            	System.out.println("비밀번호 일치 !");	
	            else 
	            	throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
	            
	            authorities = user.getAuthorities();
            
        } catch(UsernameNotFoundException e) {
            logger.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch(BadCredentialsException e) {
            logger.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch(Exception e) {
            logger.info(e.toString());
            // throw new RuntimeException(e.getMessage());
            e.printStackTrace();
        }

        return new UsernamePasswordAuthenticationToken(user, password, authorities);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

}
