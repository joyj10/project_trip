<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>동행게시판</title>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
    @import url('resources/css/board.css');
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript">
$(function(){

	//로그인 된 경우 멤버 번호를 브라우저로 부터 받아오는 명령어
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}
	
	var pageNumb = $("#pageNumb").val();
	$("#pageNumA"+pageNumb).addClass("activePage");
	
	function list(data) {
		var arr = eval("("+data+")");
		$.each(arr,function(i,b){
			var a = $("<a></a>").append(b.b_title).attr("href","detailBoard.do?b_no="+b.b_no);
			var tr=$("<tr></tr>");
			var no = $("<td></td>").html(b.b_no);
			var region = $("<td></td>").html(b.b_region);
			var title = $("<td></td>").append(a);
			var mname = $("<td></td>").html(b.m_name);
			var wdate1 = $("<td></td>").append(b.b_startday,$("</br>"),b.b_endday);
			$(tr).append(no,region,title,mname,wdate1);
			$("#tb").append(tr);
		});
	}
	
	//검색 결과 디스플레이 설정
	$("#autocomplete").click(function(){
		$(".nav_search_re").fadeIn(300);
	});
	$(document).click(function(e){ 
 		if(e.target.className =="nav_search_re" || e.target.className =="search_input"|| e.target.className =="search_info"|| e.target.className =="search_list"|| e.target.className =="s_span"){return false} //내가 클릭한 요소(target)를 기준으로 상위요소에 .share-pop이 없으면 (갯수가 0이라면)
 		$(".nav_search_re").stop().fadeOut(300);
 		$("#autocomplete").val("");
 		$(".search_list").html("");
 	});

	//검색 기능 ajax 자동완성
	$("#autocomplete").on("keyup",function(){
		var key = $(this).val();
		if(key!="")
		{
			$(".search_list").html("");
			$(".search_info").css("display","none");
			
			var arr_len=0;
			
			//나라 검색 결과
			$.ajax({
				url:"searchCountry",
				data:{"keyword":key},
				success:function(data){
					var search_arr = eval("("+data+")");
					arr_len += search_arr.length;
					
					$.each(search_arr,function(i,s){
						var a_item = $("<a class='s_a'></a>").attr("href","country/"+s.country_name_eng+"?no="+s.country_no).html(s.country_name_kor+'('+s.country_name_eng+')&nbsp;&nbsp;<div class="s_text">나라</div>');
						var p_item = $("<p class='search_item'></p>").html(a_item);
						$(".search_list").append(p_item);
					});
				}
			});
			
			//도시 검색 결과
			$.ajax({
				url:"searchCity",
				data:{"keyword":key},
				success:function(data){
					var search_arr = eval("("+data+")");
					arr_len=arr_len+search_arr.length;
					
					$.each(search_arr,function(i,s){
						var a_item = $("<a class='s_a'></a>").attr("href","city/"+s.city_name_eng+"?no="+s.city_no).html(s.city_name_kor+'('+s.city_name_eng+')&nbsp;&nbsp;<div class="s_text">도시</div>');
						var p_item = $("<p class='search_item'></p>").html(a_item);
						$(".search_list").append(p_item);
					});
				}
			});
			
			//관광지 검색 결과
			$.ajax({
				url:"searchPV",
				data:{"keyword":key},
				success:function(data){
					var search_arr = eval("("+data+")");
					arr_len=arr_len+search_arr.length;
					
					$.each(search_arr,function(i,s){
						var a_item = $("<a class='s_a'></a>").attr("href","pointview?no="+s.pointview_no).html(s.pointview_name_kor+'&nbsp;&nbsp;<div class="s_text">관광지</div>');
						var p_item = $("<p class='search_item'></p>").html(a_item);
						$(".search_list").append(p_item);
					});
					
					//검색 값 없는 경우 보이는 문구 : 검색 결과가 없습니다.
					if (arr_len==0){
						$(".search_info_not").css("display","block");
					}else{
						$(".search_info_not").css("display","none"); }
				}
			});
			
			
		}else{
			$(".search_list").html("");
			$(".search_info_not").css("display","none");
			$(".search_info").css("display","block");
		}
		
	});
	
});
</script>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/board.css');
</style>
</head>
<body>
<header>
	<a href="#"><button id="top-btn" title="Go to top">Top</button></a>
		<div class="topnav">
	  <div class="logo-top"><a href="indexmain.jsp"><img src="resources/img/logo_top2.png"></a></div>
	  <div class="logo-topM"><a href="indexmain.jsp"><img src="resources/img/logo_top_m.png"></a></div>

	   <form>
	  		<input class="search_input" type="text" name="search" placeholder="Search.." id="autocomplete">
	  		<button class="search-bnt" ><img id="search-img" src="resources/img/search_icon (3).png" ></button>
		</form>
		
	  <div class="topnav-right">
		 <i class="fas fa-bars openbtn" id="menu_icon"></i>
	  </div>
	</div>
	
	<div class="nav_search_re">
		<p class="search_info_not"><i class="far fa-frown" style="font-size: 50px; color:gray;"></i><br><br>검색 결과가 없습니다.</p>
    	<p class="search_info"><i class="fas fa-search" style="font-size: 60px; color:#00b6da;"></i><br><br>흥미로운 여행지를 검색하세요 :D</p>
    	<div class="search_list"></div>
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
	<div class="top-img-sect-b">
		<img alt="" src="resources/img/paris2.jpg"> 
		<div class="img_content">
		<h1>함께 여행 할 친구 찾기</h1>
		<button type="button" class="top-bnt-b" onclick="location.href = 'insertBoard.do'"><span>Write</span></button>
		</div>
	</div>
	<br>
	<div class="center">
		<table class="board-table">
			<tr class="table_top">
			<td class="table_no">번호</td>			
			<td>여행기간</td>
			<td>지역</td>
			<td>제목</td>
			<td class="table_name">작성자</td>
			<td class="table_hit">조회수</td>
			</tr>
			<tbody id="tb">
				<c:forEach var="b" items="${list }">
					<tr>
						<td class="table_no">${b.b_no }</td>					
						<td class="table_date">${b.b_startday } ~<br>${b.b_endday }</td>
						<td>${b.b_region }</td>
						<td><a href="detailBoard.do?b_no=${b.b_no }">${b.b_title }</a></td>
						<td class="table_name">${b.m_name }</td>
						<td class="table_hit">${b.b_hit }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<div class="pagination">
		<span>
		<input type="hidden" value="${pageNumber}" id="pageNumb">
			<c:if test="${start > pageSize}" >
				<a href="listBoard.do?pageNum=${start-1}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${start }" end="${end }">
				<a href="listBoard.do?pageNum=${i }&keyword=${keyword}&item=${item}" id="pageNumA${i }">${i }</a>&nbsp;
			</c:forEach>	
			<c:if test="${end < totalPage}">
				<a href="listBoard.do?pageNum=${end+1}" >&raquo;</a>
			</c:if>
			</span>
		</div>
		<div class="right">
			<form class="search-board" action="listBoard.do" method="post">
				<input type="submit" value="검색" id="btn_search">
				<input type="search" placeholder="Search.." name="keyword" id="keyword">
				<select class="form-control" name="item" id="item">
					<option value="b_title">제목</option>
					<option value="m_name">작성자</option>
					<option value="b_region">여행지</option>
				</select>
				</form>
			</div>
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