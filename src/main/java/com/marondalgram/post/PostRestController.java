package com.marondalgram.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.marondalgram.post.bo.PostBO;

@RestController
@RequestMapping("/post")
public class PostRestController {

	@Autowired
	private PostBO postBO;
	
	/**
	 * 게시물 작성
	 * @param content
	 * @param file
	 * @param request
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content
			, @RequestParam(value = "location", required = false) String location
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
		
		int row = postBO.createpost(userId, userLoginId, userNickName, content, location, file);
		if (row > 0) {
			result.put("result", "success");
		}
		
		return result;
	}
	
	/**
	 * 게시물 삭제
	 * @param postId
	 * @return
	 */
	@PostMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId) {
		
		
		// comment -> postId
		// like -> postId
		// 그림
		int cnt = postBO.deletePost(postId);
		Map<String, Object> result = new HashMap<>();
		
		if (cnt >= 1) {
			result.put("result", "success");
		}
		
		return result;
	}
}
