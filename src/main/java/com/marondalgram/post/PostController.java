package com.marondalgram.post;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostController {

	@RequestMapping("/post_create_view")
	public String postCreateView(Model model) {
		
		model.addAttribute("viewName", "post/post_create_view");
		return "template/layout";
	}
}
