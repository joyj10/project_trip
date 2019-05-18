<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>@Trip Main</title>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
    @import url('resources/css/mainHeader.css');
    @import url('resources/css/board.css');
    @import url('resources/css/main_banner_style.css');
    @use postcss-color-function;
	@use postcss-nested;
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="resources/js/mainHeader.js"></script>
<script type="text/javascript">

$(function() {
	var cityArr;
	var cityCnt;
	var cityGridCnt;
	var mnoA;
	
	
	/*로그인 여부 체크*/
	var url = window.location.search.substring(1);
	if(url.indexOf("m_no=")>=0){
		login_mno = url.split("m_no=")[1];
		if(window.sessionStorage){
			window.sessionStorage.setItem("m_no",login_mno);
		}
	}
	
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}
	
	if(mno>0){
		$(".before-login").css("display","none");
		$(".after-login").css("display","block");
		mnoA= mno;
	}else{
		$(".before-login").css("display","block");
		$(".after-login").css("display","none");
	}
	
	
	
	/*도시 리스트 ajax 영역*/
	
	$.ajax({
		url:"cityList.do",
		data:{m_no:mnoA},
		success:function(data){
		
		cityArr = eval("("+data+")");
		cityCnt = cityArr.length;
		
			/*메인페이지 추천 도시 노드 생성*/
			for(var i=0; i<8; i++)
			{
				
				var city = $("<div></div>").addClass("city").append( 
					$("<img>").attr("src","resources/image/"+cityArr[i].city_image2),
					$("<h3></h3>").html(cityArr[i].city_name_kor),
					$("<p></p>").addClass("city-text").html(cityArr[i].city_topinfo)
				);
				
				var aCity = $("<a></a>").attr("href","city/"+cityArr[i].city_name_eng+"?no="+cityArr[i].city_no).html(city);
				$(".recommend-wrapper").append(aCity);
			}
			
		}});
		
		
		$.ajax({
			url:"cityList.do",
			data:{m_no:""},
			success:function(data){
			
			cityArr1 = eval("("+data+")");
			cityCnt = cityArr1.length;
			
			for(var i=0 ; i<cityCnt ; i++)
			{
				var cityGird = $("<div></div>").addClass("city-item").attr("data-gooddate",cityArr1[i].city_gooddate_number);
				
				var gooddateArr = cityArr1[i].city_gooddate_number.split(";");
				$.each(gooddateArr,function(i,m){
					cityGird.addClass("month"+m);
				});
				
				var img = $("<img>").addClass("city-item-img").attr("src","resources/image/"+cityArr1[i].city_image1);
				var cityName = $("<div></div>").addClass("cityname").append( $("<div></div>").html(cityArr1[i].city_name_kor));
				var cityLike = $("<div></div>").addClass("like").append(
						$("<i></i>").addClass("far fa-thumbs-up").css({"font-size":"20px","color":"white"}),
						"&nbsp;"+cityArr1[i].city_liketot );
				
				$(cityGird).append(img,cityName,cityLike);
					
				var aCity = $("<a></a>").attr("href","city/"+cityArr1[i].city_name_eng+"?no="+cityArr1[i].city_no).html(cityGird);
			
				$(".grid-container").append(aCity);
			}
		

		$(".month-btn").click(function() {
			var month = Number($(this).attr('data-month'));
			
			var monthArr = [1,2,3,4,5,6,7,8,9,10,11,12];
			if(month!=0){
				$(".city-item").fadeOut(500);
				for(var i=0 ; i<12 ; i++)
				{
					var selectMonth = ".month"+monthArr[i];
					
					if(monthArr[i]==month){
						$(selectMonth).fadeIn(100);
					}
				}
				
			}else{
				$(".city-item").fadeIn(100);
			}
		});
	}});
	
	
	
	//검색 결과 디스플레이 설정
	$("#autocomplete").click(function(){
		$(".search_result").fadeIn(300);
	});
	$(document).click(function(e){ 
 		if(e.target.className =="search_result" || e.target.className =="search-input"|| e.target.className =="search_info"|| e.target.className =="search_list"|| e.target.className =="s_span"){return false} //내가 클릭한 요소(target)를 기준으로 상위요소에 .share-pop이 없으면 (갯수가 0이라면)
 		$(".search_result").stop().fadeOut(300);
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

</head>

<body>
<header style="margin-bottom: -30px">
	<a href="#"><button id="top-btn" title="Go to top">Top</button></a>
	<div class="header-img">
	  <img id="logo" src=resources/img/logo_top2.png>
	  <img id="top-main-img" src="resources/img/main_maldive.jpg"> 
	  <div class="search-container">
		<p class="search-title">
        	더 쉬운 여행, 더 즐거운 @Trip
    	</p>
    	<input class="search-input" type="text" id="autocomplete" placeholder="Search...">
    	<div class="search_result">
    		<p class="search_info_not"><i class="far fa-frown" style="font-size: 50px; color:gray;"></i><br><br>검색 결과가 없습니다.</p>
    		<p class="search_info"><i class="fas fa-search" style="font-size: 60px; color:#00b6da;"></i><br><br>흥미로운 여행지를 검색하세요 :D</p>
    		<div class="search_list"></div>
    	</div>
	  </div>
	</div>
	
	<div id="navbar">
		<div class="main-logo-top"><a href="#"><img src="resources/img/logo_top_m.png"></a></div>
  		<a class="menu-a" href="#trip_recom">여행지추천</a>
  		<a class="menu-a" href="plan.do">여행일정</a>
  		<a class="menu-a" href="listBoard.do">동행찾기</a>
  		<div class="topnav-right">
			<i class="fas fa-bars openbtn" id="menu_icon"></i>
	 	</div>
	</div>

	
	<div id="mySidepanel" class="sidepanel">
	  <a href="javascript:void(0)" class="closebtn">×</a>
	  	<div class="before-login">
		  <a><input type="button" class="sidepanel-bnt" id="btn_login" value="로그인"></a>
		  <a href="join.do"><input type="button" class="sidepanel-bnt" value="회원가입"></a>
	  	</div>
	  	<div class="after-login">
	  		<a class="s-a" href="mypage.jsp">마이페이지</a>
	  		<a class="s-a" href="mypage.jsp#myL">좋아요 목록</a>
		    <a><input type="button" class="sidepanel-bnt logout" id="btn_logout" value="로그아웃"></a>
	  	</div>
	  <br>
	  <!-- 
	  <p>최근 본 목록</p>
		  <div class=row>
			<div class="recent-col">
		  		<img src="img/sunrise.jpg">
		  		<span>이탈리아 피렌체</span>
			</div>
			<div class="recent-col">
		  		<img src="img/beach.jpg">
		  		<span>베트남 나트랑</span>
			</div>
		  </div>
		  <div class=row>
		     <div class="recent-col">
		  		<img src="img/beach2.jpg">
		  		<span>일본 오키나와</span>
			 </div>
			 <div class="recent-col">
		  		<img src="img/airballoon.jpg">
		  		<span>체코 프라하</span>
			 </div>
		  </div>
	</div>
	 -->

</header>

<section>
<div class="center">
	<div id="recommend-sec" style="padding-top: 50px;">
		<h2>@Trip 추천 여행지</h2>
		<div class="recommend-wrapper"></div>
	</div>
</div>

	<div class="center" style="margin-top:-30px; margin-bottom:-60px;">
		<!-- 중간 나라 배너 -->
	<h2>@Trip 추천 여행 나라</h2>
	</div>
	<div class="cont s--inactive">
	  <!-- cont inner start -->
	  <div class="cont__inner">
	    <!-- el start -->
	    <div class="el">
	      <div class="el__overflow">
	        <div class="el__inner">
	          <div class="el__bg"><img src="resources/image/country_japan4.jpg"></div>
	          <div class="el__preview-cont">
	            <h2 class="el__heading">Japan</h2>
	          </div>
	          	<div class="el__content">
	          	<a href="country/japan?no=1" style="text-decoration: none;cursor: pointer;">
		            <div class="el__text">
		            	<strong>일본 Japan</strong><br>
		            	<p>봄에 여행가기 좋은 나라<p>
		            	<button class="top-bnt-b" style="width: 150px; margin-top:40px;">Go to Japan</button>
		            </div>
	            </a>
	            <div class="el__close-btn"></div>
	          </div>
	        </div>
	      </div>
	      <div class="el__index">
	        <div class="el__index-back">1</div>
	        <div class="el__index-front">
	          <div class="el__index-overlay" data-index="1">1</div>
	        </div>
	      </div>
	    </div>
	    <!-- el end -->
	    <!-- el start -->
	    <div class="el">
	      <div class="el__overflow">
	        <div class="el__inner">
	          <div class="el__bg"><img src="resources/image/country_europe2.jpg"></div>
	          <div class="el__preview-cont">
	            <h2 class="el__heading">Europe</h2>
	          </div>
	          <div class="el__content">
	            <a href="country/europe?no=9" style="text-decoration: none;cursor: pointer;">
		            <div class="el__text">
		            	<strong>유럽 Europe</strong><br>
		            	<p>이름만으로 설레는 곳<p>
		            	<button class="top-bnt-b" style="width: 150px; margin-top:40px;">Go to Europe</button>
		            </div>
	            </a>
	            <div class="el__close-btn"></div>
	          </div>
	        </div>
	      </div>
	      <div class="el__index">
	        <div class="el__index-back">2</div>
	        <div class="el__index-front">
	          <div class="el__index-overlay" data-index="2">2</div>
	        </div>
	      </div>
	    </div>
	    <!-- el end -->
	    <!-- el start -->
	    <div class="el">
	      <div class="el__overflow">
	        <div class="el__inner">
	          <div class="el__bg"><img src="resources/image/country_vietnam5.jpg"></div>
	          <div class="el__preview-cont">
	            <h2 class="el__heading">vietnam</h2>
	          </div>
	          <div class="el__content">
	            <a href="country/vietnam?no=8" style="text-decoration: none;cursor: pointer;">
		            <div class="el__text">
		            	<strong>베트남 Vietnam</strong><br>
		            	<p>저렴한 물가와 맛있는 음식이 가득한 나라<p>
		            	<button class="top-bnt-b" style="width: 150px; margin-top:40px;">Go to Vietnam</button>
		            </div>
	            </a>
	            <div class="el__close-btn"></div>
	          </div>
	        </div>
	      </div>
	      <div class="el__index">
	        <div class="el__index-back">3</div>
	        <div class="el__index-front">
	          <div class="el__index-overlay" data-index="3">3</div>
	        </div>
	      </div>
	    </div>
	    <!-- el end -->
	    <!-- el start -->
	    <div class="el">
	      <div class="el__overflow">
	        <div class="el__inner">
	          <div class="el__bg"><img src="resources/image/country_thailand5.jpg"></div>
	          <div class="el__preview-cont">
	            <h2 class="el__heading">Thailand</h2>
	          </div>
	          <div class="el__content">
	            <a href="country/thailand?no=5" style="text-decoration: none;cursor: pointer;">
		            <div class="el__text">
		            	<strong>태국 Thailand</strong><br>
		            	<p>배낭여행의 성지! 해양스포츠를 즐기기 좋은 나라<p>
		            	<button class="top-bnt-b" style="width: 150px; margin-top:40px;">Go to Thailand</button>
		            </div>
	            </a>
	            <div class="el__close-btn"></div>
	          </div>
	        </div>
	      </div>
	      <div class="el__index">
	        <div class="el__index-back">4</div>
	        <div class="el__index-front">
	          <div class="el__index-overlay" data-index="4">4</div>
	        </div>
	      </div>
	    </div>
	    <!-- el end -->
	    <!-- el start -->
	    <div class="el">
	      <div class="el__overflow">
	        <div class="el__inner">
	          <div class="el__bg"><img src="resources/image/country_usa5.jpg"></div>
	          <div class="el__preview-cont">
	            <h2 class="el__heading">U.S.A.</h2>
	          </div>
	          <div class="el__content">
	            <a href="country/usa?no=10" style="text-decoration: none;cursor: pointer;">
		            <div class="el__text">
		            	<strong>미국 U.S.A.</strong><br>
		            	<p>자유의 나라로 떠나자!<p>
		            	<button class="top-bnt-b" style="width: 150px; margin-top:40px;">Go to U.S.A.</button>
		            </div>
	            </a>
	            <div class="el__close-btn"></div>
	          </div>
	        </div>
	      </div>
	      <div class="el__index">
	        <div class="el__index-back">5</div>
	        <div class="el__index-front">
	          <div class="el__index-overlay" data-index="5">5</div>
	        </div>
	      </div>
	    </div>
	    <!-- el end -->
	  </div>
	  <!-- cont inner end -->
	</div>

	
	
<div class="center" id="trip_recom" style="padding-top: 90px;">		
	<h2>@Trip 인기 여행지 순위</h2>
	<div class="month">
		<button class="month-btn" data-month=0>전체</button>
		<button class="month-btn" data-month=1>1월</button>
		<button class="month-btn" data-month=2>2월</button>
		<button class="month-btn" data-month=3>3월</button>
		<button class="month-btn" data-month=4>4월</button>
		<button class="month-btn" data-month=5>5월</button>
		<button class="month-btn" data-month=6>6월</button>
		<button class="month-btn" data-month=7>7월</button>
		<button class="month-btn" data-month=8>8월</button>
		<button class="month-btn" data-month=9>9월</button>
		<button class="month-btn" data-month=10>10월</button>
		<button class="month-btn" data-month=11>11월</button>
		<button class="month-btn" data-month=12>12월</button>
	</div>
	<div class="city-rank">		 
		<div class="grid-container">
		</div>
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
<!-- 메인 중간 배너 스크립트 -->
<script type="text/javascript" src="resources/js/main_banner_index.js"></script>
</body>
</html>

