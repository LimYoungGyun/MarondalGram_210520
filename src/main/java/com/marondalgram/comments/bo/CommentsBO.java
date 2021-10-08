package com.marondalgram.comments.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.comments.dao.CommentsDAO;

@Service
public class CommentsBO {

	@Autowired
	private CommentsDAO commentsDAO;
	
	public int addComment(int postId, int userId, String userNickName, String comment) {
		return commentsDAO.insertComment(postId, userId, userNickName, comment);
	}
}
