<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<div class="d-flex justify-content-between align-items-center">
		<div>
			<div class="userNickName">userNickName</div>
			<div>location</div>
		</div>
	
		<a href="#"><img class="icon mx-3" alt="" src="/static/icon/more.svg"></a>
	</div>
	
	<div>
		<img class="postImage" src="https://cdn.pixabay.com/photo/2017/03/28/22/55/night-photograph-2183637__340.jpg">
	</div>
	
	<div class="my-3">
		<img class="listIcon" alt="" src="/static/icon/heart.svg">
		<a href="#"><img class="listIcon mx-3" alt="" src="/static/icon/comments.svg"></a>
	</div>
	
	<div>좋아요 100000개</div>
	<div><a href="#" class="allComment text-secondary">댓글 4개 모두 보기</a></div>
	
	<hr>
	<div class="d-flex justify-content-between align-items-center">
		<input type="text" id="comments" class="form-control col-11" placeholder="댓글 쓰기...">
		<div class="text-primary mr-3">게시</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		let comments = $('#comments').val().trim();
		
		if (comments.lenght <= 0) {
			
		}
	});

</script>