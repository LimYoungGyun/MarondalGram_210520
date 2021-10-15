package com.marondalgram.comments.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.comments.dao.CommentsDAO;
import com.marondalgram.comments.model.Comments;

@Service
public class CommentsBO {

	@Autowired
	private CommentsDAO commentsDAO;
	
	public int addComment(int postId, int userId, String userNickName, String comment) {
		return commentsDAO.insertComment(postId, userId, userNickName, comment);
	}
	
	public List<Comments> getCommentsListByPostId(int postId) {
		return commentsDAO.selectCommentsListByPostId(postId);
	}
}
