package com.javateam.service.deprecated;

import com.javateam.model.vo.CustomUser;

public interface UserDAO {

	CustomUser loadUserByUsername(String username);
	void demo();

}
