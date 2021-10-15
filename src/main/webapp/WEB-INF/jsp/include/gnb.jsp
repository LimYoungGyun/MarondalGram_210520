<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container d-flex justify-content-between align-items-center fix-header">
	<h1><a href="/timeline/timeline_view" class="text-dark logo">MarondalGram</a></h1>
	
	<div class="d-flex align-items-center">
		<a href="/post/post_create_view"><img class="icon" alt="" src="/static/icon/add.png"></a>
		<div class="dropdown">
			<a href="#" class="" data-toggle="dropdown" aria-haspopup="true"><img class="icon mx-4" alt="" src="/static/icon/user.svg"></a>
			<div class="dropdown-menu" aria-labelledby="navbarDropdown">
				<a class="dropdown-item" href="/user/sign_out">Sing Out</a>
<!-- 				<div class="dropdown-divider"></div> -->
<!-- 				<a class="dropdown-item" href="#">Something else here</a> -->
			</div>
		</div>
	</div>
</div>
