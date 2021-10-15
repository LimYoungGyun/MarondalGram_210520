package com.marondalgram.comments;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.marondalgram.timeline.bo.ContentBO;
import com.marondalgram.timeline.model.ContentView;

@Controller
@RequestMapping("/comment")
public class CommentsController {
	
	@Autowired
	private ContentBO contentBO;

	@RequestMapping("/comment_list_view")
	public String commentListView(
			@RequestParam("postId") int postId
			,  HttpServletRequest request
			, Model model) {
		
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");
		
		ContentView contentView = contentBO.generateContentView(userId, postId);
		
		model.addAttribute("postId", postId);
		model.addAttribute("contentView", contentView);
		model.addAttribute("viewName", "comment/comment_list_view");
		return "template/layout";
	}
}
