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
			contentView.setPost(post);
			
			ContentViewList.add(contentView);
		}
		
		return ContentViewList;
	}
}
