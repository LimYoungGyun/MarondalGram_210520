package com.marondalgram.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.marondalgram.like.bo.LikeBO;
import com.marondalgram.like.model.Like;

@RestController
public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;

	@PostMapping("/like/{postId}")
	public Map<String, Object> postLike(
			@PathVariable int postId
			, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");

		Map<String, Object> result = new HashMap<>();
		
		// 해당 게시물이 있는지 존재
		Like like = likeBO.getLikeYnByPostIdAndUserId(postId, userId);
		
		int cnt = 0;
		if (like != null) {
			// 있으면 좋아요를 취소 - 삭제
			cnt = likeBO.deleteLikeYByPostIdAndUserId(postId, userId);
			if (cnt >= 1) {
				result.put("result", "success");
			} else {
				result.put("result", "fail");
			}
		}
		else {
			// 없으면 좋아요를 선택 - 삽입
			cnt = likeBO.addLikeYByPostIdAndUserId(postId, userId);
			if (cnt >= 1) {
				result.put("result", "success");
			} else {
				result.put("result", "fail");
			}
		}
		
		return result;
	}
	
}
