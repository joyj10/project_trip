<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>@Trip : 여행일정</title>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
    @import url('resources/css/board.css');
    .btdel{
    display: inline-block;
      background-color: DodgerBlue;
  border: none;
  color: white;
  padding: 12px 16px;
  font-size: 16px;
  cursor: pointer;
    }
    .btdel:hover {
  background-color: RoyalBlue;
}
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript">
    $(function(){
        var mno;
    	//로그인 된 경우 멤버 번호를 브라우저로 부터 받아오는 명령어
    	if(window.sessionStorage){
    		mno = window.sessionStorage.getItem("m_no");
    	}
    	

    	if(mno == null || mno ==0){
    		alert("로그인 후 이용하여 주십시오.")
    		window.history.back(-1);
    	}
    	callPlan(mno);
    	function callPlan(mno){
			  $.ajax({
		        	url : "planlist01",
		        	data : {m_no:mno},
					success:function(data){
						var today = Date.now();
						
			        	var planArr=eval("("+data+")");
			        	
				        if (planArr.length == 0)
				        {
				        	$("#plan_info").css("display","block");
							var i = $("<i></i>").addClass("fas fa-exclamation-triangle").css({"font-size":"40px","color":"gray"});
							var con =  $("<p></p>").html("아직 만든 여행일정이 없습니다.").css({"color":"gray"});
							$("#plan_info").append(i,con);
				        }
				        else
				        {
				        	$("#plan_info").css("display","none");
							$.each(planArr,function(i,p){	
								//var con =  $("<button></button>").addClass("btdel").html($("<i></i>").addClass("fa fa-trash").html("&nbsp;일정삭제")).attr("onclick","btdel()");
								//$("#btdel").append(con);
								var pno =p.plan_no;
								var startday = new Date(p.plan_startday);
								var date1 = startday.toDateString();
								var endday = new Date(p.plan_endday);
								var date2 = endday.toDateString();
								var a = $("<a></a>").attr("href","planline.do?plan_no="+p.plan_no).html($("<img></img>").attr({src:"resources/image/"+p.plan_image}).css({"position":"absolute","height":"180px","left":"0px","top":"0px","opacity":"0"}));	
								
								var div1 = $("<div></div>").addClass("city");
								
								var btdel = $("<span></span>").html($("<i></i>").addClass("fa fa-trash")).css({"position":"absolute","z-index":"11","color": "white","font-size":"30px","left":"10px","bottom":"15px"}).attr("onclick","btdel("+pno+")");
								
								//var btup = $("<a></a>").attr("href","makeplanUpdate.do?plan_no="+p.plan_no).html($("<span></span>").html($("<i></i>").addClass("fas fa-wrench")).css({"position":"absolute","z-index":"11","color": "white","font-size":"30px","left":"50px","bottom":"15px"}).attr("onclick","btup("+pno+")"));
								if (today > endday){var img2 = $("<img></img>").attr({src:"resources/img/stamp02.png"}).css({"position":"absolute","z-index":"9","width":"150px","height":"110px","right":"10px","bottom":"10px"});}
								else{var img2 = $("<img></img>").attr({src:"resources/image/stamp02.png"}).css({"position":"absolute","z-index":"-1","width":"150px","height":"110px","right":"10px","bottom":"10px"});}
								
								var img = $("<img></img>").attr({src:"resources/image/"+p.plan_image});
								var img3 = $("<img></img>").attr({src:"resources/image/"+p.plan_image}).css({"position":"absolute","height":"180px","left":"0px","top":"0px","opacity":"0"});
								var div2 = $("<div></div>").addClass("plan-info");
								
								var span1 = $("<span></span>").attr("id","plan-title").html(p.plan_name);
								
								//$(div2).append(span1,"여행일정 : "+date1+" ~"+date2+"<br>","여행장소 : "+p.city_name);
								var a1 = $("<a></a>").attr("href","planline.do?plan_no="+p.plan_no).html($(div2).append(span1,"여행일정 : "+date1+" ~"+date2+"<br>","여행장소 : "+p.city_name));	
								$(div1).append(img,btdel,img2,a,a1);
								//$(div1).append(img,btdel,btup,img2,a,div2);
								//$(a).append(div1);
								$(".recommend-wrapper-two").append(div1);
								$(btdel).click(function(){
									  var r = confirm("정말 삭제 하시겠습니까?");
									  if (r == true) {
										  var data={plan_no:pno};

											  $.ajax({
										        	url : "delPlan",
										        	data : {plan_no:pno},
													success:function(data){
														
													
										  }})
										  
										  $(div1).fadeOut();
											  
									  } 
								})
				        	});
			           }
		    	}});
		  }
    });
   
   function btup(pno){
	   alert(pno);
	   var data={plan_no:pno};
	   window.location.href="/makeplanUpdate?plan_no="+pno;

   } 
   
</script>
</head>
<body>
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
	<div class="top-img-sect">
		<img alt="" src="resources/img/beach2.jpg"> 
		<div class="img_content">
			<h1>여행을 떠나요!</h1>
			<a href="makeplan.do"><button class="top-bnt-b" style="font-size:15px;font-weight: bold;  "><span>일정 만들기</span></button></a>
		</div>
	</div>
					
    <div class="center">
		<div class="recommend-sec">
			<h2 class="country-cityname">여행일정</h2>
			<div id="btdel" ></div>
			<div id="plan_info" class="no_list_info"></div>
			<div class="recommend-wrapper-two" >
				
				
				
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
</body>
</html>