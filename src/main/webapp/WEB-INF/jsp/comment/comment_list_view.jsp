<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/static/css/commentAllView.css">


<div class="d-flex justify-content-center contentListView">
	<div class="imageArea">
		<c:if test="${not empty contentView.post.imagePath}">
			<img class="postImages" src="${contentView.post.imagePath}">
		</c:if>
		<c:if test="${empty contentView.post.imagePath}">
			<img class="postImages" src="/static/image/no_image.png">
		</c:if>
	</div>
	
	<div class="contentViewArea">
		<div class="contentViewAreaTop">
			<div class="d-flex justify-content-between align-items-center">
				<div class="userNickName">${contentView.post.userNickName}</div>
				<c:if test="${not empty contentView.post.location}">
					<div class="location">${contentView.post.location}</div>
				</c:if>
			</div>
		</div>
		
		<div class="contentViewAreaSection">
			<div class="d-flex userComment">
				<div class="font-weight-bold usersNickName">${contentView.post.userNickName}</div>
				<div>${contentView.post.content}</div>
			</div>
			
			<%-- 댓글 보여주는곳 --%>
			<div class="">
				<c:if test="${not empty contentView.commentList}">
					<c:forEach items="${contentView.commentList}" var="commentList">
						<div class="d-flex userCommentArea">
							<div class="font-weight-bold usersNickName">${commentList.userNickName}</div>
							<div>${commentList.comment}</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		
		<%-- 좋아요 & 댓글 --%>
		<div class="d-flex likeAndComments">
			<%-- 좋아요 상태 --%>
			<%-- 비워진 상태 --%>
			<c:if test="${contentView.likeYn eq false }">
 				<!-- <img class="listIcon" alt="" src="/static/icon/heart.svg"> -->
 				<a href="#" class="like-btn" data-post-id="${contentView.post.id}">
					<img class="listIcon" alt="" src="/static/icon/blackheart.png">
				</a>
			</c:if>
			<%-- 채워진 상태 --%>
			<c:if test="${contentView.likeYn eq true }">
 				<!-- <img class="listIcon" alt="" src="/static/icon/heart.svg"> -->
 				<a href="#" class="like-btn" data-post-id="${contentView.post.id}">
					<img class="listIcon" alt="" src="/static/icon/redheart.png">
				</a>
			</c:if>
			<div class="likeCount">좋아요 ${contentView.likeCount}개</div>
		</div>
		
		<hr class="hrLine">
		
		<div class="contentViewAreaFooter">
			<div class="d-flex justify-content-between align-items-center">
				<textarea rows="1" id="comments${contentView.post.id}" class="col-10 comments" placeholder="댓글 쓰기..."></textarea>
				<div id="commentsRegist" class="commentsRegist opacity4"  data-post-id="${contentView.post.id}">게시</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('.comments').on('input', function() {
			let comments = $(this).val();
			
			if (comments.length > 0) {
				$(this).siblings().removeClass('opacity4');
				$(this).addClass('opacity8');
				$(this).siblings().css('cursor', 'pointer');
			} else {
				$(this).siblings().removeClass('opacity8');
				$(this).siblings().addClass('opacity4');
				$(this).siblings().css('cursor', 'Default');
			}
		});
		
		$('.commentsRegist').on('click', function(e) {
			e.preventDefault();
			let postId = $(this).data('post-id');
			
			// comments글번호
			let comment = $('#comments' + postId).val();
// 			alert(postId);
			
			if (comment.length > 0) {
// 				alert('게시물 등록');
				
				$.ajax({
					type : 'post'
					, url : '/comments/create'
					, data : {'comment' : comment
						, 'postId' : postId}
					, success : function(data) {
						if (data.result == "success") {
							alert("댓들 등록이 완료되었습니다.");
							location.reload();
						}
					}
					, error : function(e) {
						alert('댓들 등록이 실패하였습니다.' + e);
					}
				});
				
			}
		});
	});
</script>