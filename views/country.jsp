<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나라</title>
<style type="text/css">
    @import url('../resources/css/headerFooter.css');
    @import url('../resources/css/main.css');
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="../resources/js/headerFooter.js"></script>
<script type="text/javascript" src="../resources/js/main.js"></script>
<script type="text/javascript">


$(function() {
	

	//변수 선언
	var country_no = ${country.country_no};
	var pointviewList;
	
	
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}
	
	//해당 나라에 속한 도시 리스트 ajax
	$.ajax({
		url:"../cityInCountryList.do",
		data:{no:country_no},
		success:function(data){
			var cityArr = eval("("+data+")");
			
			$.each(cityArr, function(i,c) {
				
				var city = $("<div></div>").addClass("city").append( 
						$("<img>").attr("src","../resources/image/"+c.city_image2),
						$("<h3></h3>").html(c.city_name_kor),
						$("<p></p>").addClass("city-text").html(c.city_topinfo)
					);
				
				var aCity = $("<a></a>").attr("href","../city/"+c.city_name_eng+"?no="+c.city_no).html(city);
				$(".recommend-wrapper-two").append(aCity);
			});
		}
	});
	
	
	//회원 좋아요 리스트 담는 변수
	var likeArr;
	//로그인 상태인 경우 해당 회원의 좋아요 리스트 가져오기
	if(mno>0)
	{
		$.ajax({
			url:"../likeNumberListMember.do",
			data:{m_no:mno},
			success:function(data){
				likeArr = eval("("+data+")");
			}			
		});
	}
	
	//관광지 리스트 
	$.ajax({
			url:"../pointviewListInCountry.do",
			data:{country_no:country_no},
			success:function(data){
				
				pointviewList= eval("("+data+")");
				
				var i =0;
				var pvViewCnt = 30;
				var endi = i+pvViewCnt;
				
				//처음 관광지 리스트 보이기
				for(i ; i<endi ; i++)
				{
					var pv_figure = $("<div></div>").addClass("card-figure").append(
							$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<img>").attr("src","../resources/image/"+pointviewList[i].pointview_image1)),
							$("<div class='card-content'></div>").append(
									$("<i></i>").addClass("far fa-heart").addClass("pvY"+pointviewList[i].pointview_no).addClass("heart_btn_list").attr("idx",i),
									$("<i></i>").addClass("fas fa-heart").addClass("pvN"+pointviewList[i].pointview_no).addClass("heart_btn_fill_list").css("display","none").attr("idx",i),
									$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("viewname").html(pointviewList[i].pointview_name_kor)),
									$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("text").html(pointviewList[i].pointview_topinfo)),
									$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("hashtag").html(pointviewList[i].pointview_hashtag))
								)
							);
					
					$(".card-column").append(pv_figure);
					
					if(mno>0){
						$.each(likeArr, function(i,pvn) {
							var heartBtn = ".pvY"+pvn;
							var heartBtnFill = ".pvN"+pvn;
							
							if($(heartBtn)!=null){
								$(heartBtn).css("display","none");
					            $(heartBtnFill).css("display","inline-block");
							}
						});
					}
				}
				
				//무한스크롤 적용
				$(window).scroll(function() {
					var scrollHeight = $(window).scrollTop() + $(window).height();
					var documentHeight = $(document).height();
					
					
					if( scrollHeight+100 >= documentHeight )
					{
						if(endi >= pointviewList.length){
							endi = pointviewList.length;
						}else {
							endi = i+pvViewCnt;
						}
						
						for(i ; i<endi ; i++)
						{
							var pv_figure = $("<div></div>").addClass("card-figure").append(
									$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<img>").attr("src","../resources/image/"+pointviewList[i].pointview_image1)),
									$("<div class='card-content'></div>").append(
											$("<i></i>").addClass("far fa-heart").addClass("pvY"+pointviewList[i].pointview_no).addClass("heart_btn_list").attr("idx",i),
											$("<i></i>").addClass("fas fa-heart").addClass("pvN"+pointviewList[i].pointview_no).addClass("heart_btn_fill_list").css("display","none").attr("idx",i),
											$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("viewname").html(pointviewList[i].pointview_name_kor)),
											$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("text").html(pointviewList[i].pointview_topinfo)),
											$("<a></a>").attr("href","../pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("hashtag").html(pointviewList[i].pointview_hashtag))
										)
									);
							
							$(".card-column").append(pv_figure);
							
							if(mno>0){
								$.each(likeArr, function(i,pvn) {
									var heartBtn = ".pvY"+pvn;
									var heartBtnFill = ".pvN"+pvn;
									
									if($(heartBtn)!=null){
										$(heartBtn).css("display","none");
							            $(heartBtnFill).css("display","inline-block");
									}
								});
							}
						}
					}
				});
				
		}});

	
	//관광지 리스트 좋아요 버튼 기능 
	if(mno>0)
	{
		$(document).on("click",".heart_btn_list",function(){ 
			
			var idx = $(this).attr("idx");
			
			var pvno = pointviewList[idx].pointview_no;
			var name = pointviewList[idx].pointview_name_kor;
			var topinfo = pointviewList[idx].pointview_topinfo;
			var hashtag = pointviewList[idx].pointview_hashtag;
			var addr = pointviewList[idx].pointview_addr;
			var img = pointviewList[idx].pointview_image1;
			var eng = pointviewList[idx].pointview_name_eng;
			var city_no = pointviewList[idx].city_no;
			var map_x = pointviewList[idx].pointview_location_X;
			var map_y = pointviewList[idx].pointview_location_Y;
			
			
			
			$.ajax({
				url:"../likeBtnInsert.do",
				type:"POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data:{ m_no:mno,pointview_no:pvno , pointview_name:name , pointview_topinfo:topinfo , pointview_hashtag:hashtag , pointview_addr:addr , pointview_image1:img , pointview_name_eng:eng, city_no:city_no, pointview_location_X:map_x, pointview_location_Y:map_y },
				success:function(data){
					if(data>0)
					{
						/*좋아요 리스트 팝업(좋아요 성공)*/
						$("#like_success").css("display","inline");
						$("#like_cancel").css("display","nono");
						$("#like_popup").removeClass("cancel");
						$("#like_popup").addClass("show");
						setTimeout(function(){
							$("#like_popup").removeClass("show");
							$("#like_success").css("display","none");
						},1000);
						
						
						$(".pvY"+pvno).css("display","none");
						$(".pvN"+pvno).css("display","inline-block");
					}
				}
			});
			
			
		});
		
		$(document).on("click",".heart_btn_fill_list",function() {
			var idx = $(this).attr("idx");
			var pvno = pointviewList[idx].pointview_no;
			
			
			$.ajax({
				url:"../likeBtnDelete.do",
				type:"POST",
				data:{m_no:mno,pointview_no:pvno},
				success:function(data){
					if(data>0)
					{
						/*좋아요 리스트 팝업(좋아요 취소)*/
						$("#like_success").css("display","none");
						$("#like_cancel").css("display","inline");
						$("#like_popup").addClass("show").addClass("cancel");
						setTimeout(function(){
							$("#like_popup").removeClass("show");
							$("#like_cancel").css("display","none");
						},1000);
						
						$(".pvY"+pvno).css("display","inline-block");
						$(".pvN"+pvno).css("display","none");
					}
				}
			});
		});	
	}else {
		$(document).on("click",".heart_btn_list",function(){
			alert("로그인 후 사용 가능 한 기능입니다.");
		});
	}
	
	
	//이미지 가져오기 : 자바스크립트
	var img_arr = new Array();
	if ($("#img1").val() != ""){
		img_arr[0] = $("#img1").val();	}
	if ($("#img2").val() != ""){
		img_arr[1] = $("#img2").val();	}
	if ($("#img3").val() != ""){
		img_arr[2] = $("#img3").val();	}
	if ($("#img4").val() != ""){
		img_arr[3] = $("#img4").val();	}
	
	var img_num = img_arr.length;
	
	//아래 이미지 클릭 시 이미지 변경
	var dot_con = $("<div class='dot_container'></div>");
	for (var i=0 ; i<img_num ; i++){
		var dot = $("<span class='dot'></span>").attr("data-idx",i).attr("id","dot-"+i);
		$(dot_con).append(dot);
	}
	$(".pv_small_img").append(dot_con);
	
	$("#dot-0").addClass("dotAtive");
	
	$(document).on("click",".dot",function(){
		$(".dot").removeClass("dotAtive");
		var dot_idx = $(this).attr("data-idx");
		$(".img_slide").attr("src","../resources/image/"+img_arr[dot_idx]);
		$("#dot-"+dot_idx).addClass("dotAtive");
	});
	
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
				url:"../searchCountry",
				data:{"keyword":key},
				success:function(data){
					var search_arr = eval("("+data+")");
					arr_len += search_arr.length;
					
					$.each(search_arr,function(i,s){
						var a_item = $("<a class='s_a'></a>").attr("href","../country/"+s.country_name_eng+"?no="+s.country_no).html(s.country_name_kor+'('+s.country_name_eng+')&nbsp;&nbsp;<div class="s_text">나라</div>');
						var p_item = $("<p class='search_item'></p>").html(a_item);
						$(".search_list").append(p_item);
					});
				}
			});
			
			//도시 검색 결과
			$.ajax({
				url:"../searchCity",
				data:{"keyword":key},
				success:function(data){
					var search_arr = eval("("+data+")");
					arr_len=arr_len+search_arr.length;
					
					$.each(search_arr,function(i,s){
						var a_item = $("<a class='s_a'></a>").attr("href","../city/"+s.city_name_eng+"?no="+s.city_no).html(s.city_name_kor+'('+s.city_name_eng+')&nbsp;&nbsp;<div class="s_text">도시</div>');
						var p_item = $("<p class='search_item'></p>").html(a_item);
						$(".search_list").append(p_item);
					});
				}
			});
			
			//관광지 검색 결과
			$.ajax({
				url:"../searchPV",
				data:{"keyword":key},
				success:function(data){
					var search_arr = eval("("+data+")");
					arr_len=arr_len+search_arr.length;
					
					$.each(search_arr,function(i,s){
						var a_item = $("<a class='s_a'></a>").attr("href","../pointview?no="+s.pointview_no).html(s.pointview_name_kor+'&nbsp;&nbsp;<div class="s_text">관광지</div>');
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




/*
스크롤 없이 전체 관광지 뿌리는 스크립트
 $.each(pvList,function(i,p){
		var pv = $("<div></div>").addClass("card-figure").append(
			$("<img>").attr("src","../resources/image/"+p.pointview_image1),
			$("<div></div>").addClass("card-content").append(
				$("<img>").addClass("like").attr("src","../resources/img/heart.png"),
				$("<div></div>").addClass("viewname").html(p.pointview_name_kor),
				$("<div></div>").addClass("text").html(p.pointview_topinfo),
				$("<div></div>").addClass("hashtag").html(p.pointview_hashtag)
			)						
		);
		var aPv = $("<a></a>").attr("href","../pointview?no="+p.pointview_no).html(pv);
		$(".card-column").append(aPv);
	});	
				
 */
</script>
</head>	

<body>
<header>
	<button onclick="topFunction()" id="top-bnt" title="Go to top">Top</button>
	<div class="topnav">
	  <div class="logo-top"><a href="../indexmain.jsp"><img src="../resources/img/logo_top2.png"></a></div>
	  <div class="logo-topM"><a href="../indexmain.jsp"><img src="../resources/img/logo_top_m.png"></a></div>

	  	<input class="search_input" type="text" name="search" placeholder="Search.." id="autocomplete">
	  	<button class="search-bnt" ><img id="search-img" src="../resources/img/search_icon (3).png" ></button>

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
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	  <a class="s-a" href="../indexmain.jsp#recommend-sec">추천 여행지</a>
	  <a class="s-a" href="javascript:void(0)">여행 일정 계획</a>
	  <a class="s-a" href="javascript:void(0)o">동행게시판</a>
	  <br>
	  	<div class="before-login">
		  <a href="#"><input type="button" class="sidepanel-bnt" value="로그인"></a>
		  <a href="#"><input type="button" class="sidepanel-bnt" value="회원가입"></a>
	  	</div>
	  	<div class="after-login">
	  		<hr id="login-hr">
	  		<a class="s-a" href="../mypage.jsp">마이페이지</a>
	  		<a class="s-a" href="../mypage.jsp#myL">좋아요 목록</a>
		    <a href="#"><input class="sidepanel-bnt logout" type="button"value="로그아웃"></a>
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
	<div class="top-img-sect">
		<img alt="" src="../resources/image/${country.country_image2}"> 
		<div class="img_content">
			<h1>${country.country_name_kor}(${country.country_name_eng})</h1>
			<p>${country.country_topinfo}</p>
		</div>
	</div>
	
	<div class="center">
		<div class="view-info">
			<div class="top-content">
				<div class="info-title">${country.country_name_eng} Info</div>
				<hr>
				<div class="content">
					<div class="box">
						<div class="vinfo-title"><i class="fas fa-language" > 언어</i></div>
						<div class="vinfo-text">${country.country_language}</div>
					</div>
					<div class="box">
						<div class="vinfo-title"><i class="far fa-money-bill-alt" > 환율</i></div>
						<div class="vinfo-text">${country.country_money}</div>
					</div>
					<div class="box">
						<div class="vinfo-title"><i class="fas fa-archway" > Detail</i></div>
						<div class="vinfo-text">${country.country_info} </div>
					</div>
				</div>
			</div>
			<div class="pv_small_img">
				<input type="hidden" id="img1" value="${country.country_image1}">
				<input type="hidden" id="img2" value="${country.country_image2}">
				<input type="hidden" id="img3" value="${country.country_image3}">
				<input type="hidden" id="img4" value="${country.country_image4}">
				<img class="img_slide" alt="" src="../resources/image/${country.country_image1}">
			</div>
		</div>
	</div>
	
	
	<div class="center">
		<div class="recommend-sec">
			<h2 class="country-cityname">도시</h2>
			<div class="recommend-wrapper-two" >
			</div>
		</div>		
	</div>
	
	<div id="backColor-round"></div>
	<div id="backColor-box">
		<div class="center">
		<h2>${country.country_name_kor} : 관광지</h2> 
		<div class="card-list">
			<div class="card-column"></div>
		</div>
		</div>
	</div>
	
	<!-- 좋아요 레이어 팝업 -->
	<div id="like_popup">
		<i class="fas fa-heart" id="like_icon">
			<div id="like_text">좋아요 <span id="like_success">성공!</span><span id="like_cancel">취소</span></div>
			<!--<div id="like_info">마이페이지 > 좋아요 확인</div> -->
		</i>
	</div>
</section>

<footer>
	<div class="footer-center">
		<div class="menu-footer">
			<div class="list-footer">
				<ul>
					<li>탐색</li>
					<li><a href="../indexmain.jsp#recommend-sec">추천 여행지</a></li>
					<li><a href="../indexmain.jsp#trip_recom">여행지 순위</a></li>
					<li><a href="javascript:void(0)">About @Trip </a></li>
				</ul>
			</div>
			<div class="list-footer">
				<ul>
					<li>계획</li>
					<li><a href="../plan.do">여행 동선 계획</a></li>
					<li><a href="../listBoard.do">동행 찾기</a></li>
				</ul>
			</div>
		</div>
		<img class="logo-footer" src="../resources/img/logo.png">
		<p>Copyright ⓒ 2019 @trip</p>
		<p>KKH ㅣ KDH ㅣ LPS ㅣ JYM</p>
	</div>
</footer>

</body>
</html>