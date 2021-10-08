package com.marondalgram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.like.bo.LikeBO;
import com.marondalgram.like.model.Like;
import com.marondalgram.post.bo.PostBO;
import com.marondalgram.post.model.Post;
import com.marondalgram.timeline.model.ContentView;

@Service
public class ContentBO {
	
	// TODO : 타임라인 기능??
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public List<ContentView> generateContentViewList(int userId) {
		
		List<ContentView> ContentViewList = new ArrayList<>();
		
		List<Post> postList = postBO.getPostList();
		
		for (Post post : postList) {
			ContentView contentView = new ContentView();
			
			// 게시물
			contentView.setPost(post);
			
			// 댓글들
			// contentView.setCommentList();
			
			// 내가 한 좋아요 여부
			// 좋아요 -> userId, postId
			Like like = likeBO.getLikeYnByPostIdAndUserId(post.getId(), userId);
			if (like == null) {
				contentView.setLikeYn(false);
			} else {
				contentView.setLikeYn(true);
			}
			
			// 좋아요 개수
			// 좋아요 -> postId
			// contentView.setLikeCount();
			
			ContentViewList.add(contentView);
		}
		
		return ContentViewList;
	}
}
