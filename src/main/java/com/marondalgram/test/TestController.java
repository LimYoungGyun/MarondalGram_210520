package com.marondalgram.test;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.marondalgram.test.bo.TestBO;

@Controller
public class TestController {

	@Autowired
	private TestBO testBO;
	
	@ResponseBody
	@RequestMapping("/test1")
	public String test1() {
		return "Hello world!!!!!";
	}
	
	@ResponseBody
	@RequestMapping("/test2")
	public List<Map<String, Object>> test2() {
		return testBO.getUserList();
	}
	
	@RequestMapping("/test3")
	public String test3() {
		return "test/test";
	}
}
