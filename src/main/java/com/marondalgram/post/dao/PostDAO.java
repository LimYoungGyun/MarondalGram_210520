package com.marondalgram.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.marondalgram.post.model.Post;

@Repository
public interface PostDAO {

	public List<Post> selectPostList();
	
	public Post selectPostBypostId(int id);
	
	public int insertPost(
			@Param("userId") int userId
			, @Param("userNickName") String userNickName
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public int deletePost(int id);
}
