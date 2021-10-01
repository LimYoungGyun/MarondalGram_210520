package com.marondalgram.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

	@RequestMapping("/sign_in_view")
	public String signInView(Model model) {
		return "user/sign_in";
	}
	
	@RequestMapping("/sign_up_view")
	public String signUpView(Model model) {
		return "user/sign_up";
	}
	
	@RequestMapping("/sign_out")
	public String signOut(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/user/sign_in_view";
	}
}
