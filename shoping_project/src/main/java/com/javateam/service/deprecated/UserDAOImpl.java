package com.javateam.service.deprecated;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.javateam.model.vo.CustomUser;
import com.javateam.model.vo.Role;

@Repository("userDao")
public class UserDAOImpl implements UserDAO {
	
	@Override
	public void demo() {
		System.out.println("demo");
	}
    
	@Override
    public CustomUser loadUserByUsername(String username) {
         //Write your DB call code to get the user details from DB,But I am just hard coding the user
    	 
    	System.out.println("loadUserByUsername : "+username); 
    	 
        CustomUser user = new CustomUser();
        user.setUsername("kb");
        user.setPassword("1234");
        Role r = new Role();
        r.setUsername("ROLE_USER");
        List<Role> roles = new ArrayList<Role>();
        roles.add(r);
        user.setAuthorities(roles);
        
        return user;
   }
}
