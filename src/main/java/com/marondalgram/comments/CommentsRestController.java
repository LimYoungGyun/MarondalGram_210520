package com.marondalgram.comments;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.marondalgram.comments.bo.CommentsBO;
// /comments/create
@RestController
@RequestMapping("/comments")
public class CommentsRestController {
	
	@Autowired
	private CommentsBO commentsBO;

	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("comment") String comment
			, @RequestParam("postId") int postId
			, HttpServletRequest request) {
		
		// loginID
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");
		String userNickName = (String) session.getAttribute("userNickName");
		
		int cnt = commentsBO.addComment(postId, userId, userNickName, comment);
		
		Map<String, Object> result = new HashMap<>();
		if (cnt >= 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
