package com.javateam.service;

import java.sql.ResultSet;
import java.util.Date;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.javateam.model.vo.Users;
/*
 * Spring JDBC를 사용 : javateacher
 */
@Repository("authJdbcService")
public class AuthJdbcService {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(AuthJdbcService.class);
	
	private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {

		this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    public boolean hasUsername(String username) {
    	
    	boolean flag = false;
    	String sql = "SELECT * FROM users WHERE username=?";
    	
    	logger.info("3");
    	
    	try {
    		
    		 Users user = (Users)this.jdbcTemplate
    				 				 .queryForObject(sql, 
								   				     new Object[]{ username },
								   				     new BeanPropertyRowMapper<Users>(Users.class));
    		 
    		 flag = user != null ? true : false;
    		 
		} catch (Exception e) {
			flag=false;
		}
    	
    	return flag; // 
    }
    
    
    public void insertUsers(Users users, String role) {
    	
    	String sql  = "INSERT INTO users VALUES (?,?,1,?,?,?,?,?,?)";
    	String sql2 = "INSERT INTO user_roles VALUES "
    				+ "(user_roles_seq.nextval,?,?)";
    	
    	this.jdbcTemplate.update(sql, 
    							 new Object[] { users.getUsername(), 
											    users.getPassword(),
											    users.getName(),
											    users.getSex(),
											    users.getPhone(),
											    users.getAddress(),
											    users.getEmail(),
											    users.getJoindate()});
    	
    	this.jdbcTemplate.update(sql2, 
    							 new Object[] { users.getUsername(),
											    role });
    	
    } //
    
 public String getUsers(String username) {
    	
    	String sql  = "SELECT * FROM users WHERE username=?";
 //   	Users user = new Users();
    	
 //   	user = this.jdbcTemplate.queryForObject(sql, new Object[] { username}, user );	
 //   	user = jdbcTemplate.query(sql,new RowMapper<Users>(Users.class));
    	
    	String user = this.jdbcTemplate.queryForObject(sql, new Object[]{username}, String.class);
    	
    	return user;
    } //

}
