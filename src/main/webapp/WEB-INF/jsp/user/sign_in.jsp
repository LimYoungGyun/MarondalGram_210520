<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="crossorigin="anonymous"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	<!-- datepicker 라이브러리 -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="/static/css/login.css">
	
	<title>로그인</title>
	</head>
	<body>
		<div class="container col-3">
			<div class="test p-5">
				<h1 class="text-center mb-5">marondalgram</h1>
				<form id="loginForm" action="/user/sign_in" method="post">
					<section>
						<input type="text" id="loginId" name="loginId" class="form-control mb-3" placeholder="아이디를 입력하세요.">
						<input type="password" id="password" name="password" class="form-control mb-3" placeholder="비밀번호를 입력하세요.">
						<button type="submit" class="btn btn-primary btn-block">로그인</button>
					</section>
				</form>
			</div>
			<br>
			<div class="test p-4">
				<div class="text-center">
					계정이 없으신가요? <a href="/user/sign_up_view">가입하기</a>
				</div>
			</div>
		</div>
	</body>
	<script>
		$(document).ready(function() {
			$('#loginForm').submit(function(e) {
				e.preventDefault();
				
				let loginId = $('#loginId').val().trim();
				let password = $('#password').val().trim();
				
				if (loginId == '') {
					alert('아이디를 입력해주세요.');
					return false;
				}
				if (password == '') {
					alert('비밀번호를 입력해주세요.');
					return false;
				}
				
				let url = $(this).attr('action');
				let data = $(this).serialize();
				
				$.post(url, data)
				.done(function(data) {
					if (data.result == 'success') {
						location.href = '/timeline/timeline_view';
					} else {
						alert('로그인에 실패했습니다. 다시 시도해주세요.');
					}
				})
			});
		});
		
	</script>
</html>