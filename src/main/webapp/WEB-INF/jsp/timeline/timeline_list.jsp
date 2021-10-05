<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 글쓰기 등록 -->
<div class="d-flex justify-content-center">
	<div class="write-box border rounded my-3 p-0 col-9">
		<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
		
		<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
		<div class="d-flex justify-content-between">
			<div class="file-upload d-flex">
				<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
				<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
				<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
				<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
	
				<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
				<div id="fileName" class="ml-2">
				</div>
			</div>
			<button id="writeBtn" class="btn btn-info">게시</button>
		</div>
	</div>	
</div>
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
		// 파일 업로드 이미지 버튼 클릭 -> 파일 선택 창이 뜸
		$('#fileUploadBtn').on('click', function(e) {
			e.preventDefault();// 제일 위로 올라가는 동작 중지
			$('#file').click(); // 사용자가 input file을 클릭한 것과 같은 동작
		});
		
		// 사용자가 파일을 선택했을 때 => 파일명이 옆에 노출시킴
		$('#file').on('change', function(e) {
			let fileName = e.target.files[0].name;
			console.log("fileName : " + fileName);
			
			let fileNameArr = fileName.split('.');
			if (fileNameArr[fileNameArr.length - 1] != 'png'
				&& fileNameArr[fileNameArr.length - 1] != 'gif'
				&& fileNameArr[fileNameArr.length - 1] != 'jpg'
				&& fileNameArr[fileNameArr.length - 1] != 'jpeg') {
				alert('이미지 파일만 업로드 할 수 있습니다.');
				$(this).val(''); // 올라가 있는 잘못됫 파일을 비워준다.
				$('#fileName').text('');
				return;
			}
			
			$('#fileName').text(fileName); // 파일명을 div 노출시킨다.
		});
		
		$('#writeBtn').on('click', function() {
			let writeTextArea = $('#writeTextArea').val();
			
			if (writeTextArea == '') {
				alert('게시글을 입력해주세요.');
			}
			
			// form태그를 자바스크립트에서 만든다.
			let formData = new FormData(); // 자바스크립트에서 제공해주는 객체
			formData.append('content', writeTextArea);
			formData.append('file', $('#file')[0].files[0]);
			
			$.ajax({
				type: 'post'
				, url : '/timeline/create'
				, data : formData
				, enctype : 'multipart/form-data' // 파일 업로드할때 필수태그 - 파일 업로드 필수 설정
				, processData : false // 파일 업로드할때 필수태그 - 파일 업로드 필수 설정
				, contentType : false // 파일 업로드할때 필수태그 - 파일 업로드 필수 설정
				, success : function(data) {
					if (data.result == 'success') {
						alert('메모가 저장되었습니다.');
						location.href='/timeline/timeline_view';
					}
				}
				, error : function(e) {
					alert('메모 저장에 실패했습니다.' + e);
				}
			});
		});
		
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