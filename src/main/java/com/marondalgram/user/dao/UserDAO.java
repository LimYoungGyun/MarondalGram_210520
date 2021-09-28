package com.marondalgram.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDAO {

	public boolean existLoginId(String loginId);
	
	public int insertNewUser(
			@Param("loginId") String loginId
			, @Param("name") String name
			, @Param("nickName") String nickName
			, @Param("password") String password);
}
