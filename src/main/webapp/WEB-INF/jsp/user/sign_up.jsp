<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
	<head>
	<meta charset="UTF-8">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	<!-- datepicker 라이브러리 -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="/static/css/login.css">
	
	<title>회원가입</title>
	</head>
	<body>
		<div class="container col-3">
			<div class="test p-5">
				<h1 class="text-center mb-5">marondalgram</h1>
				<section>
					<form id="signUpForm" method="post" action="/user/sign_up">
						<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
						
						<button type="button" id="loginIdCheckBtn" class="btn btn-success btn-block my-3">중복확인</button>
						<input type="text" id="name" name="name" class="form-control mb-3" placeholder="사용자 이름을 입력하세요.">
						<input type="text" id="nickName" name="nickName" class="form-control mb-3" placeholder="닉네임을 입력하세요.">
						<input type="password" id="password" name="password" class="form-control mb-3" placeholder="비밀번호를 입력하세요.">
						
						<button type="button" id="signUpBtn" class="btn btn-primary btn-block">가입하기</button>
					</form>
				</section>
			</div>
			<br>
			<div class="test p-4">
				<div class="text-center">
					계정이 있으신가요? <a href="/user/sign_in_view">로그인</a>
				</div>
			</div>
		</div>
	</body>	
	<script>
		$(document).ready(function() {
			// 아이디 중복 확인
			$('#loginIdCheckBtn').on('click', function(e) {
				let loginId = $('#loginId').val().trim();
				
				if (loginId.length < 4) {
					$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
					$('#idCheckDuplicated').addClass('d-none'); // 숨김
					$('#idCheckOk').addClass('d-none'); // 숨김
					return;
				}
				
				// ajax 서버 호출 (중복여부)
				$.ajax({
					type:'GET'
					, url :'/user/is_duplication_id'
					, data : {'loginId' : loginId}
					, success : function(data) {
						
						// true:회원가입 불가능(중복), false:회원가입 가능
						if (data.result) {
							// 중복이다. 
							$('#idCheckDuplicated').removeClass('d-none'); // 경고문구 노출
							$('#idCheckLength').addClass('d-none'); // 숨김
							$('#idCheckOk').addClass('d-none'); // 숨김
						} else {
							// 중복이 아니면 => 가능
							$('#idCheckOk').removeClass('d-none'); // 경고문구 노출
							$('#idCheckLength').addClass('d-none'); // 숨김
							$('#idCheckDuplicated').addClass('d-none'); // 숨김
						}
					}
					, error : function(e) {
						alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
					}
				})
			});
			
			// 회원가입
			$('#signUpBtn').on('click', function(e) {
				let loginId = $('#loginId').val().trim();
				let name = $('#name').val().trim();
				let nickName = $('#nickName').val().trim();
				let password = $('#password').val().trim();
				
				if (loginId == '') {
					alert('아이디를 입력하세요.');
					return;
				}
				if (name == '') {
					alert('이름을 입력하세요.');
					return;
				}
				if (nickName == '') {
					alert('닉네임을 입력하세요.');
					return;
				}
				if (password == '') {
					alert('비밀번호를 입력하세요.');
					return;
				}
				
				if ($('#idCheckOk').hasClass('d-none')) {
					alert('중복확인을 눌러주세요!!!');
				}
				
				
				/* $.ajax({
					type:"post"
					, url:''
					, data:{}
					, success:function(data) {
					
					}
					, error:function(e) {
						
					}
				});
				*/
				let url = $('#signUpForm').attr('action');
				// name값 필수
				let data = $('#signUpForm').serialize(); // 폼태그에 있는 데이터를 한번에 보낼 수 있게 구성한다. 그렇지 않으면 json으로 구성을 해야한다.(queryString으로 만들어준다.)
				// ajax
				$.post(url, data)
				.done(function(data){
					if (data.result == 'success') {
						alert('가입을 환영합니다.!!! 로그인 해주세요.');
						location.href = '/user/sign_in_view';
					} else {
						alert('가입에 실패했습니다.');
					}
				});
			});
		});
		
	</script>
</html>