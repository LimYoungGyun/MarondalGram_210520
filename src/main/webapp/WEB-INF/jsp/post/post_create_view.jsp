<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<link rel="stylesheet" type="text/css" href="/static/css/post.css">
    
<div>
	<!-- 글쓰기 등록 -->
	<div class="d-flex justify-content-center">
		<div class="write-box rounded my-3 p-0 col-9">
		<form id="postResist" method="post" action="#">
			<%-- 내용입력 --%>
			<textarea rows="10" id="writeTextArea" placeholder="내용을 입력해주세요" class="form-control w-100"></textarea>
			
			<%-- 위치 입력 --%>
			<input type="text" id="location" class="form-control location" placeholder="위치를 입력해주세요.">
			
			<%-- 업로드한 이미지 보이기 --%>
			<div id="imageView" class="imageView d-none" >
				<img id="imageViewImg" alt="" src="">
			</div>
			
			<%-- 파일 업로드 --%>
			<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
			<div class="d-flex justify-content-between file-line">
				<div class="file-upload d-flex">
					<%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
					<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
					<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
					<a href="#" id="fileUploadBtn"><img class="uploadImage" width="40" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
					
					<%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
					<div id="fileName" class="ml-2">
					</div>
				</div>
				<button type="button" id="deleteBtn" class="btn btn-danger d-none">파일 삭제</button>
			</div>
			
			<%-- 등록버튼 --%>
			<button type="submit" id="writeBtn" class="btn btn-primary btn-block writeBtn">등록</button>
		</form>	
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		// 파일 업로드 이미지 버튼 클릭 -> 파일 선택 창이 뜸
		$('#fileUploadBtn').on('click', function(e) {
			e.preventDefault();// 제일 위로 올라가는 동작 중지
			$('#file').click(); // 사용자가 input file을 클릭한 것과 같은 동작
		});
		
		// 사용자가 파일을 선택했을 때 => 파일명이 옆에 노출시킴
		$('#file').on('change', function(e) {
			// 이미지 파일 불러오기
			let file = e.target.files[0];
			let reader = new FileReader();
			
			reader.onload = function(){
				$('#imageViewImg').attr('src', this.result);
			}
			reader.readAsDataURL(file);
			// 이미지 파일 불러오기 - end
			
			// 
			let fileName = e.target.files[0].name;
			// console.log("fileName : " + fileName);
			
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
			
			// 파일이 존재하면 보이기
			$('#imageView').removeClass("d-none");
			$('#deleteBtn').removeClass("d-none");
			
			$('#fileName').text(fileName); // 파일명을 div 노출시킨다.
		});
		
		$('#writeBtn').on('click', function() {
			let writeTextArea = $('#writeTextArea').val();
			let locations =  $('#location').val();
			
			if (writeTextArea == '') {
				alert('게시글을 입력해주세요.');
			}
			
			// form태그를 자바스크립트에서 만든다.
			let formData = new FormData(); // 자바스크립트에서 제공해주는 객체
			formData.append('content', writeTextArea);
			formData.append('location', locations);
			formData.append('file', $('#file')[0].files[0]);
			
			$.ajax({
				type: 'post'
				, url : '/post/create'
				, data : formData
				, enctype : 'multipart/form-data' // 파일 업로드할때 필수태그 - 파일 업로드 필수 설정
				, processData : false // 파일 업로드할때 필수태그 - 파일 업로드 필수 설정
				, contentType : false // 파일 업로드할때 필수태그 - 파일 업로드 필수 설정
				, success : function(data) {
					if (data.result == 'success') {
						alert('게시글이 저장되었습니다.');
						location.href='/timeline/timeline_view';
					}
				}
				, error : function(e) {
					alert('메모 저장에 실패했습니다.' + e);
				}
			});
		});
		
		$('#deleteBtn').on('click', function() {
			$('#fileName').text('');
			$('#file').val('');
			$('#imageViewImg').attr('src', '');
			$('#imageView').addClass("d-none");
			$('#deleteBtn').addClass("d-none");
		});
		
		$('#postResist').submit(function(e) {
			e.preventDefault();
			
			let writeTextArea = $('#writeTextArea').val();
			if (writeTextArea == '') {
				alert('내용을 입력해 주세요.');
			}
			console.log('eserser');
		});
// 		$('#writeBtn').on('click', function() {
// 			let writeTextArea = $('#writeTextArea').val();
// 			if (writeTextArea == '') {
// 				alert('내용을 입력해 주세요.');
// 			}
// 		});
		
	});

</script>