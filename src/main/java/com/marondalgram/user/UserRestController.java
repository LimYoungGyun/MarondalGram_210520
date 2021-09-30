package com.marondalgram.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.marondalgram.common.EncryptUtils;
import com.marondalgram.user.bo.UserBO;
import com.marondalgram.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {
	
	@Autowired
	private UserBO userBO;

	/**
	 * 아이디 중복확인
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplication_id")
	public Map<String, Boolean> isDuplicationId(
			@RequestParam("loginId") String loginId) {
		
		Map<String, Boolean> result = new HashMap<>();
		result.put("result", userBO.existLoginId(loginId));
		
		return result;
	}
	
	/**
	 * 회원가입
	 * @param loginId
	 * @param name
	 * @param nickName
	 * @param password
	 * @return
	 */
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
	
	/**
	 * 로그인
	 * @param loginId
	 * @param password
	 * @param request
	 * @return
	 */
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request) {
		
		String encryptPassword = EncryptUtils.md5(password);
		
		User user = userBO.getUserByLoginIDAndPassword(loginId, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		
		if (user != null) {
			result.put("result", "success");
			session.setAttribute("userid", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userNickName", user.getNickName());
			session.setAttribute("userLoginId", user.getLoginId());
		} else {
			result.put("result", "false");
		}
		return result;
	}
}
