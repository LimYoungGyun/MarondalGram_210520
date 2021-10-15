package com.marondalgram.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.marondalgram.like.model.Like;

@Repository
public interface LikeDAO {

	public Like selectLikeYnByPostIdAndUserId(
			@Param("postId") int postId
			, @Param("userId") int userId);
	
	public int insertLikeYByPostIdAndUserId(
			@Param("postId") int postId
			, @Param("userId") int userId);
	
	public int deleteLikeYByPostIdAndUserId(
			@Param("postId") int postId
			, @Param("userId") int userId);
	
	public int selectLikeCountByPostId(int postId);
}
