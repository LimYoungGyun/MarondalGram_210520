package com.marondalgram.timeline;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.marondalgram.post.bo.PostBO;

@RestController
@RequestMapping("/timeline")
public class TimelineRestController {
	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content
			, @RequestParam(value = "file", required = false) MultipartFile file
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		String userNickName = (String) session.getAttribute("userNickName");
		
		Map<String, Object> result = new HashMap<>();
		
		if (userId == null) {
			result.put("result", "error");
			return result;
		}
		
		int row = postBO.createpost(userId, userLoginId, userNickName, content, file);
		if (row > 0) {
			result.put("result", "success");
		}
		
		return result;
	}

}
