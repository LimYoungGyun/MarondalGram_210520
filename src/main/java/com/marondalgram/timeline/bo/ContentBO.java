package com.marondalgram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.post.bo.PostBO;
import com.marondalgram.post.model.Post;
import com.marondalgram.timeline.model.ContentView;

@Service
public class ContentBO {
	
	// TODO : 타임라인 기능??
	
	@Autowired
	private PostBO postBO;
	
	public List<ContentView> generateContentViewList() {
		
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
			// contentView.setLikeYn();
			
			// 좋아요 개수
			// contentView.setLikeCount();
			
			ContentViewList.add(contentView);
		}
		
		return ContentViewList;
	}
}
