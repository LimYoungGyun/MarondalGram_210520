package com.marondalgram.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.like.dao.LikeDAO;
import com.marondalgram.like.model.Like;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
	
	public Like getLikeYnByPostIdAndUserId(int postId, int userId) {
		return likeDAO.selectLikeYnByPostIdAndUserId(postId, userId);
	}
	
	public int addLikeYByPostIdAndUserId(int postId, int userId) {
		return likeDAO.insertLikeYByPostIdAndUserId(postId, userId);
	}
	
	public int deleteLikeYByPostIdAndUserId(int postId, int userId) {
		return likeDAO.deleteLikeYByPostIdAndUserId(postId, userId);
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostId(postId);
	}
}
