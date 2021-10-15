package com.marondalgram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.marondalgram.comments.bo.CommentsBO;
import com.marondalgram.comments.model.Comments;
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
	
	@Autowired
	private CommentsBO commentsBO;
	
	public List<ContentView> generateContentViewList(int userId) {
		
		List<ContentView> ContentViewList = new ArrayList<>();
		
		List<Post> postList = postBO.getPostList();
		
		for (Post post : postList) {
			ContentView contentView = new ContentView();
			
			// 게시물
			contentView.setPost(post);
			
			// 댓글들
			List<Comments> commentList = commentsBO.getCommentsListByPostId(post.getId());
			contentView.setCommentList(commentList);
			
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
			int likeCount = likeBO.getLikeCountByPostId(post.getId());
			contentView.setLikeCount(likeCount);
			
			ContentViewList.add(contentView);
		}
		
		return ContentViewList;
	}
	
	public ContentView generateContentView(int userId, int postId) {
		
		
		Post post = postBO.getPostBypostId(postId);
		
		ContentView contentView = new ContentView();
		
		// 게시물
		contentView.setPost(post);
		
		// 댓글들
		List<Comments> commentList = commentsBO.getCommentsListByPostId(post.getId());
		contentView.setCommentList(commentList);
		
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
		int likeCount = likeBO.getLikeCountByPostId(post.getId());
		contentView.setLikeCount(likeCount);
		
		return contentView;
	}
}
