package com.marondalgram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.marondalgram.common.EncryptUtils;
import com.marondalgram.user.bo.UserBO;

@RestController
@RequestMapping("/user")
public class UserRestController {
	
	@Autowired
	private UserBO userBO;

	@RequestMapping("/is_duplication_id")
	public Map<String, Boolean> isDuplicationId(
			@RequestParam("loginId") String loginId) {
		
		Map<String, Boolean> result = new HashMap<>();
		result.put("result", userBO.existLoginId(loginId));
		
		return result;
	}
	
	// 
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId
			, @RequestParam("name") String name
			, @RequestParam("nickName") String nickName
			, @RequestParam("password") String password) {
		
		String encryptPassword = EncryptUtils.md5(password);
		
		int cnt = userBO.addNewUser(loginId, name, nickName, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		if (cnt >= 1) {
			result.put("result", "success");
		} else {
			result.put("result", "false");
		}
		
		return result;
	}
}
