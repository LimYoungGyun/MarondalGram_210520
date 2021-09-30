package com.marondalgram.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.user.dao.UserDAO;
import com.marondalgram.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	public boolean existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}
	
	public int addNewUser(String loginId, String name, String nickName, String password) {
		return userDAO.insertNewUser(loginId, name, nickName, password);
	}
	
	public User getUserByLoginIDAndPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIDAndPassword(loginId, password);
	}
}
