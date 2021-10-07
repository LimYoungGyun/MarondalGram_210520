package com.marondalgram.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.marondalgram.post.bo.PostBO;
import com.marondalgram.timeline.bo.ContentBO;
import com.marondalgram.timeline.model.ContentView;

@Controller
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private ContentBO contentBO;

	@RequestMapping("/timeline/timeline_view")
	public String timelineView(Model model) {
		List<ContentView> contentViewList = contentBO.generateContentViewList();
		
		model.addAttribute("contentViewList", contentViewList);
		model.addAttribute("viewName", "timeline/timeline_list");
		
		return "template/layout";
	}
}
