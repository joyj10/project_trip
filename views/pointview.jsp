<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>@Trip 관광지</title>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript">
$(function() {

	var city_no = ${pv.city_no}; 
	var pvno = ${pv.pointview_no};
	var pointviewList;
	
	
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}
	
	
	//이미지 가져오기 : 자바스크립트
	var img_arr = new Array();
	if ($("#img1").val() !="no_img.jpg" ){
		img_arr[0] = $("#img1").val();	}
	if ($("#img2").val() != "no_img.jpg"){
		img_arr[1] = $("#img2").val();	}
	if ($("#img3").val() != "no_img.jpg"){
		img_arr[2] = $("#img3").val();	}
	if ($("#img4").val() != "no_img.jpg"){
		img_arr[3] = $("#img4").val();	}
	
	
	var img_num = img_arr.length;
	
	var curr_dot;
	
	//이미지 추가(여러 장인 경우 2번째 이미지 부터 보이기)
	if(img_num==1){
		var img_node = $("<img class='img_slide'>").attr("src","resources/image/"+img_arr[0]);
		$(".pv_small_img").append(img_node);
		curr_dot=0;
		
	}else{
		var img_node = $("<img class='img_slide'>").attr("src","resources/image/"+img_arr[1]);
		$(".pv_small_img").append(img_node);
		curr_dot=1;
	}
	
	
	//아래 이미지 클릭 시 이미지 변경
	var dot_con = $("<div class='dot_container'></div>");
	for (var i=0 ; i<img_num ; i++){
		var dot = $("<span class='dot'></span>").attr("data-idx",i).attr("id","dot-"+i);
		$(dot_con).append(dot);
	}
	$(".pv_small_img").append(dot_con);
	
	$("#dot-"+curr_dot).addClass("dotAtive");
	
	$(document).on("click",".dot",function(){ 
		$(".dot").removeClass("dotAtive");
		var dot_idx = $(this).attr("data-idx");
		$(".img_slide").attr("src","resources/image/"+img_arr[dot_idx]);
		$("#dot-"+dot_idx).addClass("dotAtive");
	});
	
	
	//회원 좋아요 리스트 담는 변수
	var likeArr;
	//로그인 상태인 경우 해당 회원의 좋아요 리스트 가져오기
	if(mno>0)
	{
		$.ajax({
			url:"likeNumberListMember.do",
			data:{m_no:mno},
			success:function(data){
				likeArr = eval("("+data+")");
				
				$.each(likeArr,function(i,l){
					if(l==pvno){
						$("#heart-btn").css("display","none");
						$("#heart-btn-fill").css("display","block");
					}
				});
			}			
		});
	}
	
	//관광지 리스트 
	$.ajax({
			url:"pointviewList.do",
			data:{no:city_no},
			success:function(data){
				
				pointviewList= eval("("+data+")");
				
				var i =0;
				var pvViewCnt = 30;
				var endi = i+pvViewCnt;
				
				//처음 관광지 리스트 보이기
				for(i ; i<endi ; i++)
				{
					var pv_figure = $("<div></div>").addClass("card-figure").append(
							$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<img>").attr("src","resources/image/"+pointviewList[i].pointview_image1)),
							$("<div class='card-content'></div>").append(
									$("<i></i>").addClass("far fa-heart").addClass("pvY"+pointviewList[i].pointview_no).addClass("heart_btn_list").attr("idx",i),
									$("<i></i>").addClass("fas fa-heart").addClass("pvN"+pointviewList[i].pointview_no).addClass("heart_btn_fill_list").css("display","none").attr("idx",i),
									$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("viewname").html(pointviewList[i].pointview_name_kor)),
									$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("text").html(pointviewList[i].pointview_topinfo)),
									$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("hashtag").html(pointviewList[i].pointview_hashtag))
								)
							).addClass("pvno"+pointviewList[i].pointview_no);
					
					$(".card-column").append(pv_figure);
					
					//해당 관광지와 같은 곳은 리스트에 안 보이게 처리
					if(pvno == pointviewList[i].pointview_no)
					{
						$(".pvno"+pvno).css("display","none");
					}
					
						
					//이미 좋아요한 관광지는 버튼 변경	
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
									$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<img>").attr("src","resources/image/"+pointviewList[i].pointview_image1)),
									$("<div class='card-content'></div>").append(
											$("<i></i>").addClass("far fa-heart").addClass("pvY"+pointviewList[i].pointview_no).addClass("heart_btn_list").attr("idx",i),
											$("<i></i>").addClass("fas fa-heart").addClass("pvN"+pointviewList[i].pointview_no).addClass("heart_btn_fill_list").css("display","none").attr("idx",i),
											$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("viewname").html(pointviewList[i].pointview_name_kor)),
											$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("text").html(pointviewList[i].pointview_topinfo)),
											$("<a></a>").attr("href","pointview?no="+pointviewList[i].pointview_no).html($("<div></div>").addClass("hashtag").html(pointviewList[i].pointview_hashtag))
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
			var map_x = pointviewList[idx].pointview_location_X;
			var map_y = pointviewList[idx].pointview_location_Y;
			
			
			
			$.ajax({
				url:"likeBtnInsert.do",
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
				url:"likeBtnDelete.do",
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
	

	
	if(mno>0)
	{
		$(".like_tooltiptext").css("display","none");
		
		$("#heart-btn").click(function() {
			
			var pvno = ${pv.pointview_no};
			var name = "${pv.pointview_name_kor}";
			var topinfo = "${pv.pointview_topinfo}";
			var hashtag = "${pv.pointview_hashtag}";
			var addr = "${pv.pointview_addr}";
			var img = "${pv.pointview_image1}";
			var eng = "${pv.pointview_name_eng}";
			var map_x = "${pv.pointview_location_X}";
			var map_y = "${pv.pointview_location_Y}";
	
			$.ajax({
				url:"likeBtnInsert.do",
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
						
						$("#heart-btn").css("display","none");
						$("#heart-btn-fill").css("display","block");
					}
				}
			});
		});
		
		$("#heart-btn-fill").click(function() {
			
			$.ajax({
				url:"likeBtnDelete.do",
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
						
						$("#heart-btn-fill").css("display","none");
						$("#heart-btn").css("display","block");
					}
				}
			});
		});
	}else {
		$(".like_tooltiptext").css("display","block");
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
</head>	

<body>
<header>
	<a href="#"><button id="top-btn" title="Go to top">Top</button></a>
		<div class="topnav">
	  <div class="logo-top"><a href="indexmain.jsp"><img src="resources/img/logo_top2.png"></a></div>
	  <div class="logo-topM"><a href="indexmain.jsp"><img src="resources/img/logo_top_m.png"></a></div>


	  <input class="search_input" type="text" name="search" placeholder="Search.." id="autocomplete">
	  <button class="search-bnt" ><img id="search-img" src="resources/img/search_icon (3).png" ></button>

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
	  <a class="s-a" href="javascript:void(0)">여행 일정 계획</a>
	  <a class="s-a" href="javascript:void(0)">동행게시판</a>
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
	<div class="top-img-sect">
		<img alt="" src="resources/image/${pv.pointview_image1 }"> 
		<div class="img_content">
			<h1>${pv.pointview_name_kor}</h1>
			<p>${pv.pointview_topinfo }</p>
		</div>
	</div>
	<div class="hash-like">
			<div class="top-hashtag">${pv.pointview_hashtag }</div>
			<div class="top-like">
				<i class='far fa-heart' id="heart-btn"><span id="like_text">좋아요</span></i>
				<i class='fas fa-heart' id="heart-btn-fill"><span id="like_text">좋아요</span></i>
				<span class="like_tooltiptext">로그인 후 이용 가능</span>
			</div>
		</div>
	
	<div class="center">
		<div class="view-info">
			<div class="top-content">
				<div class="info-title">기본 정보</div>
				<hr>
				<div class="content">
					<div class="box">
						<div class="vinfo-title"><i class="fas fa-map-marker-alt" > 주소</i></div>
						<div class="vinfo-text">${pv.pointview_addr }</div>
					</div>
					<div class="box">
						<div class="vinfo-title"><i class="fas fa-clock" > 이용시간</i></div>
						<div class="vinfo-text">${pv.pointview_hours }</div>
					</div>
					<div class="box">
						<div class="vinfo-title"><i class="fas fa-money-check-alt" > 요금</i></div>
						<div class="vinfo-text">${pv.pointview_pay }</div>
					</div>
				</div>
			</div>
			<div class="pv_small_img">
				<input type="hidden" id="img1" value="${pv.pointview_image1}">
				<input type="hidden" id="img2" value="${pv.pointview_image2}">
				<input type="hidden" id="img3" value="${pv.pointview_image3}">
				<input type="hidden" id="img4" value="${pv.pointview_image4}">
			</div>
		</div>
		<div class="pv_label"><i class="fas fa-quote-left" style="font-size: 20px;"> 관광지 설명</i></div>
		<div class="pv_detail">&nbsp;&nbsp;${pv.pointview_info}</div>
		<br>
		<br>
		<br>
		<div class="pv_label"><i class="fas fa-map" style="font-size: 20px;"> 지도</i></div>
		<div id="pvMap">
			<span id="map_x" style="display:none;">${pv.pointview_location_X}</span>
			<span id="map_y" style="display:none; background-color: rgba(0,0,0,1);">${pv.pointview_location_Y}</span>
		</div>
	</div>
	
	
	
	<div class="center">
		<h2> 근처 관광지</h2> 
		<div class="card-list">
			<div class="card-column" ></div>
		</div>
	</div>
	
	
	<!-- 좋아요 레이어 팝업 -->
	<div id="like_popup">
		<i class="fas fa-heart" id="like_icon">
			<div id="like_text">좋아요 <span id="like_success">성공!</span><span id="like_cancel">취소</span></div>
			<!--<div id="like_info">마이페이지 > 좋아요 확인</div> -->
		</i>
	</div>
	
	<%--
	<div class="center">	
		<h2>소셜 리뷰 ${pv.pointview_review}</h2>
		    <div class="review-list">
		  		<div class="item">
		  			<div class="review-img"><img src="img/walk.jpg" alt="review"></div>
		  			<div class="review-content">
		  				<div class="review-title">유니버셜 스튜디오 할인 방법</div>
		  				<div class="review-text">이번에 오사카 여행가서 30%나 할인 받았어요! 할인 받는 방법은 생각보다 어렵지 않습니다. 미리 가기 전에 예약 결제를 하고 가면 저렵하게 이용이 가능합니다.</div>
		  			</div>
		  		</div>
		  		<div class="item">
		  			<div class="review-img"><img src="img/umadapark.jpg" alt="review"></div>
		  			<div class="review-content">
		  				<div class="review-title">유니버셜 스튜디오 할인 방법</div>
		  				<div class="review-text">이번에 오사카 여행가서 30%나 할인 받았어요! 할인 받는 방법은 생각보다 어렵지 않습니다. 미리 가기 전에 예약 결제를 하고 가면 저렵하게 이용이 가능합니다.</div>
		  			</div>
		  		</div>
		  		<div class="item">
		  			<div class="review-img"><img src="img/japan.jpg" alt="review"></div>
		  			<div class="review-content">
		  				<div class="review-title">유니버셜 스튜디오 할인 방법</div>
		  				<div class="review-text">이번에 오사카 여행가서 30%나 할인 받았어요! 할인 받는 방법은 생각보다 어렵지 않습니다. 미리 가기 전에 예약 결제를 하고 가면 저렵하게 이용이 가능합니다.</div>
		  			</div>
		  		</div>
			</div>
		</div>
		--%>
</section>
<script>
//구글맵 스크립트
var map;


var x = Number($("#map_x").html());
var y = Number($("#map_y").html());

if(x!="")
{
	$("#pvMap").css({"background-color":"rgba(0,0,0,0)"});
	var myLatLng = {lat: x, lng:y };
	function initMap() {
		//var myLatLng = ;
	  map = new google.maps.Map(document.getElementById('pvMap'), {
		  center: myLatLng,
	    zoom: 15
	  });
	  
	  var marker = new google.maps.Marker({
	      map: map,
	      position: myLatLng
	    });
	}
}else{
	var i = $("<i></i>").addClass("fas fa-exclamation-triangle").css({"font-size":"40px","color":"gray","margin-top":"100px"});
	var con =  $("<p></p>").html("지도 정보가 없습니다.").css({"color":"gray"});
	$("#pvMap").css({"background-color":"#F2F2F2"});
	
	$("#pvMap").append(i,con);
}

</script>
<script src="https://maps.googleapis.com/maps/api/js?key=scretkey&callback=initMap" async defer></script>

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
