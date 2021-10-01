<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${postList}" var="post">
<div class="d-flex justify-content-center">
	<div class="postContent">
		<div class="d-flex justify-content-between align-items-center mb-2">
			<div class="lineHeight">
				<div class="userNickName">${post.userNickName}</div>
				<c:if test="${not empty post.location}">
					<div>${post.location}</div>
				</c:if>
			</div>
		
			<a href="#"><img class="icon mx-3" alt="" src="/static/icon/more.svg"></a>
		</div>
		
		<div>
			<img class="postImage" src="${post.imagePath}">
		</div>
		
		<div class="my-3">
			<img class="listIcon" alt="" src="/static/icon/heart.svg">
			<a href="#"><img class="listIcon mx-3" alt="" src="/static/icon/comments.svg"></a>
		</div>
		
		<div>좋아요 100000개</div>
		<div><a href="#" class="allComment text-secondary">댓글 4개 모두 보기</a></div>
		
		<hr>
		<div class="d-flex justify-content-between align-items-center">
			<textarea rows="1" id="comments" class="form-control col-11" placeholder="댓글 쓰기..."></textarea>
			<div id="commentsRegist" class="commentsRegist opacity4">게시</div>
		</div>
	</div>
</div>
</c:forEach>
<script>
	$(document).ready(function() {
		$('#comments').on('input', function() {
			let comments = $('#comments').val().trim();
			
			if (comments.length > 0) {
				$('#commentsRegist').removeClass('opacity4');
				$('#commentsRegist').addClass('opacity8');
				$('#commentsRegist').css('cursor', 'pointer');
			} else {
				$('#commentsRegist').removeClass('opacity8');
				$('#commentsRegist').addClass('opacity4');
				$('.commentsRegist').css('cursor', 'Default');
			}
		});
		
		$('#commentsRegist').on('click', function() {
			let comments = $('#comments').val().trim();
			if (comments.length > 0) {
				alert('게시물 등록');
			}
		});
		
		
	});

</script>