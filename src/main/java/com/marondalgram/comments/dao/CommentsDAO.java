package com.marondalgram.comments.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.marondalgram.comments.model.Comments;

@Repository
public interface CommentsDAO {

	public int insertComment(
			@Param("postId") int postId
			, @Param("userId") int userId
			, @Param("userNickName") String userNickName
			, @Param("comment") String comment);
	
	public List<Comments> selectCommentsListByPostId(int postId);
}
