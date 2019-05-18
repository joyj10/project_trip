<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>동행게시판 상세</title>
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
    @import url('resources/css/board.css');
</style>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script type="text/javascript" src="resources/js/board.js"></script>
<script type="text/javascript">
$(function(){	
	//로그인 된 경우 멤버 번호를 브라우저로 부터 받아오는 명령어
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}

	// 수정 시 확인
	$("#btn_pwd_u").click(function(){
		var pwd = prompt('게시판 글의 비밀번호를 입력하세요.');
		var bno = $("#bno").val();
		var bpwd = $("#bpwd").val();			
		if (pwd == bpwd){
			window.location.href="updateBoard.do?b_no="+bno;
		}
		else{
			alert('비밀번호가 일치하지 않습니다.');
		}	
	});
	// 삭제 시 확인
	$("#btn_pwd_d").click(function () {
		var pwd = prompt('삭제할 글의 비밀번호를 입력하세요.');
		var bno = $("#bno").val();
		var bpwd = $("#bpwd").val();	
		if(pwd == bpwd){
			window.location.href="deleteBoard.do?b_no="+bno;
		}
		else{
			alert("비밀번호가 일치하지 않습니다.");
		}
	});
		
	// 댓글 리스트 노드 함수 및 변수
	var r_step_arr = [];
	var r_no_arr = [];
	var b_no = $("#bno").val();
	var bno_data = {b_no:b_no,r_step:0,r_no:0};
	var list_arr;
	
	function recomment_list(arr){
		$.each(arr,function(i,c){	
			if(c.r_level == 0){
				var startday = new Date(c.b_wdate);
			    var date1 = startday.toDateString();
				$(r_no_arr).append(c.r_no);
				$(r_step_arr).append(c.r_step);
				var hr = $("<hr>");
				var c_area = $("<div></div>").addClass("c-area").attr("index",i).attr("rno",c.r_no).attr("id","ca"+c.r_no);
				var c_name = $("<p></p>").addClass("c-name").html('<i class="fas fa-plane"></i>&nbsp'+c.r_writer +'&nbsp&nbsp<span>'+date1+'</span>');
				var c_content = $("<p></p>").addClass("c-content").html(c.r_content).attr("index",i).attr("id","cc"+c.r_no);
				var comment_bnt = $("<div></div>").addClass("comment-bnt");
				var re_btn = $("<button></button>").addClass("re-btn").html("답글").attr("rno",c.r_no).attr("rstep",c.r_step).attr("index",i);
				var comment_up = $("<button></button>").addClass("comment_up").html("수정").attr("rno",c.r_no).attr("index",i).attr("pp",c.r_pwd);
				var comment_del = $("<button></button>").addClass("comment_del").html("삭제").attr("rno",c.r_no).attr("index",i).attr("pp",c.r_pwd);
				$(comment_bnt).append(re_btn,comment_up,comment_del);
				$(c_area).append(c_name,c_content,comment_bnt);				
				$(".comment-list").append(hr,c_area);			
			}
			else{	
				var startday = new Date(c.b_wdate);
			    var date1 = startday.toDateString();
				var r_name = $("<p></p>").addClass("cr-name").html('<i class="fas fa-caret-right"></i>&nbsp'+c.r_writer+'&nbsp<span>'+date1+'</span>');
				var r_content = $("<p></p>").addClass("cr-content").html(c.r_content).attr("index",i).attr("id","cc"+c.r_no);
				var recomment_bnt = $("<div></div>").addClass("cr_comment-bnt").attr("id","re_bnt");
				var recomment_up = $("<button></button>").addClass("re_comment_up").html("수정").attr("rno",c.r_no).attr("rstep",c.r_step).attr("rlevel",c.r_level).attr("index",i).attr("pp",c.r_pwd);
				var recomment_del = $("<button></button>").addClass("re_comment_del").html("삭제").attr("rno",c.r_no).attr("rstep",c.r_step).attr("rlevel",c.r_level).attr("index",i).attr("pp",c.r_pwd);
				var hr = $("<hr style='background-color:#F2F2F2;border:0px;height:2px;margin-left:10px;'>");
				$(recomment_bnt).append(recomment_up,recomment_del);
				$("#ca"+c.r_level).append(hr,r_name,r_content,recomment_bnt);			
			};
		});
	};
	
	// 댓글 목록
	$.ajax({url:"listComment.do",data:bno_data,success:function(data){
		var arr = eval("("+data+")");
		list_arr = arr;
		if (arr.length >= 1){
			recomment_list(arr);	
		};
	}});
	
	// 댓글 입력
	$("#comment_insert").click(function(){	
			var name = $("#name").val();
			var pwd = $("#pwd").val();
			var subject = $("#subject").val();
			var data = {name:name,pwd:pwd,subject:subject,b_no:b_no,r_step:0,r_no:0};
			if (name =="" || pwd =="" || subject ==""){
				alert("모든 항목을 입력하세요.");	
			}
			else{
				$.ajax({url:"insertComment.do",data:data,success:function(data){
					$(".comment-list").empty();
					$.ajax({url:"listComment.do",data:bno_data,success:function(data){
						var arr = eval("("+data+")");
						if (arr.length >= 1){
							recomment_list(arr);
							$("#name").val("");
							$("#pwd").val("");
							$("#subject").val("");
							$(".re-content").css("display","none");					
						};
					}});
				}});
			};
		});	

	// 댓글 삭제(체크필요!!!!!! 비밀번호)
	$(document).on("click",".comment_del",function(){
		var c = prompt("댓글을 삭제 하시겠습니까?")
		var r_no = $(this).attr('rno');		
		var pp = $(this).attr('pp');			
		if( c == pp){		
			var data = {r_no:r_no};
			$.ajax({url:"deleteComment.do",data:data,success:function(data){
				$(".comment-list").empty();
				$.ajax({url:"listComment.do",data:bno_data,success:function(data){
					var arr = eval("("+data+")");
					if (arr.length >= 1){
						recomment_list(arr);
					}
				}})
			}});		
		};
	});

	// 댓글 수정(체크 필요!! 비밀번호)
	$(document).on("click",".comment_up",function(){
		var r_no = $(this).attr('rno');
		var idx = $(this).attr('index');
		var pp = $(this).attr('pp');
		var c = prompt("댓글을 수정 하시겠습니까?")
		if(c == pp){
			$("#cc"+r_no).remove();
			$(".comment-bnt").remove();
			var textarea_up = $("<textarea></textarea>").html(list_arr[idx].r_content).attr("id","text_update");
			var btn_update = $("<input type='submit'>").val("수정").addClass("comment-bnt").attr("id","comment_update");
			$("#ca"+r_no).append(textarea_up,btn_update);			
			$(document).on("click","#comment_update",function(){
				var r_content = $("#text_update").val();
				var data = {r_no:r_no,r_content:r_content};
				$.ajax({url:"updateComment.do",data:data,success:function(){
					$.ajax({url:"listComment.do",data:bno_data,success:function(data){
						var arr = eval("("+data+")");
						if (arr.length >= 1){
							$(".comment-list").empty();							
							recomment_list(arr);
						};
					}});
				}});
			});
		};
	});

	// 답글 입력
	$(document).on("click",".re-btn",function(){
		var r_no = $(this).attr('rno');
		var idx = $(this).attr('index');

			$(".comment-bnt").remove();
			var recomment_div = $("<div></div>").addClass("crw-comment");
			var recontent_div = $("<div></div>").addClass("crw-content");
			
			var row_div = $("<div></div>").addClass("crw_row");
			var col15_div = $("<div></div>").addClass("col-15");
			var name_label = $("<label></label>").attr("for","name").html("이름");
			var col40_div = $("<div></div>").addClass("col-40");;
			var input_name = $("<input type='text'>").attr("id","re_name").attr("required",true);
			$(col15_div).append(name_label);
			$(col40_div).append(input_name);
			$(row_div).append(col15_div,col40_div);
			$(recontent_div).append(row_div);
			$(recomment_div).append(recontent_div);	
			
			var row_div = $("<div></div>").addClass("crw_row");
			var col15_div = $("<div></div>").addClass("col-15");
			var pwd_label = $("<label></label>").attr("for","pwd").html("암호");
			var col40_div = $("<div></div>").addClass("col-40");
			var input_pwd = $("<input type='password'>").attr("id","re_pwd").attr("required",true);
			$(col15_div).append(pwd_label);
			$(col40_div).append(input_pwd);
			$(row_div).append(col15_div,col40_div);
			$(recontent_div).append(row_div);
			$(recomment_div).append(recontent_div);	
			
			var row_div = $("<div></div>").addClass("crw_row");
			var col15_div = $("<div></div>").addClass("col-15");
			var content_label = $("<label></label>").attr("for","content").html("내용");
			var col40_div = $("<div></div>").addClass("col-75");
			var input_content = $("<textarea></textarea>").attr("id","re_content").attr("required",true);
			$(col15_div).append(content_label);
			$(col40_div).append(input_content);
			$(row_div).append(col15_div,col40_div);
			
			var re_comment_insert = $("<div></div>").attr("id","re_comment_insert")
			var input_re = $("<input type = 'submit'>").val("등록").attr("id","recomment_insert");		
			var re_comment_cancel = $("<div></div>").attr("id","re_comment_cancel")
			var input_cancel = $("<input type = 'reset'>").val("취소").attr("id","recomment_cancel");
			
			$(re_comment_insert).append(input_re);
			$(re_comment_cancel).append(input_cancel);
			$(recontent_div).append(row_div,re_comment_insert,re_comment_cancel);
						
			var re_title = $("<div style='padding:10px'><i class='fas fa-comment-medical'> 답글 쓰기</i></div>")
			$(recomment_div).append(re_title,recontent_div);
		
			$("#ca"+r_no).append(recomment_div);
				
			$(document).on("click","#recomment_insert",function(){
				var r_writer = $("#re_name").val();
				var r_pwd = $("#re_pwd").val();
				var r_content = $("#re_content").val();
				var data = {name:r_writer,pwd:r_pwd,subject:r_content,b_no:b_no,r_step:0,r_no:r_no};
				if (r_writer =="" || r_pwd =="" || r_content ==""){
					alert("모든 항목을 입력하세요.");	
				}
				else{
					$.ajax({url:"insertComment.do",data:data,success:function(data){
						$.ajax({url:"listComment.do",data:bno_data,success:function(data){
							var arr = eval("("+data+")");
							if (arr.length >= 1){
								$(".comment-list").empty();							
								recomment_list(arr);
							}
						}})
					}});	
				}
			});
			
			$(document).on("click","#recomment_cancel",function(){
				var r_writer = $("#re_name").val("");
				var r_pwd = $("#re_pwd").val("");
				var r_content = $("#re_content").val("");
					$.ajax({url:"listComment.do",data:bno_data,success:function(data){
						var arr = eval("("+data+")");
						if (arr.length >= 1){
							$(".comment-list").empty();							
							recomment_list(arr);
						}
					}})
				});
			});
	
	// 답글 삭제(비밀번호 체크!)
	$(document).on("click",".re_comment_del",function(){
		var c = prompt("답글을 삭제하시겠습니까?")
		var r_no = $(this).attr('rno');
		var r_step = $(this).attr('rstep');
		var r_level = $(this).attr('rlevel');
		var pp = $(this).attr('pp');
		if( c == pp){		
			var data = {r_no:r_no,r_step:r_step,r_level:r_level};			
			$.ajax({url:"re_deleteComment.do",data:data,success:function(data){
				alert("답글을 삭제하였습니다.");
				$(".comment-list").empty();
				$.ajax({url:"listComment.do",data:bno_data,success:function(data){
					var arr = eval("("+data+")");
					if (arr.length >= 1){
						recomment_list(arr);
					}
				}})
			}});		
		};
	});
	

	// 답글 수정(비밀번호 체크!)
	$(document).on("click",".re_comment_up",function(){
		var r_no = $(this).attr('rno');
		var r_step = $(this).attr('rstep');
		var r_level = $(this).attr('rlevel');
		var idx = $(this).attr('index');
		var pp = $(this).attr('pp');
		var c = prompt("답글을 수정 하시겠습니까?")
		if(c == pp){
			$("#re_bnt").empty();
			var re_comment_div = $("<div></div>").addClass("re_comment_div").attr("id","test"+r_no);
			var re_textarea_up = $("<textarea></textarea>").html(list_arr[idx].r_content).attr("id","re_text_update");
			var re_btn_update = $("<input type='submit'>").val("수정").addClass("comment-bnt").attr("id","re_comment_update");			
			$(re_comment_div).append(re_textarea_up, re_btn_update);
			$("#ca"+r_level).append(re_comment_div);			
			$(document).on("click","#re_comment_update",function(){
				alert('답글을 수정하였습니다.');
				var r_content = $("#re_text_update").val();
				var data = {r_no:r_no,r_content:r_content,r_step:r_step,r_level:r_level};
				$.ajax({url:"re_updateComment.do",data:data,success:function(){
					$.ajax({url:"listComment.do",data:bno_data,success:function(data){
						var arr = eval("("+data+")");
						if (arr.length >= 1){
							$(".comment-list").empty();							
							recomment_list(arr);
						};
					}});
				}});
			});
		};
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
				<img alt="" src="resources/img/nightView.jpg"> 
				<div class="img_content">
					<p class="detail-info">${b.b_region }ㅣ${b.b_startday } ~ ${b.b_endday }</p>
					<h1>${b.b_title }</h1>
					<p class="detail-info2">${b.m_name } ㅣ ${b.b_wdate } </p>
				</div>
			</div>
			<div class="center">
				<p class="detail-content">
					${b.b_content }		
				</p>
				<hr>
			<input type="hidden" value="${b.b_no }"  id="bno">
			<input type="hidden" value="${b.b_pwd}" id="bpwd">	
				<div class="detail-bnt">	
					<a href="listBoard.do"><button type="button">목록</button></a>
					<button id="btn_pwd_u" >수정</button>
					<button id="btn_pwd_d">삭제</button>
				</div>
				<div class="comment">
					<button class="collapsible" >댓글 쓰기 +</button>
						 <div class="re-content" >
						  <div class="row">
						      <div class="col-15">
						        <label for="name">이름</label>
						      </div>
						      <div class="col-40">
						        <input type="text" id="name" name="name" >
						      </div>
						  </div>
						  <div class="row">
						      <div class="col-15">
						        <label for="pwd">암호</label>
						      </div>
						      <div class="col-40">
						        <input type="password" id="pwd" name="pwd" >
						      </div>
						  </div>
	  					  <div class="row">
						      <div class="col-15">
						        <label for="subject">내용</label>
						      </div>
						      <div class="col-75">
						        <textarea id="subject" name="subject" placeholder="댓글을 입력하세요." style="height:50px"></textarea>
						      </div>
						  </div>
						  <div class="row" id="comment_insert">
						      <input type="submit" value="등록">
						  </div>
					</div>
					<br>
					<br>
					<div class="comment-list">
					</div>
				</div>		
			</div>
			<br>	
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