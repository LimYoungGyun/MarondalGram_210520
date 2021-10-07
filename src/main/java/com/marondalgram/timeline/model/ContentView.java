package com.marondalgram.timeline.model;

import com.marondalgram.post.model.Post;

public class ContentView {

	// TODO 타임라인 기능??
	
	// 글 1개
	private Post post;
	
	// 댓글 N개
//	private List<Comments> commentList;
	
	// 내가 한 좋아요
	private boolean likeYn; // true 좋아요  false: 좋아요 해제
	
	// 좋아요 총 개수
	private int likeCount;

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

//	public List<Comments> getCommentList() {
//		return commentList;
//	}
//
//	public void setCommentList(List<Comments> commentList) {
//		this.commentList = commentList;
//	}

	public boolean isLikeYn() {
		return likeYn;
	}

	public void setLikeYn(boolean likeYn) {
		this.likeYn = likeYn;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
}
