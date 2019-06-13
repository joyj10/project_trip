<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정짜기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
    @import url('resources/css/headerFooter.css');
    @import url('resources/css/main.css');
    @import url('resources/css/board.css');
.bodyplan{visibility: hidden;};

#planbar-day {	z-index: 100;	overflow: hidden;	background-color: #E6E6E6;	margin: 0;	padding: 0; position: fixed;  top: 70px;  width: 100%;}
#planbar-center{ width:90%; margin:auto; padding: 9px; text-align: center;}
#planbar-day ul{ list-style-type: none; display: inline; padding: 0; padding-top:5px; margin:0; }
#planbar-day ul li{	 display: inline; font-size: 16px; font-weight:bold; color:#333; text-align: center; padding: 13px 15px; margin:10px 0px 5px -6px; text-decoration: none; cursor: grab; }
#planbar-day ul li:hover{	background-color: #333;	color: white;	font-weight: bolder;}
.over{	background-color: #999;	color: white;	font-weight: bolder;}
.over1{	background-color: #999;	color: white;	font-weight: bolder;}
#planbar-day ul li:active{	background-color: #333;	color: #00b6da;	font-weight: bolder;}
#planbar-day .savebtn{ text-align:center; margin:-4px 3px; padding: 8px 5px; cursor: grab; background-color :#A4A4A4; border:none;  font-size: 14px; font-weight:bold; color:white; }
#planbar-day .savebtn:hover { background-color:#00b6da; color:#333;}
.sticky-plan {	position: fixed;	top: 70px;	width: 100%;}
.sticky-plan+center {	padding-top: 130px;}
.plan-content{	width:100%;	vertical-align: top; margin-bottom:370px;}
.plan-item{	display: inline-block;	float:left;	width:50%;	margin: 0;	padding: 0;	padding-right: 1px; height:auto;position: relative;}
#googleMap{	display: inline-block;float:left;width:40%;	background-color:#f9f9f9;height:450px;max-height: 700px;border-radius:10px;position: absolute;margin-left:-200px;}

.plan-item .list{ padding: 5px;  margin-bottom : 5px;  border: 2px solid black;  border-radius: 10px;;
      background-color:#f9f9f9; text-align: left;  display: table; max-height: 90px; height: 90px; width:100%;}
.plan-item .list_div_img{	display:table-cell;	width:24%; height:100%	margin:0;	padding:0;	padding-right:5px;	text-align: center;}
.plan-item .list_img{ object-fit:cover;  display:inline;  width:90%;  height:80px;	  margin:0;	  padding:0; margin-bottom: -18px;   }

.plan-item .list_info{	display:table-cell;	margin-left:0px; margin-right:0px;	width:100%;	height:auto;	vertical-align: top;}
.plan-item .plan_addbtn{	width:35px;	height:40px; float:right; margin-right:0; cursor: grab; }
.plan-item .list_name{	font-weight:bold;	font-size:20px;	width:80%;  margin-top:10px;  padding-right:10px;  }
.plan-item .list_addr{	display:inline-block; margin-top:5px; font-size:14px;	}
/*관광지 좋아요  리스트*/
#backColor-round{ background-color: #EFF5FB; width:100%; height:140px; border-radius: 100%; overflow:hidden;}
#backColor-box{background-color: #EFF5FB; width:100%; margin-top: -90px; margin-bottom:-50px; top:300px;}

.card-list{column-width:250px; column-gap: 10px; padding-bottom:50px;!important; }
.card-figure{	display:inline-block;border: 1px solid rgba(0,0,0,0.2);	margin: 0;	margin-bottom: 10px;padding: 7px;	box-shadow: 2px 2px 5px rgba(0,0,0,0.5);}
.card-figure:hover{border: 1px solid rgba(0,0,0,0.7);}
.card-figure img{ width: 100%;}
.card-figure .card-content{border-top:1px solid rgba(0,0,0,0.2);  padding:5px;  margin-top:7px;   position: relative;}
.card-figure .likelike{ width: 25px; float: right;}
.card-figure .like{ width: 25px; float: right;  cursor: grabbing;}
.card-figure .hashtag{text-align: right; color: gray; font-size:14px; margin-top:10px;}
.card-figure .viewname{ color:black; text-align: left; font-weight: bold; font-size: 18px; margin: 5px 0px;}
.card-figure .text{margin-left:5px; text-align: left; font-size:15px; color:#6E6E6E; }


.card-figure1{	display:inline-block;border: 1px solid rgba(0,0,0,0.2);	margin: 0;	margin-bottom: 10px;padding: 7px;	box-shadow: 2px 2px 5px rgba(0,0,0,0.5);}
.card-figure1:hover{border: 1px solid rgba(0,0,0,0.7);}
.card-figure1 img{ width: 100%;}
.card-figure1 .card-content{border-top:1px solid rgba(0,0,0,0.2);  padding:5px;  margin-top:7px;   position: relative;}
.card-figure1 .likelike{ width: 25px; float: right;}
.card-figure1 .like{ width: 25px; float: right; cursor: grabbing;}
.card-figure1 .hashtag{text-align: right; color: gray; font-size:14px; margin-top:10px;}
.card-figure1 .viewname{ color:black; text-align: left; font-weight: bold; font-size: 18px; margin: 5px 0px;}
.card-figure1 .text{margin-left:5px; text-align: left; font-size:15px; color:#6E6E6E; }
.h1css1{display:none;}
.h1css2{visibility:visible;}
.point_no{width: 0px; height: 0px; }
.point_img{width: 0px; height: 0px; }
#point_no{width: 0px; height: 0px; }
#point_img{width: 0px; height: 0px; }
#savebtn:hover{background-color:#00b6da; color:#333;}
#map_x{
  font-size: 1px;
}
#map_y{
  font-size: 1px;
}
#save_icon{	font-size:45px;	margin-top: 35px;display: block;}
#save_text{	margin-top:10px;font-size: 18px;font-weight: bolder;}
#save_success{	display:inline;}
#save_popup.show {  visibility: visible;  -webkit-animation: fadein 0.3s, fadeout 0.3s 0.7s;  animation: fadein 0.3s, fadeout 0.3s 0.7s;}
#save_popup.cancel {  background-color: #A4A4A4}

</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="resources/js/headerFooter.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>


<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script type="text/javascript">
var plannote_datecnt;
var plan_day;
var plan_no;
var city_name;
var pointview_no;
var likearr=[];
var planArr = [];
var savearr=[];
var p;
var alink;
var cnti=0;
var cntl=0;
var cntp=0;
var first=1;
var chk=0;
var x;
var y;

$(function(){
	
	if(window.sessionStorage){
		mno = window.sessionStorage.getItem("m_no");
	}

	if(mno == '0' || mno == 0){
		window.history.back(-1);
	}
	if(mno == null){
		window.history.back(-1);
	}
	loadplan();
	loadLike();
	loadpoint();
	
	
 });
function dayChange(id){
	
	var r = confirm("저장 하시겠습니까?");
	  if (r == true) {
		  saveplan(saveplan);
	  } 
	
	  $("#day1").removeClass("over");
		$("#day1").removeClass();
		$("#day"+plannote_datecnt).removeClass();
		//$("#day1").classList.remove("over");

		 plannote_datecnt=id;

		 $("#day"+id).addClass("over1");
		 
		 //$("#sl").remove();
		 $("#sl").html(""); 
		 
		 $("#hi").append($("<h3></h3>").html( "좋아요 목록에서 원하는 일정을 선택하세요." ).addClass("h1css2"));
	 loadplan2();
	 
	 
}

function loadplan(){


	if(first ==1){
		$("#day1").addClass("over");
		plannote_datecnt=1;
	}
	first++;
	$("#h1").remove();
	let plan_no = $('#plan_no').data('planno');
	var data={plan_no:plan_no};
	$.ajax({url:"planlinelist.do",data:data,success:function(data){
		chk++;
		 var planArr=eval("("+data+")");
		 if(planArr){
			 $("#h1").remove();
	     		$("#hi").addClass("h1css1");
	     	}
	
            $.each(planArr, function(i,g){ 
            	
            	plan_no =g.plan_no;
            	plannote_datecnt = g.plannote_datecnt;
            	
            	plan_day=g.plan_day;
	
            	    //$("#day1").addClass("over");
                    var day = plan_day+1;
                    x =g.plannote_location_x;
                    y = g.plannote_location_y;
                    
            		var div = $("<div></div>").addClass("list").attr("idp",i);
            		var div_info = $("<div></div>").addClass("list_info");
            		var div_img = $("<div></div>").addClass("list_div_img");
            		
            		
            		//MAKE plan
            		cnti = cnti+1;
            		var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+cnti);
            		var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.001rem","display":"none"}).attr("id","point_no");
            		var pimg =  $("<div></div>").html(  g.plannote_image   ).css({"font-size":"0.001rem","display":"none"}).attr("id","point_img");
            		var x =  $("<div></div>").html(  g.plannote_location_x   ).css({"font-size":"0.001rem","display":"none"}).attr("id","map_x");
            		var y =  $("<div></div>").html(  g.plannote_location_y   ).css({"font-size":"0.001rem","display":"none"}).attr("id","map_y");
            		//alert(g.plannote_image);
            		$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.plannote_image}).addClass("list_img")); 
            		
            		$(div_info).append(  can  ); 
            		$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name    ).addClass("list_name")); 
            		$(div_info).append(    $("<span></span>").html( g.pointview_addr    ).addClass("list_addr")); 
            		$(div).append( div_img );
            		$(div).append( div_info );
            		$(div).append( pointno   ); 
            		$(div).append( pimg   );
            		$(div).append( x   );
            		$(div).append( y   );
            		$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.001rem","display":"none"})); 
            		
            		//$( "#"+i ).draggable();
            		//$(div).append(img); 
            		$("#sl").append(div); 
            		
            		
            		 $( "#"+i  ).draggable({
            			  connectToSortable: "#sl",
            			  helper: "clone",
            			  revert: "invalid"
            			});
            		
            		 $( "#sl" ).sortable({
            			  //revert: true
            			});
            		 $(div).click(function(){
            			
            		  x = Number($("#map_x").html());
            		  y = Number($("#map_y").html());
            		  
            		 //x=g.plannote_location_x;
            		 // y=g.plannote_location_y;
            			

            		initMap(x,y);
            		  
            		 });
            		   $("#cancel"+cnti).click(function(){
            				selectDiv = $(this);
            				selectDiv.splice(i,1);
            				
            				//MAKE LIKE
            				 var img1=$("<img>").attr("src","resources/image/"+g.plannote_image);
            				 cntl = cntl +1;
    	    				 var img2 =$("<img/>").addClass("like").attr({src:"resources/img/plus.png",width:40,height:32}).attr("id",cntl);

    	    				 var div1 = $("<div></div>").addClass("card-figure");
    	    				 var div2 = $(div1).append(
    	    						 img1,
    								$("<div class='card-content'></div>").append(
    								img2,
    								$("<div></div>").addClass("viewname").html(g.pointview_name),
    								$("<div></div>").addClass("text").html(g.pointview_topinfo),
    								
    								$("<div></div>").addClass("hashtag").html(g.pointview_hashtag) ,
    								$("<div></div>").html(  g.plannote_location_x   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x"),
    								$("<div></div>").html(  g.plannote_location_y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y"),
    								$("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no"),
    								$("<div></div>").html(  g.plannote_image   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img")
    								
    							).attr("idx",i)
    							);
    							$(".card-column").append(div2);	
    							 $("#"+cntl).click(function(){
			    					 var idx = $(this).attr("idx");
			    					 
			    					// $(div ).remove(event.currentTarget.div);
			    					 $("#idx"+i).remove();
			    					 $(this).parent().remove();
			    					 $(this).parent().parent().remove();

			    					 $(img1).remove();
			    					 $(div1).remove();
			    					 
			    					 
			    					 
			    							var div = $("<div></div>").addClass("list").attr("idp",i);
			    							var div_info = $("<div></div>").addClass("list_info");
			    							var div_img = $("<div></div>").addClass("list_div_img");
			    							var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+i);
			    							var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
			    							var pimg =  $("<div></div>").html(  g.plannote_image   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");
			    							var x =  $("<div></div>").html(  g.plannote_location_x   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
			    							var y =  $("<div></div>").html(  g.plannote_location_y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y");
			    							
			    							$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.plannote_image}).addClass("list_img")); 
			    							$(div).append( div_img );
			    							$(div_info).append(  can  ); 
			    							$(div).append( pimg   );

			    							$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name    ).addClass("list_name")); 
			    							$(div_info).append(    $("<div></div>").html( g.pointview_addr    ).addClass("list_addr")); 
			    							$(div).append( div_info );
			    							$(div).append( pointno   );
			    							$(div).append( x   );
			    							$(div).append( y   );
			    							$(div).append(    $("<div></div>").html(  g.plannote_no   ).css({"font-size":"0.1rem","display":"none"})); 
			    							$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
			    							//$( "#"+i ).draggable();
			    							//$(div).append(img); 
			    							$("#sl").append(div); 
			    							
			    							
			    							
			    							// $(div).click(function(){ 
			    							   $(can).click(function(){
			    									selectDiv = $(this);
			    									selectDiv.splice(i,1);
			    									$(div).remove();
			    								});
			    				 
			    							   
				    					
				    				});
	    				
    							
    							
    							$(div).remove();
            			});
            		   
            });
           
           
	 }});
	
}		

function loadpoint(){
	let plan_no = $('#plan_no').data('planno');
var  ccnt=0;
	$.ajax({
    	url : "planpoint.do",
    	data : {plan_no:plan_no},
		success:function(data){
			 
		 
		 
		 
		 var arr=eval("("+data+")");
		// alert(arr);
		  $.each(arr,function(i,g){
			  
		  ccnt = ccnt+1;
		  if(ccnt == 1){
			  $("#map_xx").append($("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}));
			  
			  $("#map_yx").append($("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}));
			  initMap(g.pointview_location_X,g.pointview_location_Y);
			 
		  }
			  cntp = cntp+1;
			  
			  //alert(g.pointview_location_X);
			  var img2 =$("<img/>").addClass("like").attr({src:"resources/img/plus.png",width:40,height:32}).attr("id","point"+cntp);
			 
			  
				 var div = $("<div></div>").addClass("card-figure1").append(
						 $("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<img>").attr("src","resources/image/"+g.pointview_image1)),
						
						$("<div class='card-content'></div>").append(
								
						img2,
						$("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<div></div>").addClass("viewname").html(g.pointview_name_kor)),
						$("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<div></div>").addClass("text").html(g.pointview_topinfo)),
						$("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<div></div>").addClass("hashtag").html(g.pointview_hashtag)),
						$("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x"),
						$("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y"),
						$("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no"),
						$("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img")
					)
					);
				
				 //var aCity = $("<a></a>").attr("href","city/"+cityArr[i].city_name_eng+"?no="+cityArr[i].city_no).html(cityGird);
				
					//$(".card-column1").append(aPointView);
					
					$(".card-column1").append(div);
					
					$("#point"+cntp).click(function(){
						 var idx = $(this).attr("idx");
    					 
	    					// $(div ).remove(event.currentTarget.div);
	    					 $("#idx"+i).remove();
	    					
	    					 $(this).parent().parent().remove();
	    					 $(this).parent().remove();
	    					 
	    					 

	    					 $(img2).remove();
	    					
	    					 
	    					//MAKE plan
	    							var div = $("<div></div>").addClass("list").attr("idp",i);
	    							var div_info = $("<div></div>").addClass("list_info");
	    							var div_img = $("<div></div>").addClass("list_div_img");
	    							var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
	    							cnti = cnti+1;
	    							var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+cnti);
	    							var pimg =  $("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");

	    							var x =  $("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
	    							var y =  $("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y");
	    							
	    							$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.pointview_image1}).addClass("list_img")); 
	    							$(div).append( div_img );
	    							$(div_info).append(  can  ); 
	    							$(div).append( pointno   );
	    							
	    							$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name_kor    ).addClass("list_name")); 
	    							$(div_info).append(    $("<div></div>").html( g.pointview_addr    ).addClass("list_addr")); 
	    							$(div).append( div_info );
	    							$(div).append( pimg   );

	    							$(div).append( x   );
	    							$(div).append( y   );
	    							$(div).append(    $("<div></div>").html(  g.plannote_no   ).css({"font-size":"0.1rem","display":"none"})); 
	    							$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
	    							//$( "#"+i ).draggable();
	    							//$(div).append(img); 
	    							$("#sl").append(div); 
	    							
	    							 $( "#"+i  ).draggable({
	    		            			  connectToSortable: "#sl",
	    		            			  helper: "clone",
	    		            			  revert: "invalid"
	    		            			});
	    		            		 $( "#sl" ).sortable({
	    		            			 // revert: true
	    		            			});
	    		            		 $(div).click(function(){
	    		             			
	    		                		 x = Number($("#map_x").html());
	    		                		 y = Number($("#map_y").html());
	    		                		  
	    		                		 //x=g.pointview_location_X;
	    		                		  //y=g.pointview_location_Y;
										//	alert(x);
	    		                		  initMap(x,y);
	    		                		  
	    		                		 });
	    							// $(div).click(function(){ 
	    							   $("#cancel"+cnti).click(function(){
	    									selectDiv = $(this);
	    									selectDiv.splice(i,1);
	    									
	    									
	    									//MAKE LIKE
	    		            				 var img1=$("<img>").attr("src","resources/image/"+g.pointview_image1);
	    		            				 cntl = cntl +1;
	    		    	    				 var img2 =$("<img/>").addClass("like").attr({src:"resources/img/plus.png",width:40,height:32}).attr("id",cntl);
	    		    	    				 var div1 = $("<div></div>").addClass("card-figure");
	    		    	    				 var div2 = $(div1).append(
	    		    	    						 img1,
	    		    								$("<div class='card-content'></div>").append(
	    		    								img2,
	    		    								$("<div></div>").addClass("viewname").html(g.pointview_name_kor),
	    		    								$("<div></div>").addClass("text").html(g.pointview_topinfo),
	    		    								$("<div></div>").addClass("hashtag").html(g.pointview_hashtag),
	    		    								$("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x"),
	    		    								$("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y"),
	    		    								$("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no"),
	    		    								$("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img")
	    		    							
	    		    							).attr("idx",i)
	    		    							);
	    		    							$(".card-column").append(div2);	
	    		    							 $("#"+cntl).click(function(){
	    					    					 var idx = $(this).attr("idx");
	    					    					 
	    					    					// $(div ).remove(event.currentTarget.div);
	    					    					 $("#idx"+i).remove();
	    					    					 $(this).parent().remove();
	    					    					 $(this).parent().parent().remove();

	    					    					 $(img1).remove();
	    					    					 $(div1).remove();
	    					    					 
	    					    					 
	    					    					 
	    					    							var div = $("<div></div>").addClass("list").attr("idp",i);
	    					    							var div_info = $("<div></div>").addClass("list_info");
	    					    							var div_img = $("<div></div>").addClass("list_div_img");
	    					    							var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+i);
	    					    							var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
	    					    							var pimg =  $("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");
	    					    							var x =  $("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
	    					    							var y =  $("<div></div>>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y");
	    					    							
	    					    							$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.pointview_image1}).addClass("list_img")); 
	    					    							$(div).append( div_img );
	    					    							$(div_info).append(  can  ); 
	    					    							$(div).append( pointno   );
	    					    							$(div).append( pimg   );
	    					    							$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name_kor   ).addClass("list_name")); 
	    					    							$(div_info).append(    $("<div></div>").html( g.pointview_addr    ).addClass("list_addr")); 
	    					    							$(div).append( div_info );
	    					    							$(div).append( x   );
	    					    							$(div).append( y   );

	    					    							$(div).append(    $("<div></div>").html(  g.plannote_no   ).css({"font-size":"0.1rem","display":"none"})); 
	    					    							$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
	    					    							//$( "#"+i ).draggable();
	    					    							//$(div).append(img); 
	    					    							$("#sl").append(div); 
	    					    							
	    					    							
	    					    							
	    					    							// $(div).click(function(){ 
	    					    							   $(can).click(function(){
	    					    									selectDiv = $(this);
	    					    									selectDiv.splice(i,1);
	    					    									$(div).remove();
	    					    								});
	    					    				 
	    					    							   
	    						    					
	    						    				});
	    									
	    									
	    									$(div).remove();
	    								});
					})
		  });
			 
		 }});
			
		 	 
 }

function loadLike(){
	let plan_no = $('#plan_no').data('planno');

	$.ajax({
    	url : "planlinelike.do",
    	
    	data : {m_no:mno,plan_no:plan_no},
		success:function(data){
  			 
	    			 var arr=eval("("+data+")");

	    			  $.each(arr,function(i,g){
	    				 //alert(g.pointview_location_X);
	    				 
	    				 //MAKE LIKE
	    				 var img1=$("<img>").attr("src","resources/image/"+g.pointview_image1);
	    				 cntl = cntl +1;
	    				 var img2 =$("<img/>").addClass("like").attr({src:"resources/img/plus.png",width:40,height:32}).attr("id",cntl);
	    				 
	    				 var div1 = $("<div></div>").addClass("card-figure");
	    				 //var apointview2 = $("<a></a>").attr("href","pointview?no="+g.pointview_no).html(div1);
	    				 var div2 = $(div1).append(
	    						 $("<a></a>").attr("href","pointview?no="+g.pointview_no).html(img1),
	    						 
								$("<div class='card-content'></div>").append(
								img2,
								$("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<div></div>").addClass("viewname").html(g.pointview_name)),
								$("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<div></div>").addClass("text").html(g.pointview_topinfo)),
								$("<a></a>").attr("href","pointview?no="+g.pointview_no).html($("<div></div>").addClass("hashtag").html(g.pointview_hashtag)),
								
								$("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x"),
								$("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y"),
								$("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no"),
								$("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img")
								
							).attr("idx",i)
							);
	    				 //var apointview2 = $("<a></a>").attr("href","pointview?no="+g.pointview_no).html(div2);
	    				 
							$(".card-column").append(div2);
	    				 

				    				 $("#"+cntl).click(function(){
				    					 var idx = $(this).attr("idx");
				    					 
				    					// $(div ).remove(event.currentTarget.div);
				    					 $("#idx"+i).remove();
				    					 $(this).parent().remove();
				    					 $(this).parent().parent().remove();

				    					 $(img1).remove();
				    					 $(div1).remove();
				    					 
				    					//MAKE plan
				    							var div = $("<div></div>").addClass("list").attr("idp",i);
				    							var div_info = $("<div></div>").addClass("list_info");
				    							var div_img = $("<div></div>").addClass("list_div_img");
				    							var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
				    							var x =  $("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
				    							var y =  $("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y");
				    							cnti = cnti+1;
				    							var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+cnti);
				    							var pimg =  $("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");
				    							
				    							$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.pointview_image1}).addClass("list_img")); 
				    							$(div).append( div_img );
				    							$(div_info).append(  can  ); 
				    							$(div).append( pointno   );
				    							$(div).append( pimg   );
				    							$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name    ).addClass("list_name")); 
				    							$(div_info).append(    $("<div></div>").html( g.pointview_addr    ).addClass("list_addr")); 
				    							$(div).append( div_info );
				    							$(div).append( x   );
				    							$(div).append( y   );
				    							$(div).append(    $("<div></div>").html(  g.plannote_no   ).css({"font-size":"0.1rem","display":"none"})); 
				    							$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
				    							//$( "#"+i ).draggable();
				    							//$(div).append(img); 
				    							$("#sl").append(div); 
				    							
				    							 $( "#"+i  ).draggable({
				    		            			  connectToSortable: "#sl",
				    		            			  helper: "clone",
				    		            			  revert: "invalid"
				    		            			});
				    		            		 $( "#sl" ).sortable({
				    		            			//  revert: true
				    		            			});
				    		            		 $(div).click(function(){
				    		             			
				    		                		  x = Number($("#map_x").html());
				    		                		  y = Number($("#map_y").html());
				    		                		  
				    		                		  //x=g.pointview_location_X;
				    		                		  //y=g.pointview_location_Y;
				    		                		 
				    		                		  initMap(x,y);
				    		                		  
				    		                		 });
				    							// $(div).click(function(){ 
				    							   $("#cancel"+cnti).click(function(){
				    									selectDiv = $(this);
				    									selectDiv.splice(i,1);
				    									
				    									
				    									//MAKE LIKE
				    		            				 var img1=$("<img>").attr("src","resources/image/"+g.pointview_image1);
				    		            				 cntl = cntl +1;
				    		    	    				 var img2 =$("<img/>").addClass("like").attr({src:"resources/img/plus.png",width:40,height:32}).attr("id",cntl);
				    		    	    				 var div1 = $("<div></div>").addClass("card-figure");
				    		    	    				 var div2 = $(div1).append(
				    		    	    						 img1,
				    		    								$("<div class='card-content'></div>").append(
				    		    								img2,
				    		    								$("<div></div>").addClass("viewname").html(g.pointview_name),
				    		    								$("<div></div>").addClass("text").html(g.pointview_topinfo),
				    		    								$("<div></div>").addClass("hashtag").html(g.pointview_hashtag) ,
				    		    								$("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x"),
				    		    								$("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y"),
				    		    								$("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no"),
				    		    								$("<div></div>").html(  g.pointview_image1   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img")
				    		    							).attr("idx",i)
				    		    							);
				    		    							$(".card-column").append(div2);	
				    		    							 $("#"+cntl).click(function(){
				    					    					 var idx = $(this).attr("idx");
				    					    					 
				    					    					// $(div ).remove(event.currentTarget.div);
				    					    					 $("#idx"+i).remove();
				    					    					 $(this).parent().remove();
				    					    					 $(this).parent().parent().remove();

				    					    					 $(img1).remove();
				    					    					 $(div1).remove();
				    					    					 
				    					    					 
				    					    					 
				    					    							var div = $("<div></div>").addClass("list").attr("idp",i);
				    					    							var div_info = $("<div></div>").addClass("list_info");
				    					    							var div_img = $("<div></div>").addClass("list_div_img");
				    					    							var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+i);
				    					    							var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
				    					    							$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.pointview_image1}).addClass("list_img"));
				    					    							var pimg =  $("<div></div>").html(  g.pointview_image1    ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");
				    					    							var x =  $("<div></div>").html(  g.pointview_location_X   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
				    					    							var y =  $("<div></div>").html(  g.pointview_location_Y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y");
				    					    							$(div).append( div_img );
				    					    							$(div_info).append(  can  ); 
				    					    							$(div).append( pointno   );
				    					    							$(div).append( pimg   );
				    					    							$(div).append( x   );
				    					    							$(div).append( y   );

				    					    							$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name    ).addClass("list_name")); 
				    					    							$(div_info).append(    $("<div></div>").html( g.pointview_addr    ).addClass("list_addr")); 
				    					    							$(div).append( div_info );
				    					    							$(div).append(    $("<div></div>").html(  g.plannote_no   ).css({"font-size":"0.1rem","display":"none"})); 
				    					    							$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
				    					    							//$( "#"+i ).draggable();
				    					    							//$(div).append(img); 
				    					    							$("#sl").append(div); 
				    					    							
				    					    							
				    					    							
				    					    							// $(div).click(function(){ 
				    					    							   $(cancel).click(function(){
				    					    									selectDiv = $(this);
				    					    									selectDiv.splice(i,1);
				    					    									$(div).remove();
				    					    								});
				    					    				 
				    					    							   
				    						    					
				    						    				});
				    									
				    									
				    									$(div).remove();
				    								});
				    				 
				    							   
					    					
					    				});
		    				
		    				
	    				 
	    			 });
	    			 
	    		 }});
	  			
	  			 
		 }
function loadplan2(){
	$("#hi").append($("<h3></h3>").html( "좋아요 목록에서 원하는 일정을 선택하세요." ).addClass("h1css2"));
			
	let plan_no = $('#plan_no').data('planno');		 
	var data={plannote_datecnt:plannote_datecnt,plan_no:plan_no};
	//alert(plannote_datecnt);
	//alert(plan_no);
	//$("#hi").removeClass("h1css1");
	$.ajax({url:"planlinelist2.do",data:data,success:function(data){
	 //$.ajax("planlinelist.do",{success:function(data){
      if(first ==1){
		$("#day1").addClass("over");
		plannote_datecnt=1;
	}
	first++;
				 var planArr=eval("("+data+")");
				 if(planArr == null){

				 
					 $("#h1").remove();
			     		$("#hi").addClass("h1css1");
			     	}else{

			     	
			     		$("#hi").append($("<h3></h3>").html( "좋아요 목록에서 원하는 일정을 선택하세요." ).addClass("h1css2"));
			     	}
			
				 $.each(planArr, function(i,g){ 
		            	
		            	plan_no =g.plan_no;
		            	plannote_datecnt = g.plannote_datecnt;
		            	plan_day=g.plan_day;
		            	
		            	
		            	
		            	
		            	//$("#day1").addClass("over");
		                    var day = plan_day+1;
		            		var div = $("<div></div>").addClass("list").attr("idp",i);
		            		var div_info = $("<div></div>").addClass("list_info");
		            		var div_img = $("<div></div>").addClass("list_div_img");
		            		
		            		
		            		//MAKE plan
		            		cnti = cnti+1;
		            		var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+cnti);
		            		var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
		            		var pimg =  $("<div></div>").html(  g.plannote_image  ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");
		            		var x =  $("<div></div>").html(  g.plannote_location_x   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
		            		var y =  $("<div></div>").html(  g.plannote_location_y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y")
		            		$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.plannote_image}).addClass("list_img")); 
		            		$(div).append( div_img );
		            		$(div_info).append(  can  ); 
		            		$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name    ).addClass("list_name")); 
		            		$(div_info).append(    $("<span></span>").html( g.pointview_addr    ).addClass("list_addr")); 
		            		$(div).append( div_info );
		            		$(div).append( pointno   ); 
		            		$(div).append( pimg   );
		            		$(div).append( x   );
		            		$(div).append( y   );
		            		$(div).append(    $("<span></span>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
		            		
		            		//$( "#"+i ).draggable();
		            		//$(div).append(img); 
		            		$("#sl").append(div); 
		            		
		            		 $( "#"+i  ).draggable({
		            			  connectToSortable: "#sl",
		            			  helper: "clone",
		            			  revert: "invalid"
		            			});
		            		 $( "#sl" ).sortable({
		            			  //revert: true
		            			});
		            		 $(div).click(function(){
 		             			
		            			 x = Number($("#map_x").html());
		               		  y = Number($("#map_y").html());
		               		  
		               		 //x=g.plannote_location_x;
		               		 // y=g.plannote_location_y;
		               			

		               		initMap(x,y);
		                		  
		                		 });
		            		// $(div).click(function(){ 
		            		   $("#cancel"+cnti).click(function(){
		            				selectDiv = $(this);
		            				selectDiv.splice(i,1);
		            				
		            				//MAKE LIKE
		            				 var img1=$("<img>").attr("src","resources/image/"+g.plannote_image);
		            				 cntl = cntl +1;
		    	    				 var img2 =$("<img/>").addClass("like").attr({src:"resources/img/plus.png",width:40,height:32}).attr("id",cntl);
		    	    				 var div1 = $("<div></div>").addClass("card-figure");
		    	    				 var div2 = $(div1).append(
		    	    						 img1,
		    								$("<div class='card-content'></div>").append(
		    								img2,
		    								$("<div></div>").addClass("viewname").html(g.pointview_name),
		    								$("<div></div>").addClass("text").html(g.pointview_topinfo),
		    								
		    								$("<div></div>").addClass("hashtag").html(g.pointview_hashtag) ,
		    								$("<div></div>").html(  g.plannote_location_x   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x"),
		    								$("<div></div>").html(  g.plannote_location_y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y"),
		    								$("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no"),
		    								$("<div></div>").html(  g.plannote_image   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img")
		    							).attr("idx",i)
		    							);
		    							$(".card-column").append(div2);	
		    							 $("#"+cntl).click(function(){
					    					 var idx = $(this).attr("idx");
					    					 
					    					// $(div ).remove(event.currentTarget.div);
					    					 $("#idx"+i).remove();
					    					 $(this).parent().remove();
					    					 $(this).parent().parent().remove();

					    					 $(img1).remove();
					    					 $(div1).remove();
					    					 
					    					 
					    					 
					    							var div = $("<div></div>").addClass("list").attr("idp",i);
					    							var div_info = $("<div></div>").addClass("list_info");
					    							var div_img = $("<div></div>").addClass("list_div_img");
					    							var can =  $("<img/>").attr({src:"resources/img/cancle.png"}).addClass("plan_addbtn").attr("id","cancel"+i);
					    							var pointno = $("<div></div>").html(  g.pointview_no   ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_no");
					    							var pimg =  $("<div></div>").html( g.plannote_image  ).css({"font-size":"0.1rem","display":"none"}).attr("id","point_img");
					    							var x =  $("<div></div>").html(  g.plannote_location_x   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_x");
					    							var y =  $("<div></div>").html(  g.plannote_location_y   ).css({"font-size":"0.1rem","display":"none"}).attr("id","map_y");
					    							
					    							$(div_img).append(    $("<img/>").attr({src:"resources/image/"+g.plannote_image}).addClass("list_img")); 
					    							
					    							$(div_info).append(  can  ); 
					    							
					    							$(div_info).append(    $("<div></div>").html( "관광지 :" + g.pointview_name    ).addClass("list_name")); 
					    							$(div_info).append(    $("<div></div>").html( g.pointview_addr    ).addClass("list_addr")); 
					    							$(div).append( div_img );
					    							$(div).append( div_info );
					    							$(div).append( pointno   );
					    							$(div).append( pimg   );
					    							$(div).append( x   );
					    							$(div).append( y   );

					    							$(div).append(    $("<div></div>").html(  g.plannote_no   ).css({"font-size":"0.1rem","display":"none"})); 
					    							$(div).append(    $("<div></div>").html(  g.plannote_order    ).css({"font-size":"0.1rem","display":"none"})); 
					    							//$( "#"+i ).draggable();
					    							//$(div).append(img); 
					    							$("#sl").append(div); 
					    							
					    							
					    							
					    							// $(div).click(function(){ 
					    							   $(can).click(function(){
					    									selectDiv = $(this);
					    									selectDiv.splice(i,1);
					    									$(div).remove();
					    								});
					    				 
					    							   
						    					
						    				});
			    				
		    							
		    							
		    							$(div).remove();
		            			});
		            		   
		            });
		           
		           
			 }});
			
		}	

		
function saveplan(saveplan){

			var cntdiv = document.querySelectorAll('[idp]').length;
			var j=0;
			var x = document.querySelectorAll("[idp]");
			 // x[0].find(".like").html;
			//alert("pointview_no"+pointview_no);
			//var savedata = [];
			var save=[];
			
			let plan_no = $('#plan_no').data('planno');
			let city_name = $('#city_name').data('cityname');
			let plan_name = $('#plan_name').data('planname');
			let plan_startday = $('#plan_startday').data('startday');
			let plan_endday = $('#plan_endday').data('endday');
			let plan_day = $('#plan_day').data('day');

			for(j=0 ; j < cntdiv ; j++){
				var location_x ='None'
				var location_y ='None'
				var length =x[j].querySelector(".list_name").innerHTML.length;
			
				var pointview_name = x[j].querySelector(".list_name").innerHTML.substr(5, length);
				//var pointview_img = x[j].querySelector(".list_img").innerHTML;
				var pointview_img = x[j].querySelector("#point_img").innerHTML;
				var pointview_addr = x[j].querySelector(".list_addr").innerHTML;
				var point_no = x[j].querySelector("#point_no").innerHTML;
				location_x = x[j].querySelector("#map_x").innerHTML;
				location_y = x[j].querySelector("#map_y").innerHTML;

				//alert(pointview_img);
				var plannote_order=j+1;
				//savedata.push({"plan_no":plan_no,"pointview_no":pointview_no,"pointview_name":pointview_name,"pointview_addr":pointview_addr,"plannote_image":pointview_img,"plannote_startday":plan_startday,"plannote_endday":plan_endday,"plannote_datecnt":plannote_datecnt,"plannote_order":plannote_order,"plan_name":plan_name,"city_name":city_name,"plan_day":plan_day});
				save.push({plan_no:plan_no,pointview_no:point_no,pointview_name:pointview_name,pointview_addr:pointview_addr,plannote_image:pointview_img,plannote_startday:plan_startday,plannote_endday:plan_endday,plannote_datecnt:plannote_datecnt,plannote_order:plannote_order,plan_name:plan_name,city_name:city_name,plan_day:plan_day,plannote_location_x:location_x,plannote_location_y:location_y});
				
				//var savedata={"plan_no":plan_no,"pointview_no":point_no,"pointview_name":pointview_name,"pointview_addr":pointview_addr,"plannote_image":pointview_img,"plannote_startday":plan_startday,"plannote_endday":plan_endday,"plannote_datecnt":plannote_datecnt,"plannote_order":plannote_order,"plan_name":plan_name,"city_name":city_name,"plan_day":plan_day};
				//$.ajax({url:"savePlannote",data:save,dataType:"json",type:"post",success:function(data){
				var savedata={"plan_no":plan_no,"pointview_no":point_no,"pointview_name":pointview_name,"pointview_addr":pointview_addr,"plannote_image":pointview_img,"plannote_startday":plan_startday,"plannote_endday":plan_endday,"plannote_datecnt":plannote_datecnt,"plannote_order":plannote_order,"plan_name":plan_name,"city_name":city_name,"plan_day":plan_day,"plannote_location_x":location_x,"plannote_location_y":location_y};
				}
				alert("저장이 완료되었습니다.");
				$.ajax({
			        type: 'POST',
			        url: 'http://203.236.209.93:5000/receiver',
			        //url: 'http://192.168.0.37:5000/receiver',
			        
			        data: JSON.stringify (save),
			        success: function(data) { 
			        	
			        
			        	/*setTimeout(function(){
			        
			    		$("#save_popup").removeClass("show");
			    		$("#save_success").css("display","none");
			    		},1000); 
			        	*/
			        	},
			        contentType: "application/json",
			        dataType: 'json'
			        });
				//$.ajax({url:"savePlannote",data:savedata,dataType:"xml",type:"post",success:function(data){
				//$.ajax({url:"savePlannote",data:save,dataType:"json",type:"post",success:function(data){
					
				//}});
			
			console.log(save);

			
			
			
			
		};
		
		
		
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

<div id="planbar-day">
	<div id="planbar-center">
		<ul>
		<c:forEach var="g" begin="1" end="${m.plan_day+1 }">
		
	 	   <li id="day${g }" onclick="dayChange(${g })" >Day${g }</li>
	 	  </c:forEach>

	    </ul>
	     <button class="savebtn" id="saveplan" onclick="saveplan(saveplan)" >SAVE</button>
	     <span style="color:red; font-weight:bolder; margin-left:-6px; font-size:16px;  " id="save_popup">*</span>
	</div>
</div>

<section style="margin-top:90px;">	
	<div class="top-img-sect">
		<img alt='' src='resources/image/${ m.getPlan_image()}'> 
		<div class="img_content">
		
			<h1>${m.getCity_name() }, 여행 일정 계획</h1>
			<p>
			"${m.getPlan_name() }"<br>
			${m.getPlan_startday() } - ${m.getPlan_endday() } (${m.getPlan_day() }박 ${m.getPlan_day()+1 }일)
			</p>
		
		</div>
	</div>
<div id="city_name" style="display: none;" data-cityname="${m.getCity_name()}"></div>
<div id="plan_name" style="display: none;" data-planname="${m.getPlan_name()}"></div>
<div id="plan_startday" style="display: none;" data-startday="${m.getPlan_startday()}"></div>
<div id="plan_endday" style="display: none;" data-endday="${m.getPlan_endday()}"></div>
<div id="plan_day" style="display: none;" data-day="${m.getPlan_day()}"></div>
<div id="plan_no" style="display: none;" data-planno="${m.getPlan_no()}"></div>
	
	<div class="center">
		<div class="howtoplan">
	      	<h4>일정 추가 방법</h4>
	        <p>원하는  Day를 선택 후 좋아요 목록이나 관광지 목록에서 <img src="resources/img/plus1.png" width="20px" height="20px">
	         	버튼을 클릭하시면 일정에 등록이 됩니다. 원하시는 순서에 드래그 하여 놓으신 후 저장 버튼을 눌러 주세요.
	        </p>
		</div>
		
		<div class="plan-content">
			<div class="plan-item" id="sl">
			  <h3 id="hi" >좋아요 목록에서 원하는 일정을 선택하세요.</h3>

			</div>
			<div  id="googleMap">
			<span id="map_xx" style="display:none;">m.getPlannote_location_x</span>
			<span id="map_yx" style="display:none; background-color: rgba(0,0,0,1);">m.getPlannote_location_y</span>
			</div>
		</div>
	</div>

    
	<div class="center">
		<h2>좋아요 목록</h2> 
		<div class="card-list">
			<div class="card-column" id="card-column" >
				
				
				
			</div>
		</div>
   
 
	<div class="center" style="margin-bottom: -80px;">
		<h2> 추천 관광지</h2> 
	</div>
	<div class="card-list">
			<div class="card-column1" id="card-column1" >
				
			</div>
		</div>
	<!--  
	<div id="save_popup">
		<i class="far fa-comment-alt" id="save_icon">
			<div id="save_text">저장 <span id="save_success">성공!</span></div>
		</i>
	</div>
	-->
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


 
<script>
//구글맵 스크립트
var kk = document.querySelectorAll("[idp]");
var x = Number($(kk[1]).find("#map_x").text());
var y = Number($(kk[1]).find("#map_y").text());
		function initMap(x,y) {
			if(x == undefined || x==NaN ||x==0){
   			 x = Number($("#map_xx").html());

   			 y = Number($("#map_yx").html());
			}else{
			//alert(x);
   			var map = new google.maps.Map(document.getElementById('googleMap'), {
			    zoom: 11,
			    center: new google.maps.LatLng(x,y)
   			    
			  });
			  setMarkers(map);
			
   			}
		}
			
	function setMarkers(map) 
	{
		  var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	      var labelIndex = 0;
	
			var arr = [];
			kk = document.querySelectorAll("[idp]");//여행지 
  
			for(j=0 ; j < kk.length ; j++){
				//x = Number($(kk[j]).find("#map_x").text());
				//y = Number($(kk[j]).find("#map_y").text());
				//console.log("x:"+x+",y:"+y);
				//title = $(kk[j]).find(".list_name").text();
				//arr.push({title:"a",x:35.658893, y:139.745434, z:4});
				//arr.push({title:"a",x:35.6664909146704, y:139.706169739365, z:4});
				//arr.push({title:"a",x:35.6711360605329, y:139.763506650924, z:4});
				arr.push([$(kk[j]).find(".list_name").text(), Number($(kk[j]).find("#map_x").text()), Number($(kk[j]).find("#map_y").text()), 4]);
				//arr.push({title:$(kk[j]).find(".list_name").text(),x:Number($(kk[j]).find("#map_x").text()), y:Number($(kk[j]).find("#map_y").text()), z:4});
				//arr.push({title:"a",x:x, y:y, z:4});
				
			}
			
			
		var image = {
		    url: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
		    // This marker is 20 pixels wide by 32 pixels high.
		    size: new google.maps.Size(20, 32),
		    // The origin for this image is (0, 0).
		    origin: new google.maps.Point(0, 0),
		    // The anchor for this image is the base of the flagpole at (0, 32).
		    anchor: new google.maps.Point(0, 32)
		  };
		  // Shapes define the clickable region of the icon. The type defines an HTML
		  // <area> element 'poly' which traces out a polygon as a series of X,Y points.
		  // The final coordinate closes the poly by connecting to the first coordinate.
		  var shape = {
		    coords: [1, 1, 1, 20, 18, 20, 18, 1],
		    type: 'poly'
		  };
		  for (var i = 0; i < arr.length; i++) {
		    var beach = arr[i];
		   // alert(Number(beach[1]));
		   /*
		    var marker = new google.maps.Marker({
		      position: {lat: beach.x, lng: beach.y},
		      map: map,
		      icon: image,
		      shape: shape,
		      title: beach.title,
		      zIndex: Number(beach.z)
		    });
		   */
		   if(Number(beach[1]) != 0){
			  // alert(arr);
		    var marker = new google.maps.Marker({
			      position: {lat: Number(beach[1]), lng: Number(beach[2])},
			      map: map,
			     // icon: image,
			     // shape: shape,
			      title: beach[0],
			      label: labels[labelIndex++ % labels.length],
			      zIndex: Number(beach[3])
			    });
		   }
		  }
		}
	//구글맵 스크립트
	
	

</script>


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyACdd9adVEmehZvnhemui7_lLOdKBgWXAM&callback=initMap" async defer></script>


</body>
</html>
