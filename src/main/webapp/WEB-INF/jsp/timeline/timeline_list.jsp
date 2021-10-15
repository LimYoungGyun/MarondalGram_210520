<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${contentViewList}" var="contentView">
<div class="d-flex justify-content-center">
	<div class="postContent">
		<div class="d-flex justify-content-between align-items-center mb-2">
			<div class="lineHeight">
				<div class="userNickName">${contentView.post.userNickName}</div>
				<c:if test="${not empty contentView.post.location}">
					<div class="location">${contentView.post.location}</div>
				</c:if>
			</div>
		
			<%-- class무조건 필요 --%>
			<c:if test="${contentView.post.userId eq userId}">
				<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-post-id="${contentView.post.id}">
					<img class="icon mx-3" alt="" src="/static/icon/more.svg">
				</a>
			</c:if>
		</div>
		
		<div class="">
			<c:if test="${not empty contentView.post.imagePath}">
				<img class="postImage" src="${contentView.post.imagePath}">
			</c:if>
			<c:if test="${empty contentView.post.imagePath}">
				<img class="postImage" src="/static/image/no_image.png">
			</c:if>
		</div>
		
		<%-- 좋아요 & 댓글 --%>
		<div class="likeAndComments">
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
			<a href="/comment/comment_list_view?postId=${contentView.post.id}" class="commentAllViewImage"><img class="listIcon mx-3" alt="" src="/static/icon/comments.png"></a>
		</div>
		
		<div class="likeCount">좋아요 ${contentView.likeCount}개</div>
		
		<div class="d-flex usersComment">
			<div class="font-weight-bold usersNickName">${contentView.post.userNickName}</div>
			<div>${contentView.post.content}</div>
		</div>
		
		<div class="commentAllView"><a href="#" class="allComment text-secondary">댓글 ${contentView.commentList.size()}개 모두 보기</a></div>
		
		<%-- 댓글 보여주는곳 --%>
		<c:if test="${not empty contentView.commentList}">
			<c:forEach items="${contentView.commentList}" var="commentList" begin="0" end="2" step="1">
				<div class="d-flex usersComment">
					<div class="font-weight-bold usersNickName">${commentList.userNickName}</div>
					<div>${commentList.comment}</div>
				</div>
			</c:forEach>
		</c:if>
		
		<hr class="hrLine">
		
		<div class="d-flex justify-content-between align-items-center">
			<textarea rows="1" id="comments${contentView.post.id}" class="col-11 comments" placeholder="댓글 쓰기..."></textarea>
			<div id="commentsRegist" class="commentsRegist opacity4"  data-post-id="${contentView.post.id}">게시</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="moreModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog " role="document">
		<div class="modal-content d-flex justify-content-center align-items-center">
			<a href="#" class="del-post">삭제하기</a>
			<a href="#" class="#" data-dismiss="modal">취소</a>
		</div>
	</div>
</div>


</c:forEach>
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
		
		// ... 버튼 클릭 (삭제를 하기 위해)
		$('.more-btn').on('click', function(e) {
			e.preventDefault();
			
			// postId를 가져온다.
			// 지금 클릭된 태그의 postId를 가져온다.
			// $(this)대신 $('.more-btn')를 사용하면 무조건 첫번째 데이터만 가져온다.
			let postId = $(this).data('post-id');

			// modal에 postId를 넣어준다.
			$('#moreModal').data('post-id', postId);
		});
		
		// modal안에 있는 삭제하기 클릭
		$('#moreModal .del-post').on('click', function(e) {
			e.preventDefault();
			
			let postId = $('#moreModal').data('post-id');
			console.log(postId);
			// 서버한테 글 삭제 요청(ajax)
			$.ajax({
				type : 'post'
				, url : '/post/delete'
				, data : {'postId' : postId}
				, success : function(data) {
					if (data.result == 'success') {
						alert('선택한 게시물을 삭제하였습니다.')
						location.reload();
					}
				}
				, error : function(e) {
					alert('삭제에 실패하였습니다. ' + e);
				}
			});
		});
		
		// 좋아요 클릭 - 좋아요 / 해제
		$('.like-btn').on('click', function(e) {
			e.preventDefault();
			
			let postId = $(this).data('post-id');
// 			alert(postId);
			
			$.ajax({
				type : 'post'
				, url : '/like/' + postId
				, success : function(data) {
					if (data.result = 'sucess') {
						location.reload(true); // 새로고침
					}
				}
				, error : function(e) {
					
				}
			})
		});
		
		$('.allComment').on('click', function(e) {
			e.preventDefault();
		});
		
// 		$('.commentAllViewImage').on('click', function(e) {
// 			e.preventDefault();
// 		});
		
	});

</script>