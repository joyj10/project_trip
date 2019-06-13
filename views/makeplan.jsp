<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>@Trip : 일정만들기</title>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
    @import url('resources/css/main.css');
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript">

$(function() {
	
	//로그인 된 경우 멤버 번호를 브라우저로 부터 받아오는 명령어
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}
	
	// 추후 변경 필요
	if(mno == null || mno == 0){
		window.history.back(-1);
	}
	$("#m_no_input").val(mno);
	
	
})
function validateForm() {
  var name = document.forms["myForm"]["plan_name"].value;
  var city_no = document.forms["myForm"]["city_no"].value;
  var startday = document.forms["myForm"]["plan_startday"].value;
  var endday = document.forms["myForm"]["plan_endday"].value;

  if (name == "") {
    alert("일정이름을 입력해 주세요");
    return false;
  } else if (city_no == '여행지'){
	 alert("여행 도시를 입력해 주세요");
	  return false;
  } else if (startday == ""){
		 alert("시작일을 입력해 주세요");
		  return false;
  }  else if (endday == ""){
		 alert("종료일을 입력해 주세요");
		  return false;
  }
}
</script>
</head>
<body style="background: url('resources/img/img_makeplan.jpg'); width:100%;height:950px;background-size:cover;background-position:center;">
<header>
	<a href="#"><button id="top-btn" title="Go to top">Top</button></a>
		<div class="topnav">
	  <div class="logo-top"><a href="indexmain.jsp"><img src="resources/img/logo_top2.png"></a></div>
	  <div class="logo-topM"><a href="indexmain.jsp"><img src="resources/img/logo_top_m.png"></a></div>

	   <form>
	  		<input class="search_input" type="text" name="search" placeholder="Search..">
	  		<button type="submit" class="search-bnt" ><img id="search-img" src="resources/img/search_icon (3).png" ></button>
		</form>
	  <div class="topnav-right">
		 <i class="fas fa-bars openbtn" id="menu_icon"></i>
	  </div>
	</div>
	
	<div id="mySidepanel" class="sidepanel">
	  <a href="javascript:void(0)" class="closebtn">×</a>
	  <a class="s-a" href="indexmain.jsp#recommend-sec">추천 여행지</a>
	  <a class="s-a" href="plan.do">여행 일정 계획</a>
	  <a class="s-a" href="listBoard.do">동행게시판</a>
	  <br>
	  	<div class="before-login">
		  <a><input type="button" class="sidepanel-bnt" id="btn_login" value="로그인"></a>
		  <a href="join.do"><input type="button" class="sidepanel-bnt" value="회원가입"></a>
	  	</div>
	  	<div class="after-login">
	  		<hr id="login-hr">
	  		<<a class="s-a" href="mypage.jsp">마이페이지</a>
	  		<a class="s-a" href="mypage.jsp#myL">좋아요 목록</a>
		    <a><input type="button" class="sidepanel-bnt logout" id="btn_logout" value="로그아웃"></a>
	  	</div>
	  <br>
	</div>
</header>
<section>
	<div class="join-content" id="make-plan-form">
		<form name="myForm" action="planline.do" style="border:1px solid #ccc" method="post" onsubmit="return validateForm()">
		  <div class="container">
		    <h1>일정만들기</h1>
		    <p>여행의 정보를 입력해 주세요:D</p>
		    <hr>
		    <label for="email"><b>일정이름</b></label>
		    <input type="text" placeholder="일정이름을 입력하세요" name="plan_name" >
		    <input type="hidden"  name="city_name"  value="${g.getCity_name_kor() }">
		    <input type="hidden"  name="m_no" id="m_no_input" >
		    
		    <label for="psw"><b>여행 도시</b></label>
		    <select class="plan-select" name="city_no" >
	       		<option> 여행지 </option>
            	<c:forEach var="g" items="${m }">
            	<option value="${g.getCity_no() }">  ${g.getCity_name_kor() } </option>
            	</c:forEach>
	        </select>
	        <label for="psw"><b>여행 출발일</b></label>
		    <input type="date" name="plan_startday" min="2019-04-28">
		    <label for="psw"><b>여행 종료일</b></label>
            <input type="date" name="plan_endday" min="2019-04-28">
		    
		    
		    <div class="clearfix">
		    	<form action="#" method="post">
			      <input type="reset" class="cancelbtn" value="지우기">
			      <input type="submit" class="signupbtn" value="만들기">
		    	</form>
		    </div>
		  </div>
		</form>
	</div>
</section>
<footer>
	<div class="footer-center">
		<div class="menu-footer">
			<div class="list-footer">
				<ul>
					<li>탐색</li>
					<li><a href="indexmain.jsp#recommend-sec">추천 여행지</a></li>
					<li><a href="indexmain.jsp#trip_recom">여행지 순위</a></li>
					<li><a href="javascript:void(0)">About @Trip </a></li>
				</ul>
			</div>
			<div class="list-footer">
				<ul>
					<li>계획</li>
					<li><a href="plan.do">여행 동선 계획</a></li>
					<li><a href="listBoard.do">동행 찾기</a></li>
				</ul>
			</div>
		</div>
		<img class="logo-footer" src="resources/img/logo.png">
		<p>Copyright ⓒ 2019 @trip</p>
		<p>KKH ㅣ KDH ㅣ LPS ㅣ JYM</p>
	</div>
</footer>
</body>
</html>