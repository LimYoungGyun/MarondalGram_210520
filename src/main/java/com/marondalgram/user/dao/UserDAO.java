package com.marondalgram.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.marondalgram.user.model.User;

@Repository
public interface UserDAO {

	public boolean existLoginId(String loginId);
	
	public int insertNewUser(
			@Param("loginId") String loginId
			, @Param("name") String name
			, @Param("nickName") String nickName
			, @Param("password") String password);
	
	public User selectUserByLoginIDAndPassword(
			@Param("loginId") String loginId
			, @Param("password") String password);
}
